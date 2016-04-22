//
//  AppDelegate.m
//  GiftSpeak
//
//  Created by dllo on 15/8/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "AppDelegate.h"
#import "SingleViewController.h"
#import "DivideViewController.h"
#import "MineViewController.h"
#import "MainViewController.h"
#import "UMSocial.h"

BOOL isOut = NO;

@interface AppDelegate () <UIScrollViewDelegate>
@property (nonatomic, retain) UIPageControl *page;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    MainViewController *main = [[MainViewController alloc]init];
    main.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"礼物说" image:[UIImage imageNamed:@"1.png"] selectedImage:nil];
    UINavigationController *navi1 = [[UINavigationController alloc]initWithRootViewController:main];
    
    
    SingleViewController *single = [[SingleViewController alloc]init];
    single.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"单品" image:[UIImage imageNamed:@"2.png"] selectedImage:nil];
    UINavigationController *navi2 = [[UINavigationController alloc]initWithRootViewController:single];
    
    
    DivideViewController *divide  = [[DivideViewController alloc]init];
    divide.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"分类" image:[UIImage imageNamed:@"3.png"] selectedImage:nil];
    UINavigationController *navi3 = [[UINavigationController alloc]initWithRootViewController:divide];
    
    MineViewController *mine = [[MineViewController alloc]init];
    mine.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"4.png"] selectedImage:nil];
    UINavigationController *navi4 = [[UINavigationController alloc]initWithRootViewController:mine];
    
    
    UITabBarController *tab = [[UITabBarController alloc]init];
    tab.tabBar.tintColor = [UIColor colorWithRed:0.85 green:0.32 blue:0.65 alpha:1.000];
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:navi1];
    [array addObject:navi2];
    [array addObject:navi3];
    [array addObject:navi4];
    
    tab.viewControllers = array;
    self.window.rootViewController = tab;
    
    
    [tab release];
    [main release];
    [single release];
    [divide release];
    [mine release];
    [navi1 release];
    [navi2 release];
    [navi3 release];
    [navi4 release];
    
    [_window release];
    
    
    
    [UMSocialData setAppKey:@"55e85cb9e0f55af6ba0061c1"];
       [UMSocialData openLog:YES];
    //只有第一次进来的时候有引导页
    NSUserDefaults *user = [[NSUserDefaults alloc] init];
    if (![user objectForKey:@"su"]) {
        [self makeLaunchView];
        [self addPage];
        [user setObject:@"yes" forKey:@"su"];
    }
    
 
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [NSString stringWithFormat:@"%@/drack", path];
    NSLog(@"filePath = %@",filePath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSString *str = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        if ([str isEqualToString:@"yes"]) {
            [self addDrackView];
        }
        
    }
    return YES;
}


- (void)addDrackView
{
    self.darkView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    _darkView.backgroundColor = [UIColor blackColor];
    _darkView.alpha = 0.6;
    _darkView.userInteractionEnabled = NO;
    [self.window addSubview:_darkView];
    [_darkView release];
}



- (void)makeLaunchView
{
    NSArray *arr=[NSArray arrayWithObjects:@"page10.jpg",@"page6.jpg",@"page9.jpg",@"page8.jpg", nil];//数组内存放的是我要显示的假引导页面图片
    //通过scrollView 将这些图片添加在上面，从而达到滚动这些图片
    UIScrollView *scr = [[UIScrollView alloc] initWithFrame:self.window.bounds];
    scr.contentSize = CGSizeMake(self.window.frame.size.width * arr.count, self.window.frame.size.height);
    scr.pagingEnabled = YES;
    scr.tag = 7000;
    scr.delegate = self;
    [self.window addSubview:scr];
    for (int i=0; i<arr.count; i++) {
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(i * self.window.frame.size.width, 0, self.window.frame.size.width, self.window.frame.size.height)];
        img.image=[UIImage imageNamed:arr[i]];
        [scr addSubview:img];
        [img release];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //这里是在滚动的时候判断 我滚动到哪张图片了，如果滚动到了最后一张图片，那么
    //如果在往下面滑动的话就该进入到主界面了，我这里利用的是偏移量来判断的，当
    //一共五张图片，所以当图片全部滑完后 又像后多滑了30 的时候就做下一个动作
    if (scrollView.contentOffset.x > 3 * self.window.frame.size.width + 30) {
        
        isOut=YES;//这是我声明的一个全局变量Bool 类型的，初始值为no，当达到我需求的条件时将值改为yes
        
    }
}

/* 创建page */
- (void)addPage
{
    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(self.window.frame.size.width / 2 - 50, self.window.frame.size.height - 80, 100, 40)];
    [self.window addSubview:self.page];
    self.page.currentPage = 0;
    self.page.numberOfPages = 4;
    self.page.backgroundColor = [UIColor clearColor];
    [_page release];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    self.page.currentPage = index;
    
    //判断isout为真 就要进入主界面了
    if (isOut) {
        //这里添加了一个动画，（可根据个人喜好）
        [UIView animateWithDuration:1.5 animations:^{
            scrollView.alpha=0;//让scrollview 渐变消失
            
        }completion:^(BOOL finished) {
            [scrollView  removeFromSuperview];//将scrollView移除
            [self gotoMain];//进入主界面
            
        } ];
    }
    
}

- (void)gotoMain
{
    //如果第一次进入没有文件，我们就创建这个文件
    NSFileManager *manager=[NSFileManager defaultManager];
    //判断 我是否创建了文件，如果没创建 就创建这个文件（这种情况就运行一次，也就是第一次启动程序的时候）
    if (![manager fileExistsAtPath:[NSHomeDirectory() stringByAppendingString:@"aa.txt"]]) {
        [manager createFileAtPath:[NSHomeDirectory() stringByAppendingString:@"aa.txt"] contents:nil attributes:nil];
        NSLog(@"启动页路径 = %@",[NSHomeDirectory() stringByAppendingString:@"aa.txt"]);
    }
    self.page.hidden = YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
