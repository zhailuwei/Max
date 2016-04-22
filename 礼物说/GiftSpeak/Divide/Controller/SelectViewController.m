//
//  SelectViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/8/29.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SelectViewController.h"
#import "AsynURLConnection.h"
#import "DefineURL.h"
#import "ReHeight.pch"

@interface SelectViewController () <UIWebViewDelegate>

@end

@implementation SelectViewController


/**
 *  选礼神器每一个item点进去的界面
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self myConnection];
}


- (void)myConnection
{
    NSString *url = [LWS_Divide_SelectXQ stringByReplacingOccurrencesOfString:@"1031631" withString:[NSString stringWithFormat:@"%@", self.numID]];
    
    UIWebView *webview = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    webview.scalesPageToFit = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
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
