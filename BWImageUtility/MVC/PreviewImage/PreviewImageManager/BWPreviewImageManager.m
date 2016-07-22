//
//  BWPreviewImageManager.m
//  BWImageUtility
//
//  Created by BobWong on 16/7/22.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWPreviewImageManager.h"
#import "BMZoomingImageView.h"

@interface BWPreviewImageManager ()

@property (nonatomic, weak) UIView *viewOfController;  //!< Controller的View
@property (nonatomic, strong) UIView *viewContainer;  //!< 容器View
@property (nonatomic, strong) BMZoomingImageView *viewZoomingImage;  //!< 缩放图像的View

@end

@implementation BWPreviewImageManager

- (instancetype)initWithControllerView:(UIView *)view
{
    if (self = [super init]) {
        _viewOfController = view;
        _show = NO;
        
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    UIView *viewContainer = [[UIView alloc] initWithFrame:self.viewOfController.bounds];
    self.viewContainer = viewContainer;
    [self.viewOfController addSubview:viewContainer];
    
    UIToolbar *toolBarBg = [[UIToolbar alloc] initWithFrame:viewContainer.bounds];
    toolBarBg.barStyle = UIBarStyleDefault;
    toolBarBg.alpha = 0.9;
    [viewContainer addSubview:toolBarBg];
    
    
    BMZoomingImageView *viewZoomingImage = [[BMZoomingImageView alloc] initWithFrame:viewContainer.bounds];
    self.viewZoomingImage = viewZoomingImage;
    viewZoomingImage.backgroundColor = [UIColor clearColor];
    viewZoomingImage.userInteractionEnabled = YES;
    [viewZoomingImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelPreview)]];
    [viewContainer addSubview:viewZoomingImage];
}

- (void)previewImage:(UIImage *)image
{
    if (!image) {
        return ;
    }
    
    UIView *viewContainer = self.viewContainer;
    
    CGRect bounds;
    CGSize size_image = image.size;
    CGFloat width_c = CGRectGetWidth(viewContainer.frame);
    CGFloat height_c = CGRectGetHeight(viewContainer.frame);
    if (size_image.width >= size_image.height) {
        bounds = CGRectMake(0, 0, width_c, width_c);
    } else {
        bounds = CGRectMake(0, 0, width_c, height_c);
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.bounds = bounds;
    imageView.center = CGPointMake(CGRectGetMidX(viewContainer.bounds), CGRectGetMidY(viewContainer.bounds));
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.viewZoomingImage.imageView = imageView;
    
    [self.viewOfController addSubview:viewContainer];
    
    _show = YES;
    if (_vcShow) {
        _vcShow.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)cancelPreview
{
    [self.viewContainer removeFromSuperview];
    _show = NO;
    if (_vcShow) {
        _vcShow.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    if (self.blockCancelPreview) {
        self.blockCancelPreview();
    }
}

@end
