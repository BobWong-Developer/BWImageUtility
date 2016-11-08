//
//  BWAlbumImagesViewController.m
//  BWImageUtility
//
//  Created by BobWong on 16/7/22.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWAlbumImagesViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "BWAlbumCell.h"


@interface BWPhotoPickerGroup : NSObject

@property (nonatomic, strong) ALAssetsGroup *group;  ///< ALAssetsGroup
@property (nonatomic, strong) NSString *groupName;  ///< ALAssetsGroupPropertyName
@property (nonatomic, assign) NSInteger assetsCount;  ///< Assets Count
@property (nonatomic, strong) UIImage *thumbImage;  ///< posterImage

@end

@implementation BWPhotoPickerGroup

@end


@interface BWAlbumImagesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSoucre;

@end

@implementation BWAlbumImagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied) {
        // 判断没有权限获取用户相册的话，就提示个View
        NSLog(@"没有权限");
    }
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    NSMutableArray *groups = [NSMutableArray array];
    self.dataSoucre = groups;
    
    ALAssetsLibraryGroupsEnumerationResultsBlock resultBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            
//            // 包装一个模型来赋值
//            ZLPhotoPickerGroup *pickerGroup = [[ZLPhotoPickerGroup alloc] init];
//            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
//            pickerGroup.group = group;
//            pickerGroup.groupName = [group valueForProperty:@"ALAssetsGroupPropertyName"];
//            pickerGroup.thumbImage = [UIImage imageWithCGImage:[group posterImage]];
//            pickerGroup.assetsCount = [group numberOfAssets];
//            [groups addObject:pickerGroup];
            
            BWPhotoPickerGroup *pickerGroup = [[BWPhotoPickerGroup alloc] init];
            [group setAssetsFilter:[ALAssetsFilter allAssets]];
            pickerGroup.group = group;
            pickerGroup.groupName = [group valueForProperty:@"ALAssetsGroupPropertyName"];
            pickerGroup.assetsCount = group.numberOfAssets;
            pickerGroup.thumbImage = [UIImage imageWithCGImage:[group posterImage]];
            [_dataSoucre addObject:pickerGroup];
        }else{
            NSLog(@"has finished groups: %@", groups);
//            self.dataSoucre = groups;
            [self.tableView reloadData];
        }
    };
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:resultBlock failureBlock:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSoucre.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"BWAlbumCell";
    BWAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BWAlbumCell class]) owner:nil options:nil] firstObject];
    }
    
    BWPhotoPickerGroup *groupPicker = _dataSoucre[indexPath.row];
    cell.ivPoster.image = groupPicker.thumbImage;
    cell.lbName.text = groupPicker.groupName;
    cell.lbCount.text = @(groupPicker.assetsCount).stringValue;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    BWPhotoPickerGroup *groupPicker = _dataSoucre[indexPath.row];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    [groupPicker.group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
//        UIImage *image = [UIImage imageWithCGImage:result.defaultRepresentation.fullResolutionImage];
        UIImage *image = [UIImage imageWithCGImage:result.thumbnail];
        NSLog(@"index of %u in group is %@", index, image);
        
        if (arrayM) {
            [arrayM addObject:result];
        }
        
    }];
    
    NSLog(@"arrayM is %@", arrayM);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150.0;
}

@end
