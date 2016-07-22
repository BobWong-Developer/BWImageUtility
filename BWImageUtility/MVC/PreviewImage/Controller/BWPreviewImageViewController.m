//
//  BWPreviewImageViewController.m
//  BWImageUtility
//
//  Created by BobWong on 16/7/22.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWPreviewImageViewController.h"
#import "BWPreviewImageManager.h"

@interface BWPreviewImageViewController ()

@property (nonatomic, strong) BWPreviewImageManager *managerPreviewImage;

@end

@implementation BWPreviewImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Preview Image";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIImageView *imageViewPortrait = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"show_landscape"]];
    imageViewPortrait.contentMode = UIViewContentModeScaleAspectFit;
    imageViewPortrait.userInteractionEnabled = YES;
    [imageViewPortrait addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToPreviewImage:)]];
    [self.view addSubview:imageViewPortrait];
    
    UIImageView *imageViewLandscape = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"show_portrait"]];
    imageViewLandscape.contentMode = UIViewContentModeScaleAspectFit;
    imageViewLandscape.userInteractionEnabled = YES;
    [imageViewLandscape addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToPreviewImage:)]];
    [self.view addSubview:imageViewLandscape];

    CGFloat width_iv = 100;
    CGFloat space = 20;
    [imageViewPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(space);
        make.top.mas_equalTo(space);
        make.width.mas_equalTo(width_iv);
        make.height.mas_equalTo(width_iv);
    }];
    [imageViewLandscape mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageViewPortrait.mas_right).offset(space);
        make.top.mas_equalTo(space);
        make.width.mas_equalTo(width_iv);
        make.height.mas_equalTo(width_iv);
    }];
    
    
    /*
     UIImage，对比新创建和在UIImageView中的大小，png格式
     理论用途：确保预览的图片和原图是一样的
     测试结果：大小是一样的
     */
    UIImage *image = [UIImage imageNamed:@"show_landscape"];
    UIImage *image1 = imageViewPortrait.image;
    
    NSData *data_png = UIImagePNGRepresentation(image);
    NSData *data_png1 = UIImagePNGRepresentation(image1);
    
    NSLog(@"image png data is %lu", data_png.length);
    NSLog(@"image png1 data is %lu", data_png1.length);
}

- (void)tapToPreviewImage:(UITapGestureRecognizer *)tapGR
{
    UIImageView *imageView = (UIImageView *)tapGR.view;
    
    [self.managerPreviewImage previewImage:imageView.image];
}

- (BWPreviewImageManager *)managerPreviewImage
{
    if (!_managerPreviewImage) {
        _managerPreviewImage = [[BWPreviewImageManager alloc] initWithControllerView:self.view];
        _managerPreviewImage.vcShow = self;
    }
    return _managerPreviewImage;
}

@end
