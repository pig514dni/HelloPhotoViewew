//
//  DataManager.m
//  HelloPhotoViewew
//
//  Created by 張峻綸 on 2016/5/27.
//  Copyright © 2016年 張峻綸. All rights reserved.
//

#import "DataManager.h"
// stasic在程式一執行時就先在記憶體裡創造出_singletonDataManager
// 之後直到APP被消滅才會在記憶體釋放掉
//使用方法 DataManager *dataManager =
//                    [DataManager sharedInstance]
static DataManager *_singletonDataManager;
    
@implementation DataManager
{
    NSMutableArray *datas;
}
+(instancetype)sharedInstanse{

    if(_singletonDataManager== nil){
        _singletonDataManager=[DataManager new];
        [_singletonDataManager loadDatas];
    }
    return _singletonDataManager;
}

-(void)loadDatas{
    datas = [NSMutableArray new];
    for (int i=1; i<11; i++) {
        NSString *filename=[NSString stringWithFormat:@"cat%d.jpg",i];
          [datas addObject:filename];
    }
}
-(NSInteger) getTotal{
    return datas.count;
}
-(NSString*) getFilenameByIndex:(NSInteger)index{
    return datas[index];
}
-(UIImage*) getImageByIndex:(NSInteger)index{
    NSString *filename=[self getFilenameByIndex:index];
    return [UIImage imageNamed:filename];
}

@end
