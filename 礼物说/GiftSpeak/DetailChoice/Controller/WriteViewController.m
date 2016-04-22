//
//  WriteViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/8/28.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "WriteViewController.h"
#import "DefineURL.h"

@interface WriteViewController ()

@end

@implementation WriteViewController


/**
 *  每日签到的详情界面
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"攻略详情";
    [self createWebView];
}

- (void)createWebView
{
    UIWebView *webview = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    webview.backgroundColor = [UIColor whiteColor];
    webview.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:LWS_JX_Write];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
    [self.view addSubview:webview];
    [webview release];
    
    
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
