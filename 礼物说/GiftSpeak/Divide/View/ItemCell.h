//
//  ItemCell.h
//  GiftSpeak
//
//  Created by dllo on 15/9/9.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyButtonOfDivide;
@interface ItemCell : UICollectionViewCell

@property (nonatomic, retain) MyButtonOfDivide *imageButton;   //左边图片
//右边图片

@property (nonatomic, retain) UILabel *titleLabel;  //左边标题
@property (nonatomic, retain) UIImageView *moneyImage;  //左边金钱符
@property (nonatomic, retain) UILabel *moneyLabel;  //左边价格
@property (nonatomic, retain) UIImageView *likeImage;  //左边喜欢的符号
@property (nonatomic, retain) UILabel *likeLabel;


@end
