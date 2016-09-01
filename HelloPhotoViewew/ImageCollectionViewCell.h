//
//  ImageCollectionViewCell.h
//  HelloPhotoViewew
//
//  Created by 張峻綸 on 2016/5/27.
//  Copyright © 2016年 張峻綸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;

@end
