//
//  ToolViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/8/29.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ToolViewController.h"
#import "ToolCell.h"
#import "AsynURLConnection.h"
#import "DefineURL.h"
#import "DivideModel.h"
#import "UIImageView+WebCache.h"
#import "SelectViewController.h"
#import "ListModel.h"
#import "PositionViewController.h"
#import "PriceViewController.h"
#import "CharacterViewController.h"
#import "StateViewController.h"
#import "ReHeight.pch"


@interface ToolViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *collect;
@property (nonatomic, retain) NSMutableArray *collectArr;
@property (nonatomic, retain) NSMutableArray *ListArr;   //根据channels得到的数组
@property (nonatomic, retain) NSMutableArray *tableArr; //根据filters得到的大数组

@property (nonatomic, retain) NSMutableArray *channelArr;   //每个字典里的channels数组

@property (nonatomic, retain) UICollectionView *collectView;


@end

@implementation ToolViewController


/**
 *  分类界面的礼物选项的选礼神器的界面
 */

- (void)dealloc
{
    [_collect release];
    [_collectArr release];
    [_ListArr release];
    [_tableArr release];
    [_channelArr release];
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.collectArr = [NSMutableArray array];
        
        self.ListArr = [NSMutableArray array];
        
        self.tableArr = [NSMutableArray array];
        
        self.channelArr = [NSMutableArray array];
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createLabel];
    
    [self myConnection];
    
    [self createCollection];
}

- (void)createLabel
{
    NSArray *arr1 = [NSArray arrayWithObjects:@"对象", @"场合", @"个性", @"价格", nil];
    
    for (int i = 0; i < 4; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((i * 100 + 20) * OffWidth, 5 * OffHeight, 50 * OffWidth, 40 * OffHeight)];
        label.text = [arr1 objectAtIndex:i];
        [self.view addSubview:label];
        label.textColor = [UIColor lightGrayColor];
        [label release];
        
        
        UIButton  *downButton = [UIButton buttonWithType:UIButtonTypeSystem];
        downButton.frame = CGRectMake( (i * 95 + 70) * OffWidth, 15 * OffHeight, 20 * OffWidth, 15 * OffHeight);
        [downButton setBackgroundImage:[UIImage imageNamed:@"7.png"] forState:UIControlStateNormal];
        [self.view addSubview:downButton];
        downButton.tag = i + 1;
        [downButton addTarget:self action:@selector(clickAction:)  forControlEvents:UIControlEventTouchUpInside];
        [downButton release];
        
        UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(60 * OffWidth, 5 * OffHeight, 20 * OffWidth, 30 * OffHeight)];
        lineImage.image = [UIImage imageNamed:@"9.png"];
        [label addSubview:lineImage];
        [lineImage release];
        
        
        
    }
    
    
}

- (void)myConnection
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"20" forKey:@"limit"];
    [dic setObject:@"0" forKey:@"offset"];
    
    [AsynURLConnection asynWithURL:LWS_Divide_Select parmaters:dic block:^(NSData *data) {
        
        [self.collectArr removeAllObjects];
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dict = [root objectForKey:@"data"];
        NSArray *array = [dict objectForKey:@"items"];
        for (NSDictionary *dic in array) {
            DivideModel *model = [[DivideModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.collectArr addObject:model];
            [model release];
        }
        [self.collect reloadData];
    }];
}

- (void)createCollection
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(180 * OffWidth, 150 * OffHeight);
    layout.minimumInteritemSpacing = 5;
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(5 * OffWidth, 50 * OffHeight, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    _collect.backgroundColor = [UIColor whiteColor];
    _collect.allowsSelection = YES;
    _collect.dataSource = self;
    _collect.delegate = self;
    [self.view addSubview:_collect];
    [_collect registerClass:[ToolCell class] forCellWithReuseIdentifier:@"tool"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tool" forIndexPath:indexPath];
    
    DivideModel *model = [self.collectArr objectAtIndex:indexPath.item];
        
    [cell.mainImage sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]];
    
    cell.titleLabel.text = model.name;
    NSString *string = [NSString stringWithFormat:@"%@", model.favorites_count];
    cell.likeLabel.text = string;
    cell.moneyLabel.text = model.price;
    
    
    return cell;
    
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SelectViewController *select = [[SelectViewController alloc]init];
    DivideModel *model = [self.collectArr objectAtIndex:indexPath.item];
    select.numID = model.id;
    [self.tool.navigationController pushViewController:select animated:YES];
    [select release];
    
    
    
}



- (void)clickAction:(UIButton *)button
{
    if (button.tag == 1) {
        
        PositionViewController *position = [[PositionViewController alloc]init];

        [self.tool.navigationController pushViewController:position animated:YES];
        [position release];
        
    }else if (button.tag == 2){
        
        PriceViewController *price = [[PriceViewController alloc]init];
        [self.tool.navigationController pushViewController:price animated:YES];
        [price release];
        
    }else if (button.tag == 3){
        CharacterViewController *character = [[CharacterViewController alloc]init];
        [self.tool.navigationController pushViewController:character animated:YES];
        [character release];
        
    }else{
        
        StateViewController *state = [[StateViewController alloc]init];
        [self.tool.navigationController pushViewController:state animated:YES];
        [state release];
    }
    
    
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
