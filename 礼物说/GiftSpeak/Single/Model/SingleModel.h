//
//  SingleModel.h
//  GiftSpeak
//
//  Created by dllo on 15/8/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleModel : NSObject

@property (nonatomic, retain) NSNumber *id;
@property (nonatomic, copy) NSString *cover_image_url;
@property (nonatomic,copy)NSString *description;
@property (nonatomic, retain) NSNumber *favorites_count;
@property (nonatomic, copy) NSString *image_urls;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *url;




@end
