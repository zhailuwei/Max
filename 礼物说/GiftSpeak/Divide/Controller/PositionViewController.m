//
//  PositionViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/9/2.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "PositionViewController.h"
#import "DefineURL.h"
#import "AsynURLConnection.h"
#import "ListModel.h"
#import "PositionCell.h"
#import "UIButton+WebCache.h"
#import "ToolViewController.h"
#import "ReHeight.pch"

@interface PositionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) NSMutableArray *collectArr;
@property (nonatomic, retain) UICollectionView *collect;

@end

@implementation PositionViewController
/**
 *  分类界面选礼神器点进去上方对象等小标题中对象点进去的界面
 */


- (void)dealloc
{
    [_collect release];
    [_collectArr release];
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.collectArr = [ NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self myConnection];
    [self createCollect];
}


- (void)myConnection
{
    NSMutableDictionary *dicA = [NSMutableDictionary dictionary];
    [dicA setObject:@"20" forKey:@"limit"];
    [dicA setObject:@"0" forKey:@"offset"];
    [dicA setObject:@"0_50" forKey:@"price"];
    [dicA setObject:@"30" forKey:@"scene"];
    
    [AsynURLConnection asynWithURL:LWS_Divide_Present_SelectSmall parmaters:dicA block:^(NSData *data) {
        [self.collectArr removeAllObjects];
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic = [root objectForKey:@"data"];
        NSArray *array = [dic objectForKey:@"items"];
        
        for (NSDictionary *dic in array) {
            ListModel *model = [[ListModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.collectArr addObject:model];
            [model release];
        }
        [self.collect reloadData];
    }];
    

}

- (void)createCollect
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 10 * OffWidth;
    layout.minimumLineSpacing = 10 * OffHeight;
    layout.itemSize = CGSizeMake(170 * OffWidth, 150 * OffHeight);
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height - 64) * OffHeight) collectionViewLayout:layout];
    self.collect.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collect];
    _collect.dataSource = self;
    _collect.delegate = self;
    [_collect release];
    
    [_collect registerClass:[PositionCell class] forCellWithReuseIdentifier:@"position"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PositionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"position" forIndexPath:indexPath];
    
    ListModel *model = [self.collectArr objectAtIndex:indexPath.item];
    
    [cell.imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.cover_image_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]] ;
    
   
    
    
    
    cell.titleLabel.text = model.name;
    
    cell.moneyLabel.text = model.price;
    
    NSString *string = [NSString stringWithFormat:@"%@", model.favorites_count];
    cell.likeLabel.text = string;
    return cell;
}

- (void)click:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
