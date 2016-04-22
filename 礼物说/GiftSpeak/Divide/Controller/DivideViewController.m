//
//  DivideViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/8/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "DivideViewController.h"
#import "GuideView.h"
#import "PresentView.h"
#import "DivideButton.h"
#import "PressViewController.h"
#import "UMSocial.h"
#import "ReHeight.pch"
#import "ItemViewController.h"

@interface DivideViewController ()  <GuideViewDelegate>

@property (nonatomic, retain) UITableView *table;
@property (nonatomic,retain) NSMutableArray *tableArr;
@property (nonatomic, retain) UIButton *leftButton;
@property (nonatomic, retain) UIButton *rightButton;


@end

@implementation DivideViewController


/**
 *  分类主界面
 */

- (void)dealloc
{
    [_table release];
    [_tableArr release];
    [_guide release];
    [_present release];
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tableArr = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _leftButton.frame = CGRectMake(100 * OffWidth, 5 * OffHeight, 90 * OffWidth, 30 * OffHeight);
    [_leftButton setTitle:@"攻略" forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:_leftButton];
    _leftButton.backgroundColor = [UIColor whiteColor];
    _leftButton.layer.borderColor = [[UIColor clearColor]CGColor];
    [_leftButton.layer setCornerRadius:5.0];
    [_leftButton.layer setBorderWidth:2.0];
    [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightButton.frame = CGRectMake(190 * OffWidth, 5 * OffHeight, 90 * OffWidth, 30 * OffHeight);
    [_rightButton setTitle:@"礼物" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:_rightButton];
    _rightButton.backgroundColor = [UIColor redColor];
    _rightButton.layer.borderColor = [[UIColor clearColor]CGColor];
    [_rightButton.layer setCornerRadius:5.0];
    [_rightButton.layer setBorderWidth:2.0];
    [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    shareButton.frame = CGRectMake(5 * OffWidth, 0, 30 * OffHeight, 30 * OffHeight);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"10.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.backgroundColor = [UIColor clearColor];
    searchButton.frame = CGRectMake(310 * OffWidth, 0, 20 * OffWidth, 20 * OffHeight);
    [searchButton setBackgroundImage:[UIImage imageNamed:@"19.png"] forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:searchButton];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchButton];
    
    
    self.guide = [[GuideView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.guide.delegate = self;
    [self.view addSubview:_guide];
    
    [_guide release];
    
    
    
}

//回调方法 (分类界面攻略界面的每个小按钮点进去的界面)
-(void)passValue:(NSNumber *)ID
{
    PressViewController *press = [[PressViewController alloc]init];
    press.numID = ID;
    [self.navigationController pushViewController:press animated:YES];
    [press release];
}
#pragma mark - 点击导航栏的按钮选择进入哪一个view
- (void)leftClick:(UIButton *)button
{
    button.backgroundColor = [UIColor whiteColor];
    self.rightButton.backgroundColor = [UIColor redColor];
    
    self.guide = [[GuideView alloc]initWithFrame:CGRectMake(0, 64*OffHeight, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_guide];
  
    [button bringSubviewToFront:_guide];
    
    [_present removeFromSuperview];
}

- (void)rightClick:(UIButton *)button
{
    button.backgroundColor = [UIColor whiteColor];
    self.leftButton.backgroundColor = [UIColor redColor];
    self.present = [[PresentView alloc]initWithFrame:CGRectMake(0, 70*OffHeight, self.view.frame.size.width, self.view.frame.size.height)];
    self.present.tool = self;
    [self.view addSubview:_present];
    [button bringSubviewToFront:_present];
    
    [_guide removeFromSuperview];
    
    
}


- (void)shareClick:(UIButton *)button
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55e85cb9e0f55af6ba0061c1"
                                      shareText:@"你要分享的文字"
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
