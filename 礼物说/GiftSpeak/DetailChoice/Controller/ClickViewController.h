//
//  ClickViewController.h
//  GiftSpeak
//
//  Created by dllo on 15/8/31.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellModel;

@interface ClickViewController : UIViewController
@property (nonatomic, retain) NSNumber *numID;
@property (nonatomic, retain) NSString *urlStr;
@property (nonatomic, retain) CellModel *model;

@end
