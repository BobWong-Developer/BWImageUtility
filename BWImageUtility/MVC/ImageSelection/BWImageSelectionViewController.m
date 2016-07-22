//
//  BWImageSelectionViewController.m
//  BWImageUtility
//
//  Created by BobWong on 16/7/22.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWImageSelectionViewController.h"
#import "BWAlbumImagesViewController.h"

NSString *const kTitleTakePhoto = @"Take Photo";
NSString *const kTitleSelectFromAlbum = @"Select From Album";

@interface BWImageSelectionViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageViewSingle;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAlbum;

@end

@implementation BWImageSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Image Selection";
}

- (IBAction)buttonActSelectSingle:(UIButton *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Image Select" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:kTitleTakePhoto, kTitleSelectFromAlbum, nil];
    [actionSheet showInView:self.view];
}

- (IBAction)buttonActSelectAlbum:(UIButton *)sender
{
    BWAlbumImagesViewController *controllerAlbum = [[BWAlbumImagesViewController alloc] init];
    UINavigationController *nvgtVCAlbum = [[UINavigationController alloc] initWithRootViewController:controllerAlbum];
    [self.navigationController presentViewController:nvgtVCAlbum animated:YES completion:nil];
}

#pragma mark - Select Single Image

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *controllerPicker = [[UIImagePickerController alloc] init];
    controllerPicker.delegate = self;
//    controllerPicker.allowsEditing = YES;
    
    // 权限检查
    // Some Code
    
    NSString *titleButton = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([titleButton isEqualToString:kTitleTakePhoto]) {
        controllerPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if ([titleButton isEqualToString:kTitleSelectFromAlbum]) {
        controllerPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self.navigationController presentViewController:controllerPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *imageSelected = info[UIImagePickerControllerOriginalImage];
    _imageViewSingle.image = imageSelected;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        NSData *data_png = UIImagePNGRepresentation(imageSelected);
        NSData *data_jpg_1 = UIImageJPEGRepresentation(imageSelected, 1.0);
        NSData *data_jpg_2 = UIImageJPEGRepresentation(imageSelected, 0.5);
        NSData *data_jpg_3 = UIImageJPEGRepresentation(imageSelected, 0);
        
        NSLog(@"data png is %lu byte", data_png.length);
        NSLog(@"data jpg1 is %lu byte", data_jpg_1.length);
        NSLog(@"data jpg2 is %lu byte", data_jpg_2.length);
        NSLog(@"data jpg3 is %lu byte", data_jpg_3.length);
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -

@end
