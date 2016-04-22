//
//  SaveTools.h
//  Tools
//
//  Created by 蒋杏飞 on 15/8/11.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveTools : NSObject

+ (NSString *)pathWithName:(NSString *)name directory:(NSSearchPathDirectory)directory;

// 存储data
+ (BOOL)saveDataWith:(NSString *)name directory:(NSSearchPathDirectory)directory data:(NSData *)data;

// 获取data
+ (NSData *)readDataWithName:(NSString *)name directory:(NSSearchPathDirectory)directory;

@end








