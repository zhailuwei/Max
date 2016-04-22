//
//  PageViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/9/12.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "PageViewController.h"
#import "ReHeight.pch"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createLabel];
    
}


- (void)createLabel
{
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220 * OffHeight)];
    image.backgroundColor = [UIColor clearColor];
    image.image = [UIImage imageNamed:@"liwu.png"];
    [self.view addSubview:image];
    [image release];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"礼物说保持每日更新，为用户推荐实用热门的礼物攻略。礼物攻略来源于编辑和礼物达人的真实体验，基于社交网络口碑数据，内容涵盖特色礼物、创意手工、旅行特产、好玩去处等。意在提供高品质的礼物攻略，帮助用户给恋人、家人、朋友、同事制造生日、节日、纪念日惊喜。为您提供丰富的送礼方案.";
    label.textColor = [UIColor purpleColor];
    label.font = [UIFont systemFontOfSize:20];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
