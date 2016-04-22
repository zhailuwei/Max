//
//  SaveViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/9/6.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SaveViewController.h"
#import "ReHeight.pch"
#import "SaveCell.h"
#import "GiftDataBase.h"
#import "UIButton+WebCache.h"
#import "SaveModel.h"
#import "ClickViewController.h"
#import "CellModel.h"
@interface SaveViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) UICollectionView *collect;
@property (nonatomic, retain) NSMutableArray *collectArr;

@end

@implementation SaveViewController

/**
 *  我的收藏界面
 */
- (void)viewWillAppear:(BOOL)animated
{
    self.collectArr = [NSMutableArray array];

    NSArray *arr = [GiftDataBase selectAll];
    [self.collectArr addObjectsFromArray:arr];
    [_collect reloadData];

}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.collectArr = [NSMutableArray array];
        NSArray *arr = [GiftDataBase selectAll];
        [self.collectArr addObjectsFromArray:arr];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的收藏";

    [self createCollection];
}

- (void)createCollection
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(170 * OffWidth , 150 * OffHeight);
    layout.minimumInteritemSpacing = 10 * OffWidth;
    layout.minimumLineSpacing = 10 * OffHeight;
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    self.collect.backgroundColor = [UIColor whiteColor];
    _collect.dataSource = self;
    _collect.delegate = self;
    [self.view addSubview:_collect];
    
    [_collect registerClass:[SaveCell class] forCellWithReuseIdentifier:@"save"];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SaveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"save" forIndexPath:indexPath];
    SaveModel *model = [self.collectArr objectAtIndex:indexPath.item];
    [cell.imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.cover_image_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]
];
    cell.titleLabel.text = model.title;

    return cell;
}

- (void)buttonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    ClickViewController *clic = [[ClickViewController alloc]init];
    
    NSArray *arr = [GiftDataBase selectAll];
    SaveModel *model = [arr objectAtIndex:indexPath.item];
    CellModel *mod = [[CellModel alloc]init];
    mod.url = model.url;
    mod.title = model.title;
    clic.model = mod;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:clic animated:YES];
    
    
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
