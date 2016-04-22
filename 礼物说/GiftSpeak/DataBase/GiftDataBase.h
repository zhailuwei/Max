//
//  GiftDataBase.h
//  GiftSpeak
//
//  Created by dllo on 15/9/6.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SaveModel;
@interface GiftDataBase : NSObject
+ (BOOL)insertWithModel:(SaveModel *)model;
+ (NSArray *)selectAll;

+ (SaveModel *)selectWith:(NSString *)myUrl;
+ (void)deleteWithCityModel1:(SaveModel *)model;

@end
