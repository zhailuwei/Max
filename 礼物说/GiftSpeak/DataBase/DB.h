//
//  DB.h
//  DataBase
//
//  Created by 蒋杏飞 on 15/8/14.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DB : NSObject

+ (sqlite3 *)dbOpen;

@end
