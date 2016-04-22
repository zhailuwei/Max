//
//  GuideViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/8/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "GuideViewController.h"
#import "ReHeight.pch"
#import "ClothModel.h"
#import "GiftDataBase.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

/**
 *  穿搭界面的每个cell点进去的详情界面
 */

- (void)dealloc
{
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
    self.title = @"攻略详情";
    [self createWebView];
}

- (void)createWebView
{
    UIWebView *webview = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:webview];
    webview.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
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
