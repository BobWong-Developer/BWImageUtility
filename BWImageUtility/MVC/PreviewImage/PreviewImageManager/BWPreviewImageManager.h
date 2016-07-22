//
//  BWPreviewImageManager.h
//  BWImageUtility
//
//  Created by BobWong on 16/7/22.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWPreviewImageManager : NSObject

@property (nonatomic, weak) UIViewController *vcShow;  //!< 当前显示图片预览所在的vc
@property (nonatomic, assign, readonly, getter = isShow) BOOL show;  //!< 是否为显示状态
@property (nonatomic, copy) dispatch_block_t blockCancelPreview;  //!< 取消预览时调用的Block

- (instancetype)initWithControllerView:(UIView *)view;
- (void)previewImage:(UIImage *)image;
- (void)cancelPreview;

@end
