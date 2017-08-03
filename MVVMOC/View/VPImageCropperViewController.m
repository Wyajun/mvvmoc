//
//  VPImageCropperViewController.m
//  VPolor
//
//  Created by Vinson.D.Warm on 12/30/13.
//  Copyright (c) 2013 Huang Vinson. All rights reserved.
//

#import "VPImageCropperViewController.h"
#import "PictureCropView.h"
#import "UIViewController+Push.h"
#import "VPIImageCropperData.h"
#define SCALE_FRAME_Y 100.0f
#define BOUNDCE_DURATION 0.3f
#define bntHeight KButHeight*2
@interface VPImageCropperViewController ()

@property (nonatomic, retain) UIImage *originalImage;
@property (nonatomic, assign) CGFloat limitRatio;
@property (nonatomic, assign) CGRect latestFrame;
@property(nonatomic, strong) PictureCropView *cropImageView;
@property(nonatomic,strong)VPIImageCropperData *CropperData;

@end

@implementation VPImageCropperViewController

- (void)dealloc {
    self.originalImage = nil;
}

- (id)initWithImage:(UIImage *)originalImage cropFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio {
    self = [super init];
    if (self) {
        self.cropFrame = cropFrame;
        self.limitRatio = limitRatio;
        self.originalImage = originalImage;
        self.title = @"编辑";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.CropperData = self.parameter;
    if (self.CropperData) {
        self.cropFrame = self.CropperData.cropFrame;
        self.limitRatio = self.CropperData.limitScaleRatio;
        self.originalImage = self.CropperData.image;
        self.delegate = self.CropperData.delegate;
    }
    [self initView];
    [self initControlBtn];
    [self showDefaultLeftButton];
}
-(void)leftBarButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:self];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}

- (void)initView {
    
    self.view.backgroundColor = [UIColor blackColor];
    CGRect frame = CGRectMake(0, 0, kScreenWidth, [UIScreen mainScreen].bounds.size.height - bntHeight);
    
    PictureCropView *cropImageView = [[PictureCropView alloc] initWithFrame:frame];
     cropImageView.isArc = self.CropperData.isArc;
    [cropImageView setCropSize:CGSizeMake(self.cropFrame.size.width, self.cropFrame.size.height)];
    self.cropImageView = cropImageView;
    [self.view addSubview:cropImageView];
    self.cropImageView.image = self.originalImage;
}

- (void)initControlBtn {
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - bntHeight, 70, bntHeight)];
    [cancelBtn setTitle:@"重选" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [cancelBtn.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:cancelBtn];
    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-100, self.view.frame.size.height - bntHeight, 100, bntHeight)];
    [confirmBtn setTitle:@"使用照片" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [confirmBtn.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:confirmBtn];
    
//    UIView *lineView = [[UIView alloc] init];
//    [lineView setBackgroundColor:[UIColor whiteColor]];
//    [confirmBtn addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.top.mas_equalTo(0);
//        make.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(.5);
//        
//    }];
    
}

- (void)cancel:(id)sender {
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(VPImageCropperDelegate)]) {
        [self.delegate imageCropperDidCancel:self];
    }
}

- (void)confirm:(id)sender {
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(VPImageCropperDelegate)]) {
        [self.delegate imageCropper:self didFinished:[_cropImageView cropImage]];
    }
}

@end
