//
//  DataManager.h
//  HelloPhotoViewew
//
//  Created by 張峻綸 on 2016/5/27.
//  Copyright © 2016年 張峻綸. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
@interface DataManager : NSObject

+(instancetype)sharedInstanse;

-(NSInteger) getTotal;
-(NSString*) getFilenameByIndex:(NSInteger)index;
-(UIImage*) getImageByIndex:(NSInteger)index;
@end
