//
//  MineViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/8/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "MineViewController.h"
#import "AppDelegate.h"
#import "MineCell.h"
#import "ClearCell.h"
#import "PageViewController.h"

#import "ReHeight.pch"
#import "SaveViewController.h"
#define ImageHeight 250.0f

@interface MineViewController ()  <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) UIImageView *changeImage;
@property (nonatomic, retain) UIView *darkView;
@property (nonatomic, retain)UIVisualEffectView *effectView;

@end

@implementation MineViewController



/**
 *  我的界面
 */

- (void)dealloc
{
    [_table release];
    [super dealloc];
}
- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
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
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.title = @"我的";
    
    [self createSwitch];
    [self createTable];
    
    [self addDrackView];
}

- (void)createTable
{
    self.table = [[UITableView alloc]initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _table.dataSource = self;
    _table.delegate = self;
    self.table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_table];
    self.table.contentInset = UIEdgeInsetsMake(ImageHeight * OffWidth, 0, 0, 0);
    
    [_table release];
    
    self.changeImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -ImageHeight * OffHeight, self.view.frame.size.width, ImageHeight * OffHeight)];
    self.changeImage.image = [UIImage imageNamed:@"29.png"];
    self.changeImage.clipsToBounds = YES;
    self.changeImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.table addSubview:_changeImage];
    [_changeImage release];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 0.1 * OffHeight;
    }
    return 20 * OffHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    
    if (y < -ImageHeight) {
        CGRect frame = self.changeImage.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        
        self.changeImage.frame = frame;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mine"];
    if (cell == nil) {
        cell = [[MineCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mine"];
    }
    
    
    NSArray *array1 = [NSArray arrayWithObjects:@"31.png", @"night.png", @"clear.png", @"33.png", nil];
    
    NSArray *array2 = [NSArray arrayWithObjects:@"关于我们", @"夜间模式", @"清除缓存", @"喜欢的礼物/喜欢的攻略", nil];
    

    cell.image.image = [UIImage imageNamed:[array1 objectAtIndex:indexPath.row]];
    cell.titleLabel.text = [array2 objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == 1) {
       
        UISwitch *swit = [[UISwitch alloc]initWithFrame:CGRectMake(160 * OffWidth,  90 * OffHeight, 50 * OffWidth, 50 * OffHeight)];
        swit.backgroundColor = [UIColor clearColor];
        [swit addTarget:self action:@selector(switAction:) forControlEvents:UIControlEventTouchUpInside];
        
            NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
            NSString *filePath = [NSString stringWithFormat:@"%@/drack", path];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            //判断本地是否有这个文件
            if ([fileManager fileExistsAtPath:filePath]) {
                //将文件里的东西取出来(解档)
                NSString *str = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
                if ([str isEqualToString:@"no"]) {
                    swit.on = NO;
                } else
                {
                    swit.on = YES;
                }
        
            } else
            {
                //归档
                NSString *str = @"no";
                [NSKeyedArchiver archiveRootObject:str toFile:filePath];
            }
            
        
        cell.accessoryView = swit ;

    }
    
    if (indexPath.row == 2) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [paths lastObject];
        
        NSString *str = [NSString stringWithFormat:@"%.1fM", [self folderSizeAtPath:path]];
        cell.detailTextLabel.text = str;
        

    }

    return cell;

    
}

- (void)leftClick:(UIButton *)button
{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height - 200) * OffHeight, self.view.frame.size.width, 60 * OffHeight)];
    leftView.backgroundColor = [UIColor redColor];
    [self.view addSubview:leftView];
    
}

- (void)rightClick:(UIButton *)button
{
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height - 200) * OffHeight, self.view.frame.size.width, 60 * OffHeight)];
    rightView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:rightView];
    
}



- (void)createSwitch
{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    self.effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    _effectView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _effectView.alpha = 0.7;
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:image];
    image.image = [UIImage imageNamed:@"11.jpg"];
    
    [image addSubview:self.effectView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50 * OffHeight;
}
- (void)switAction:(UISwitch *)swit
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [NSString stringWithFormat:@"%@/drack", path];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (swit.on == YES) {
        [app.window addSubview:_darkView];
        [NSKeyedArchiver archiveRootObject:@"yes" toFile:filePath];
        
        
    }else{
        [app.darkView removeFromSuperview];
        [_darkView removeFromSuperview];
        [NSKeyedArchiver archiveRootObject:@"no" toFile:filePath];
    }
    
    
}

- (void)addDrackView
{
    self.darkView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    _darkView.backgroundColor = [UIColor blackColor];
    _darkView.alpha = 0.6;
    _darkView.userInteractionEnabled = NO;
    [_darkView release];
}

- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [paths lastObject];
        path = [NSString stringWithFormat:@"%@/%@", path, @"Caches"];
       
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
        for (NSString *p in files) {
            NSError *error;
            NSString *Path = [path stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
                [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
            }
        }
        [self.table reloadData];
    }
    
    if (indexPath.row == 3) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        SaveViewController *save = [[SaveViewController alloc]init];
        [self.navigationController pushViewController:save animated:YES];
      
    }
    if (indexPath.row == 0) {
        PageViewController *page = [[PageViewController alloc]init];
        [self.navigationController pushViewController:page animated:YES];
        [page release];
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
