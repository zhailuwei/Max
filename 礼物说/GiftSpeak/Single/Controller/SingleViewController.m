//
//  SingleViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/8/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SingleViewController.h"
#import "CustomCell.h"
#import "SingleModel.h"
#import "AsynURLConnection.h"
#import "DefineURL.h"
#import "SingleButton.h"
#import "UIButton+WebCache.h"
#import "ThingViewController.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"
#import "ReHeight.pch"


#import "MXPullDownMenu.h"

@interface SingleViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,MXPullDownMenuDelegate>

@property (nonatomic, retain) UICollectionView *collect;;
@property (nonatomic, retain) NSMutableArray *colllectArr;

@end
int i = 0;
@implementation SingleViewController


/**
 *  单品界面
 */
- (void)dealloc
{
//    [_collect release];
    [_colllectArr release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.colllectArr = [NSMutableArray array];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"单品";
    self.navigationItem.title = @"滋滋欢乐天地";
    self.view.backgroundColor = [UIColor whiteColor];
    //下拉菜单
    NSArray *zizileArray = @[@[@"单品", @"玫缇斯漫画", @"豆角", @"蘑菇", @"排骨"]];
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:zizileArray selectedColor:[UIColor redColor]];
    menu.delegate = self;
    [menu setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1.png"]]];
    
    //menu.clipsToBounds = YES;
    //menu.layer.cornerRadius = 50;
    menu.frame = CGRectMake(0, 64, 100, 40);
    [self.view addSubview:menu];
    
    //
    [self myConnection];
    [self createCollection];
    [self refresh];
}
- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    switch (row) {
        case 0:
        {
            //[self createCollection];
            NSLog(@"hdhd");
            break;
        }
            case 1:
        {
            NSLog(@"hdhd");
            break;
        }
        default:
            break;
    }
}
- (void)myConnection
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"2" forKey:@"gender"];
    [dic setObject:@"2" forKey:@"generation"];
    [dic setObject:@"20" forKey:@"limit"];
    [dic setObject:@"0" forKey:@"offset"];
    
    //http://api.liwushuo.com/v2/items?generation=2&gender=2&limit=20&offset=0

    //
    [AsynURLConnection asynWithURL:LWS_Single parmaters:dic block:^(NSData *data) {
        
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = [root objectForKey:@"data"];
        NSArray *itemsArr = [dataDic objectForKey:@"items"];
        
        if (itemsArr.count != 0) {
            
            for (NSDictionary *dic in itemsArr) {
                SingleModel *model = [[SingleModel alloc]init];
                NSDictionary *dict = [dic objectForKey:@"data"];
                [model setValuesForKeysWithDictionary:dict];
                [self.colllectArr addObject:model];
                [model release];
                
            }
            [_collect reloadData];
        }
    
    }];
    
}

- (void)createCollection
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(180 * OffWidth, 195 * OffHeight);
    layout.minimumInteritemSpacing = 10 * OffWidth;
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 110, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    _collect.backgroundColor = [UIColor whiteColor];
    _collect.delegate = self;
    _collect.dataSource = self;
    [self.view addSubview:_collect];
    
    [_collect registerClass:[CustomCell class] forCellWithReuseIdentifier:@"single"];
    [_collect release];
    
}

- (void)refresh
{
    self.collect.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self fileSave];
        
        [self.colllectArr removeAllObjects];
        
        [self myConnection];
        
       //http://api.liwushuo.com/v2/items?generation=2&gender=2&limit=20&offset=0
      
        [self.collect.header endRefreshing];
        
    }];
    self.collect.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

        [self fileSave];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        i = i + 10;
        NSLog(@"%d",i);
        [dic setObject:@"2" forKey:@"generation"];
        [dic setObject:@"2" forKey:@"gender"];
        [dic setObject:@"20" forKey:@"limit"];
        [dic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"offset"];
        //                    [self.colllectArr removeAllObjects];
        
        [AsynURLConnection asynWithURL:LWS_Single parmaters:dic block:^(NSData *data) {
            
            NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDic = [root objectForKey:@"data"];
            NSArray *itemsArr = [dataDic objectForKey:@"items"];
            
            for (NSDictionary *dic in itemsArr) {
                SingleModel *model = [[SingleModel alloc]init];
                NSDictionary *dict = [dic objectForKey:@"data"];
                [model setValuesForKeysWithDictionary:dict];
                [self.colllectArr addObject:model];
                [model release];
                
            }
            [_collect reloadData];
            [self.collect.footer endRefreshing];
            
        }];
        
        
    }];
 
}

- (void)fileSave
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [arr firstObject];
    path = [NSString stringWithFormat:@"%@/%@",path,@"1400123135"];
    
    NSError *error = nil;
    // 删除本地缓存文件
    [manager removeItemAtPath:path error:&error];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.colllectArr.count ;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"single" forIndexPath:indexPath];
    
    SingleModel *model = [self.colllectArr objectAtIndex:indexPath.item];
    
    [cell.imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.cover_image_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]
];
    
    cell.titleLabel.text = model.name;
   
    cell.moneyLabel.text = model.price;
    
    NSString *string = [NSString stringWithFormat:@"%@", model.favorites_count];
    cell.likeLabel.text = string;
    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ThingViewController *thing = [[ThingViewController alloc]init];
    SingleModel *model = [self.colllectArr objectAtIndex:indexPath.item];
    thing.urlStr = model.url;
    [self.navigationController pushViewController:thing animated:YES];
    [thing release];
    
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
