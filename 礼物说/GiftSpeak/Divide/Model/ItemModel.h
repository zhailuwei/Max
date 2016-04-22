//
//  ItemModel.h
//  GiftSpeak
//
//  Created by dllo on 15/9/9.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property (nonatomic, retain) NSString *cover_image_url;

@property (nonatomic, retain) NSNumber *favorites_count;

@property (nonatomic, retain) NSString *name;

@property (nonatomic, retain) NSString *price;
@end
