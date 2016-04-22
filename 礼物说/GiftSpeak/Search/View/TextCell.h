//
//  TextCell.h
//  GiftSpeak
//
//  Created by dllo on 15/9/5.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextCell : UICollectionViewCell

@property (nonatomic, retain) UIImageView *mainImage;
@property (nonatomic, retain) UILabel *titleLabel;  //左边标题
@property (nonatomic, retain) UIImageView *moneyImage;  //左边金钱符
@property (nonatomic, retain) UILabel *moneyLabel;  //左边价格
@property (nonatomic, retain) UIImageView *likeImage;  //左边喜欢的符号
@property (nonatomic, retain) UILabel *likeLabel;  //左边的喜欢数量

@property (nonatomic, retain) NSString *text;

- (NSMutableAttributedString *)colorData:(NSString *)withStr;


@end
