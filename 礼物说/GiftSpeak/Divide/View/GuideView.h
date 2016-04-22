//
//  GuideView.h
//  GiftSpeak
//
//  Created by dllo on 15/8/22.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  GuideViewDelegate;
//
#import "DivideViewController.h"

@interface GuideView : UIView

@property (nonatomic, assign) id <GuideViewDelegate>delegate;
//
@property (nonatomic, retain) DivideViewController *divide;



@end

@protocol  GuideViewDelegate <NSObject>

- (void)passValue:(NSNumber *)ID;

@end
