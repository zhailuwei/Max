//
//  ShopCell.h
//  GiftSpeak
//
//  Created by dllo on 15/8/28.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopView;

@interface ShopCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;    // 大标题
@property (nonatomic, retain) UILabel *smallTitleLabel;  // 小标题
@property (nonatomic, retain) UIImageView *topImage;
//@property (nonatomic, retain) UIButton *oneButton; //第一排第一个
//@property (nonatomic, retain) UIButton *twoButton; // 第一排第二个
//@property (nonatomic, retain) UIButton *threeButton;  // 第二排第一个
//@property (nonatomic, retain) UIButton *fourButton;  //第二排第二个
@property (nonatomic, retain) UIImageView *bigImage;  //右侧大图
@property (nonatomic, retain) UILabel *rightLabel;   // 右侧品牌主页
@property (nonatomic, retain) UIButton *imageButton; //品牌主页旁的三角
@property (nonatomic, retain) ShopView *shop;

@property (nonatomic, retain) NSMutableArray *arr;


- (void)passValue:(NSArray *)array;

@end
