//
//  CellModel.h
//  GiftSpeak
//
//  Created by dllo on 15/8/24.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject

@property (nonatomic, retain) NSNumber *id;
@property (nonatomic, retain) NSString *banner_image_url;
@property (nonatomic, retain) NSString *cover_image_url;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSString *updated_at;
@property (nonatomic, retain) NSString *content_url;
@property (nonatomic, copy) NSNumber *likes_count;
@property (nonatomic, retain) NSString *share_msg;
@property (nonatomic, retain) NSString *short_title;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSNumber *published_at;


@end
