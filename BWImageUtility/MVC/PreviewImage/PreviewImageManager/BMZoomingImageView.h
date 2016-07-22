//
//  BMZoomingImageView.h
//  BMBlueMoonAngel
//
//  Created by BobWong on 16/6/29.
//  Copyright © 2016年 elvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMZoomingImageView : UIView

@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, readonly) BOOL isViewing;

@end
