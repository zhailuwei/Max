//
//  TextCell.m
//  GiftSpeak
//
//  Created by dllo on 15/9/5.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "TextCell.h"
#import "ReHeight.pch"

#define SETCOLOR(R,G,B) [UIColor colorWithRed:(CGFloat)R/255 green:(CGFloat)G/255 blue:(CGFloat)B/255 alpha:1.0]


@implementation TextCell


- (void)dealloc
{
    [_mainImage release];
    [_likeImage release];
    [_likeLabel release];
    [_moneyImage release];
    [_moneyLabel release];
    [_titleLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(5 * OffWidth, 5 * OffHeight, self.contentView.frame.size.width, 100 * OffHeight)];
        self.mainImage.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_mainImage];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 * OffWidth, 110 * OffHeight, self.contentView.frame.size.width, 20 * OffHeight)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_titleLabel];
        
        
        self.moneyImage = [[UIImageView alloc]initWithFrame:CGRectMake(5 * OffWidth, 135 * OffHeight, 20 * OffWidth, 20 * OffHeight)];
        self.moneyImage.image = [UIImage imageNamed:@"22.png"];
        [self.contentView addSubview:_moneyImage];
        
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(30 * OffWidth, 135 * OffHeight, 50 * OffWidth , 20 * OffHeight)];
        self.moneyLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_moneyLabel];
        self.moneyLabel.font = [UIFont systemFontOfSize:13];
        self.moneyLabel.textColor = [UIColor blackColor];
        
        
        self.likeImage = [[UIImageView alloc]initWithFrame:CGRectMake(120 * OffWidth, 135 * OffHeight, 20 * OffWidth, 20 * OffHeight)];
        self.likeImage.image = [UIImage imageNamed:@"21.png"];
        [self.contentView addSubview:_likeImage];
        
        
        
        self.likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(140 * OffWidth, 135 * OffHeight, 40 * OffWidth, 20 * OffHeight)];
        self.likeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_likeLabel];
        self.likeLabel.font = [UIFont systemFontOfSize:13];
        
        }
    
    return self;
}

// 关键字高亮
- (NSMutableAttributedString *)colorData:(NSString *)withStr{
    NSMutableAttributedString *dataStr = [[NSMutableAttributedString alloc] initWithString:withStr];
    
    for (int i = 0; i < withStr.length - self.text.length + 1; i++) {
        
        if ([[withStr substringWithRange:NSMakeRange(i, self.text.length)] isEqualToString:self.text]) {
            
            NSRange range = NSMakeRange(i, self.text.length);
            [dataStr addAttribute:NSForegroundColorAttributeName value:SETCOLOR(255, 114, 0) range:NSMakeRange(range.location,range.length)];
            
        }
        
        
    }
    return dataStr;
}







@end
