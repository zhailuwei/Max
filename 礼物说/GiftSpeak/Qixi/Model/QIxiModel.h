//
//  QIxiModel.h
//  GiftSpeak
//
//  Created by dllo on 15/8/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QIxiModel : NSObject

@property (nonatomic, retain) NSNumber *id;
@property (nonatomic, retain) NSString *banner_image_url;
@property (nonatomic, retain) NSString *cover_image_url;
@property (nonatomic, retain) NSNumber *likes_count;
@property (nonatomic, retain) NSString *share_msg;
@property (nonatomic, retain) NSString *short_title;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *url;

@end
