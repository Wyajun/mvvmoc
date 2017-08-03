//
//  PictureCropView.h
//  choosePicture
//
//  Created by tracy on 14-7-9.
//
//

#import <UIKit/UIKit.h>
//#import "UIImage+KIAdditions.h"
@class PictureCropMaskView;
@interface PictureCropView : UIView

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)PictureCropMaskView *maskView;
//@property(nonatomic, strong)UIImage *image;
@property(nonatomic, assign)UIEdgeInsets imageInset;
@property(nonatomic, assign)CGSize cropSize;
@property(nonatomic, assign)BOOL isArc;

- (void)setImage:(UIImage *)image;
- (void)setCropSize:(CGSize)size;
- (void)setFrame:(CGRect)frame isArc:(BOOL)isArc;

- (UIImage *)cropImage;


@end

@interface PictureCropMaskView : UIView

@property(nonatomic, assign)CGRect cropRect;
@property(nonatomic, assign)BOOL isArc;

- (void)setCropSize:(CGSize)size;
- (CGSize)cropSize;
- (void)setImage:(UIImage *)image;
@end

