//
//  DetailView.h
//  GiftSpeak
//
//  Created by dllo on 15/8/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "MainViewController.h"
@interface DetailView : UIView

@property (nonatomic, retain) UIScrollView *scroll;
@property (nonatomic, retain) UIPageControl *page;

- (void)setImageWithModel:(NSArray *)array;
- (void)setButtonImageWithModel:(NSArray *)arr;
//新加的
@property (nonatomic, retain) MainViewController *main;

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

@end
