//
//  SaveCell.m
//  GiftSpeak
//
//  Created by dllo on 15/9/6.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SaveCell.h"
#import "ReHeight.pch"

@implementation SaveCell
- (void)dealloc
{
    [_imageButton release];
    [_titleLabel release];
    
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _imageButton.frame = CGRectMake(5 * OffWidth, 5 * OffHeight, self.contentView.frame.size.width, 100 * OffHeight);
        self.imageButton.backgroundColor = [UIColor clearColor];
        _imageButton.userInteractionEnabled = NO;
        [self.contentView addSubview:_imageButton];
        
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 * OffWidth, 110 * OffHeight, self.contentView.frame.size.width, 20 * OffHeight)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_titleLabel];
        
        
                
        
        
        
        
    }
    
    return self;
}


@end
