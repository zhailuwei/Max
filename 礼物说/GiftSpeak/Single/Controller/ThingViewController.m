//
//  ThingViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/8/29.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ThingViewController.h"
#import "UMSocial.h"

@interface ThingViewController ()

@property (nonatomic, retain) UIWebView *webview;

@end

@implementation ThingViewController


/**
 *  单品界面的每一个item点击进入的详情界面
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

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"礼物详情";
    
    [self createwebView];
    
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    shareButton.frame = CGRectMake(300 , 10, 30, 30);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    shareButton.backgroundColor = [UIColor clearColor];
    [shareButton addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    
}





- (void)createwebView
{
//    self.webview = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height + 152)];
    
    _webview.scalesPageToFit = YES;
    _webview.scrollView.bounces = NO;
    
    

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [_webview loadRequest:request];
    
    [self.view addSubview:_webview];
    [_webview release];
}



- (void)Click:(UIButton *)button
{
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSString *string = [NSString stringWithFormat:@"%@", url];
   
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55e85cb9e0f55af6ba0061c1"
                                      shareText:string
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                       delegate:nil];
    
    

    
    
    
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
