//
//  CellView.m
//  GiftSpeak
//
//  Created by dllo on 15/8/25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "CellView.h"
#import "StyleModel.h"
#import "UIButton+WebCache.h"
#import "MyButtonOfDivide.h"
#import "ReHeight.pch"
@implementation CellView
// 每一个图标的自定义View

- (void)dealloc
{
    [_imageButton release];
    [_buttonLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageButton = [MyButtonOfDivide buttonWithType:UIButtonTypeSystem];
        
        _imageButton.layer.cornerRadius = 25;
        [self addSubview:_imageButton];
        
        
        self.buttonLabel = [[UILabel alloc]init];
        _buttonLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_buttonLabel];
        [_buttonLabel release];
        _buttonLabel.textAlignment = 1;
        _imageButton.frame = CGRectMake(0 , 0  , 50 * OffWidth, 50 * OffHeight);
    _buttonLabel.frame = CGRectMake(0 , 50 * OffHeight, 60 * OffWidth, 30 * OffHeight);

    }
    return self;
}


    

    
    





@end
