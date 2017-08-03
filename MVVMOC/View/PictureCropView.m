//
//  mainView.m
//  choosePicture
//
//  Created by tracy on 14-7-9.
//
//

#import "PictureCropView.h"

//#define CircleR 145

@interface PictureCropView()<UIScrollViewDelegate>

@property (nonatomic, strong)UIView *bgView;

@end


@implementation PictureCropView

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.bgView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:_bgView];
    [[self scrollView] setFrame:self.bounds];
    [[self maskView] setFrame:self.bounds];
    
    if (CGSizeEqualToSize(_cropSize, CGSizeZero)) {
        [self setCropSize:CGSizeMake(100, 100)];
    }
}

- (void)setFrame:(CGRect)frame isArc:(BOOL)isArc
{
    [super setFrame:frame];
    self.bgView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:_bgView];
    _isArc = isArc;
    [[self scrollView] setFrame:self.bounds];
    [[self maskView] setFrame:self.bounds];

    if (CGSizeEqualToSize(_cropSize, CGSizeZero)) {
        [self setCropSize:CGSizeMake(100, 100)];
    }
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.bounces = YES;
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_bgView addSubview:_scrollView];
        _scrollView.backgroundColor = viewBackColorf3;
    }
    return _scrollView;
}
- (UIImageView *)imageView {
    
    if (_imageView == nil) {
        
        _imageView = [[UIImageView alloc] init];
        [[self scrollView] addSubview:_imageView];
        _imageView.userInteractionEnabled = YES;
//        UIRotationGestureRecognizer *rotateGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateImage:)];
//        [_imageView addGestureRecognizer:rotateGes];
    }
    
    return _imageView;
}
- (PictureCropMaskView *)maskView {
    if (_maskView == nil) {
        _maskView = [[PictureCropMaskView alloc] init];
        [_maskView setBackgroundColor:[UIColor clearColor]];
        [_maskView setUserInteractionEnabled:NO];
        [self addSubview:_maskView];
        [self bringSubviewToFront:_maskView];
    }
    _maskView.isArc = _isArc;
    return _maskView;
}

- (void)setImage:(UIImage *)image {
//    _image = image;
    [[self imageView] setImage:image];
    [self updateZoomScale:image];
}
- (void)updateZoomScale:(UIImage *)image {
    CGFloat width = 0;
    CGFloat height = 0;
    if (image.size.height / _cropSize.height  >= image.size.width / _cropSize.width) {
        width = _cropSize.width;
        height = image.size.height * (width / image.size.width);
    }else{
        height = _cropSize.height;
        width = image.size.width * (height / image.size.height);
    }
    NSLog(@"width:%f height:%f",width,height);
    [[self imageView] setFrame:CGRectMake(0, 0, width , height)];
//    
//    CGFloat xScale = _cropSize.width / width;
//    CGFloat yScale = _cropSize.height / height;
    
//    CGFloat min = MAX(xScale, yScale);
    CGFloat max = 1.0;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        max = 1.0 / [[UIScreen mainScreen] scale];
    }
    
//    if (min > max) {
//        min = max;
//    }

    [[self scrollView] setMinimumZoomScale:1];
    [[self scrollView] setMaximumZoomScale:max + 5.0f];
    
    [[self scrollView] setZoomScale:1.0 animated:YES];
//    [self scrollView].contentOffset = CGPointMake((width - _scrollView.bounds.size.width) / 2, (height  - _scrollView.bounds.size.height) / 2);
}


- (void)setCropSize:(CGSize)size {
    _cropSize = size;
//    [self updateZoomScale];
    
    CGFloat width = _cropSize.width;
    CGFloat height = _cropSize.height;
    
    CGFloat x = (CGRectGetWidth(self.bounds) - width) / 2;
    CGFloat y = (CGRectGetHeight(self.bounds) - height) / 2;
    
    [[self maskView] setCropSize:_cropSize];
    
    CGFloat top = y;
    CGFloat left = x;
    CGFloat right = CGRectGetWidth(self.bounds)- width - x;
    CGFloat bottom = CGRectGetHeight(self.bounds)- height - y;
    _imageInset = UIEdgeInsetsMake(top, left, bottom, right);
    [[self scrollView] setContentInset:_imageInset];

    [[self scrollView] setContentOffset:CGPointMake(0, 0)];
}


- (UIImage *)cropImage {

    UIGraphicsBeginImageContextWithOptions(_bgView.bounds.size, YES, 0);


    [[_bgView layer] renderInContext:UIGraphicsGetCurrentContext()];

    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    CGImageRef imageRef = viewImage.CGImage;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGRect rect = CGRectMake((_bgView.center.x - _cropSize.width/2)*scale, (_bgView.center.y - _cropSize.height/2)*scale, _cropSize.width*scale, _cropSize.height*scale);

    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);
    return image;
}

#pragma UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [self imageView];
}
float _lastRotation = 0.0;
- (void)rotateImage:(UIRotationGestureRecognizer *)sender
{
    if([sender state] == UIGestureRecognizerStateEnded) {
        
        _lastRotation = 0.0;
        return;
    }
    
    CGFloat rotation = -_lastRotation + [sender rotation];
    
    CGAffineTransform currentTransform = _imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    [_imageView setTransform:newTransform];
    
    _lastRotation = [sender rotation];
    
}
@end

#pragma KISnipImageMaskView

#define kMaskViewBorderWidth 2.0f

@implementation PictureCropMaskView

- (void)setCropSize:(CGSize)size {
    CGFloat x = (CGRectGetWidth(self.bounds) - size.width) / 2;
    CGFloat y = (CGRectGetHeight(self.bounds) - size.height) / 2;
    _cropRect = CGRectMake(x, y, size.width, size.height);
    
    [self setNeedsDisplay];
}

- (CGSize)cropSize {
    return _cropRect.size;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.9);
    CGContextFillRect(ctx, self.bounds);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor clearColor].CGColor);
    CGContextStrokeRectWithWidth(ctx, _cropRect, kMaskViewBorderWidth);
    
    CGContextClearRect(ctx, _cropRect);

    if (_isArc) {
        CGContextAddRect(ctx, _cropRect);
        CGContextAddArc(ctx, _cropRect.origin.x + _cropRect.size.width * 0.5, _cropRect.origin.y + _cropRect.size.height * 0.5, _cropRect.size.width * 0.5, 0, M_PI * 2, 1);
        CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.9);
    }
    CGContextSetBlendMode(ctx, kCGBlendModeDifference);
    CGContextFillPath(ctx);
}

- (void)dealloc
{
    NSLog(@"PictureCropView dealloc");
}

@end


