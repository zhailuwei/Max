//
//  CharacterCell.h
//  GiftSpeak
//
//  Created by dllo on 15/9/2.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SingleButton;

@interface CharacterCell : UICollectionViewCell
@property (nonatomic, retain) SingleButton *imageButton;   //左边图片


@property (nonatomic, retain) UILabel *titleLabel;  //左边标题
@property (nonatomic, retain) UIImageView *moneyImage;  //左边金钱符
@property (nonatomic, retain) UILabel *moneyLabel;  //左边价格
@property (nonatomic, retain) UIImageView *likeImage;  //左边喜欢的符号
@property (nonatomic, retain) UILabel *likeLabel;  //左边的喜欢数量
@end
