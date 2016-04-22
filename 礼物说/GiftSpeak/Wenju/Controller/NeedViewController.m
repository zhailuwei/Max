//
//  NeedViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/8/29.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "NeedViewController.h"
#import "ReHeight.pch"

@interface NeedViewController ()

@end

@implementation NeedViewController


/**
 *  分类界面中得攻略中得文具界面的每个cell点进去的详情界面
 */

- (void)dealloc
{
    [_urlStr release];
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createWebView];
}

- (void)createWebView
{
    UIWebView *webview = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    webview.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:_urlStr];
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
