//
//  PresentView.h
//  GiftSpeak
//
//  Created by dllo on 15/8/22.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DivideViewController.h"
@protocol PresentViewDelegate;
@interface PresentView : UIView
@property (nonatomic, retain) UIButton *titleButton;
@property(nonatomic, retain)DivideViewController *tool;
@property (nonatomic, assign) id<PresentViewDelegate>delegate;


@end

@protocol PresentViewDelegate <NSObject>

- (void)sendMessage:(NSNumber *)ID;


@end
