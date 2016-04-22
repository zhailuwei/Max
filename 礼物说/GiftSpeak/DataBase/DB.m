//
//  DB.m
//  DataBase
//
//  Created by 蒋杏飞 on 15/8/14.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "DB.h"


static sqlite3 *dbPoint = nil;

@implementation DB
// 将bundle中的数据库拷贝到library中进行操作
+ (sqlite3 *)dbOpen
{
    if (dbPoint) {
        return dbPoint;
    }
    NSString *source = [[NSBundle mainBundle] pathForResource:@"GiftB" ofType:@"rdb"];
    NSString *destination = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    destination = [NSString stringWithFormat:@"%@/%@", destination, @"bb.db"];
    
    NSLog(@"des = %@", destination);
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:destination]) {
        [manager copyItemAtPath:source toPath:destination error:nil];
    }
    sqlite3_open([destination UTF8String], &dbPoint);
    return dbPoint;
}

+ (void)dbClose
{
    sqlite3_close(dbPoint);
}

@end






