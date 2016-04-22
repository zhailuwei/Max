//
//  FindViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/9/2.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "FindViewController.h"
#import "AsynURLConnection.h"
#import "MainViewController.h"
#import "DefineURL.h"
#import "TextCell.h"
#import "FoundViewController.h"
#import "TextModel.h"
#import "UIImageView+WebCache.h"
#import "ReHeight.pch"

@interface FindViewController () <UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UICollectionView *collect;
@property (nonatomic, retain) NSMutableArray *collectArr;
@property (nonatomic, retain) NSString *searchText;

@property (nonatomic, retain) NSString *text;


@end

@implementation FindViewController
/**
 *  首页上方点击搜索按钮进入的界面
 */

- (void)dealloc
{
    [_collect release];
    [_searchBar release];
    [_collectArr release];
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.collectArr = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.85 green:0.32 blue:0.65 alpha:1.000];
    
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10 * OffWidth, 5 * OffHeight, (self.view.frame.size.width - 100) * OffWidth, 30 * OffHeight)];
    self.searchBar.backgroundColor = [UIColor clearColor];
    self.searchBar.placeholder = @"选份礼物给最爱的人";
    _searchBar.barStyle = UIBarStyleDefault;
    self.navigationItem.titleView = _searchBar;
    _searchBar.delegate = self;
    [_searchBar release];
    
    
    UIButton *cancelbutton = [UIButton buttonWithType: UIButtonTypeSystem];
    cancelbutton.frame = CGRectMake(300 * OffWidth , 15 * OffHeight, 60 * OffWidth, 50 * OffHeight);
    cancelbutton.backgroundColor = [UIColor clearColor];
    [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelbutton];
    
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 * OffWidth, 10 * OffHeight, 100 * OffWidth, 30 * OffHeight)];
    titleLabel.text = @"大家都在搜";
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    
    NSArray *array = [NSArray arrayWithObjects:@"双肩包",@"戒指", @"樱花", @"手工", @"杯子", @"情侣",@"手机壳", @"手表", @"钱包", nil];
    
    for (int i = 0; i < 9; i++) {
        
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        titleButton.frame = CGRectMake((i % 3 * 70 + 10) * OffWidth , (i / 3 * 50 + 40) * OffHeight, 60 * OffWidth, 40 * OffHeight);
        
        [titleButton setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [self.view addSubview:titleButton];
        
        
    }
    
    
}



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    searchBar.text = searchText;
    NSString *string = [searchBar.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.searchText = string;

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    
    FoundViewController *found = [[FoundViewController alloc]init];
    found.searchtext = self.searchText;
    [self.navigationController pushViewController:found animated:YES];
    [found release];
    
}


- (void)buttonClick:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
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
