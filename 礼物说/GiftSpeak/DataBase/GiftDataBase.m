//
//  GiftDataBase.m
//  GiftSpeak
//
//  Created by dllo on 15/9/6.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "GiftDataBase.h"
#import "SaveModel.h"
#import "DB.h"

@implementation GiftDataBase
+ (BOOL)insertWithModel:(SaveModel *)model
{
    // 第一步：获得数据库指针
    sqlite3 *db = [DB dbOpen];
    
    // 第二步：获得数据库语句
    NSString *str = [NSString stringWithFormat:@"insert into Gift(cover_image_url, title,url) values('%@', '%@', '%@')", model.cover_image_url, model.title, model.url];
    
    // 第三步：执行sql语句
    int result = sqlite3_exec(db, [str UTF8String], nil, nil, nil);
    NSLog(@"%d", result);
    if (result == SQLITE_OK) {
        NSLog(@"执行成功");
        return YES;
    } else {
        NSLog(@"执行失败");
        return NO;
    }
}


// 查询：1.查询所有的数据 2.查询单个的
+ (NSArray *)selectAll
{
    // 获得数据库指针
    sqlite3 *db = [DB dbOpen];
    // 定义数据库替身
    sqlite3_stmt *stmt = nil;
    // 数据库语句
    NSString *str = [NSString stringWithFormat:@"select * from Gift"];
    // 执行
    int result = sqlite3_prepare_v2(db, [str UTF8String], -1, &stmt, nil);
    
    NSMutableArray *array = [NSMutableArray array];
    NSLog(@"1111%d", result);
    if (result == SQLITE_OK) {
        // 判断是否有下一行数据可用于读取
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *Gcover_image_url = sqlite3_column_text(stmt, 0);
            const unsigned char *Gtitle = sqlite3_column_text(stmt, 1);
            const unsigned char *Gurl = sqlite3_column_text(stmt, 2);
            
            NSString *G_cover_image_url = [NSString stringWithUTF8String:(const char *)Gcover_image_url];
            NSString *G_title = [NSString stringWithUTF8String:(const char *)Gtitle];
            NSString *G_url = [NSString stringWithUTF8String:(const char *)Gurl];
            
            SaveModel *model = [[SaveModel alloc] init];
            
            model.cover_image_url = G_cover_image_url;
            model.title = G_title;
            model.url = G_url;
            
            [array addObject:model];
        }
    }
    sqlite3_finalize(stmt);
    return array;
}


+ (SaveModel *)selectWith:(NSString *)myUrl
{
    // 获得数据库指针
    sqlite3 *db = [DB dbOpen];
    // 定义数据库替身
    sqlite3_stmt *stmt = nil;
    // 数据库语句
    NSString *str = [NSString stringWithFormat:@"select * from Gift where url = '%@'", myUrl];
    // 执行
    int result = sqlite3_prepare_v2(db, [str UTF8String], -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        // 判断是否有下一行数据可用于读取
        if (sqlite3_step(stmt) == SQLITE_ROW) {

            const unsigned char *Gcover_image_url = sqlite3_column_text(stmt, 0);
            const unsigned char *Gtitle = sqlite3_column_text(stmt, 1);
            const unsigned char *Gurl = sqlite3_column_text(stmt, 2);
            
            NSString *G_cover_image_url = [NSString stringWithUTF8String:(const char *)Gcover_image_url];
            NSString *G_title = [NSString stringWithUTF8String:(const char *)Gtitle];
            NSString *G_url = [NSString stringWithUTF8String:(const char *)Gurl];
            
            
            SaveModel *model = [[SaveModel alloc] init];
            
            model.cover_image_url = G_cover_image_url;
            model.title = G_title;
            model.url = G_url;
            
            sqlite3_finalize(stmt);
            return model;
        }
    }
    sqlite3_finalize(stmt);
    return nil;
    
}

+ (void)deleteWithCityModel1:(SaveModel *)model
{
    sqlite3 *db1 = [DB dbOpen];
    
    NSString *str1 = [NSString stringWithFormat:@"delete from Gift where title = '%@'",model.title];
    NSLog(@"%@", str1);
    int result1 = sqlite3_exec(db1, [str1 UTF8String], nil, nil, nil);
    NSLog(@"2222%d", result1);
    
    if (result1 == SQLITE_OK) {
        
        NSLog(@"%d", result1);
        
        
        NSLog(@"执行成功");
    }else{
        NSLog(@"执行失败");
    }
}
@end
