//
//  BWAlbumCell.h
//  BWImageUtility
//
//  Created by BobWong on 16/11/8.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWAlbumCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ivPoster;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@end
