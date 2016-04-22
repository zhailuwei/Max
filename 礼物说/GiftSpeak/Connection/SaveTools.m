//
//  SaveTools.m
//  Tools
//
//  Created by 蒋杏飞 on 15/8/11.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SaveTools.h"

@implementation SaveTools

+ (NSString *)pathWithName:(NSString *)name directory:(NSSearchPathDirectory)directory
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) firstObject];
    path = [NSString stringWithFormat:@"%@/%@", path, name];
    return path;
}

// 存字符串
+ (BOOL)saveWithName:(NSString *)name directory:(NSSearchPathDirectory)directory value:(NSString *)value
{
    NSString *path = [SaveTools pathWithName:name directory:directory];
    return [value writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
+ (NSString *)readWithName:(NSString *)name directory:(NSSearchPathDirectory)directory
{
    NSString *path = [SaveTools pathWithName:name directory:directory];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return str;
}


+ (BOOL)saveDataWith:(NSString *)name directory:(NSSearchPathDirectory)directory data:(NSData *)data
{
    NSString *currentName = [SaveTools fileNameWith:name];
    NSString *path = [SaveTools pathWithName:currentName directory:directory];
    return [data writeToFile:path atomically:YES];
}

+ (NSData *)readDataWithName:(NSString *)name directory:(NSSearchPathDirectory)directory
{
    NSString *currentName = [SaveTools fileNameWith:name];
    NSString *path = [SaveTools pathWithName:currentName directory:directory];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

// 将http://www.baidu.com的名字改为：httpwww.baidu.com

+ (NSString *)fileNameWith:(NSString *)name
{
    name = [name stringByReplacingOccurrencesOfString:@"/" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@":" withString:@""];
    return name;
}


@end








