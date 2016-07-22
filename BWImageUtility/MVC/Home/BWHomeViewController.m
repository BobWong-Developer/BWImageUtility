//
//  BWHomeViewController.m
//  BWImageUtility
//
//  Created by BobWong on 16/7/22.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWHomeViewController.h"
#import "BWPreviewImageViewController.h"
#import "BWImageSelectionViewController.h"

NSString *const kTitlePreviewImage = @"Preview Image";
NSString *const kTitleImageSelection = @"Image Selection";

@interface BWHomeViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_dataSource;
}

@end

@implementation BWHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"BWImageUtility";
    
    _dataSource = @[kTitlePreviewImage, kTitleImageSelection];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *title = _dataSource[indexPath.row];
    UIViewController *nextVC;
    if ([title isEqualToString:kTitlePreviewImage]) {
        nextVC = BWPreviewImageViewController.new;
    }
    else if ([title isEqualToString:kTitleImageSelection]) {
        nextVC = BWImageSelectionViewController.new;
    }
    
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
