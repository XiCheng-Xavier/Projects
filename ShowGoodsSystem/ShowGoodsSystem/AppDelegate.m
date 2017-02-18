//
//  AppDelegate.m
//  ShowGoodsSystem
//
//  Created by 熙 程 on 14-4-9.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"

@implementation AppDelegate
@synthesize window;
@synthesize payImmeViewController;
@synthesize shoppingcartViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(addPayImmeView) name:@"valueOK" object:nil];
    [center addObserver:self selector:@selector(clearPayImmeView) name:@"popInfo" object:nil];//添加payImmeViewController事件监听
    [center addObserver:self selector:@selector(addShoppingcartView) name:@"shoppingcartValueOK" object:nil];
    [center addObserver:self selector:@selector(clearShoppingcartView) name:@"shoppingcartPopInfo" object:nil];//添加shoppingcartViewController事件监听
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITableViewController *masterViewController = [story instantiateViewControllerWithIdentifier:@"master"];
    DetailViewController *detailViewController =[story instantiateViewControllerWithIdentifier:@"detail"];
    //实例化payImmetableViewController
    payImmeViewController = [story instantiateViewControllerWithIdentifier:@"payImme"];
    [payImmeViewController addObserver];
    //实例化shoppingcartViewController
    shoppingcartViewController = [story instantiateViewControllerWithIdentifier:@"shoppingcart"];
    [shoppingcartViewController addObserver];
    [window.rootViewController.view addSubview:masterViewController.view];
    [window.rootViewController.view addSubview:detailViewController.view];
    UIViewController *root = window.rootViewController;
    [root addChildViewController:masterViewController];
    [masterViewController didMoveToParentViewController:root];
    [root addChildViewController:detailViewController];
    [detailViewController didMoveToParentViewController:root];
    [root addChildViewController:payImmeViewController];
    [payImmeViewController didMoveToParentViewController:root];
    [root addChildViewController:shoppingcartViewController];
    [shoppingcartViewController didMoveToParentViewController:root];

    return YES;
}
-(void)clearPayImmeView
{
    [payImmeViewController.view removeFromSuperview];
}

-(void)addPayImmeView
{
    [window.rootViewController.view addSubview:payImmeViewController.view];
}

-(void)addShoppingcartView
{
    [window.rootViewController.view addSubview:shoppingcartViewController.view];
}

-(void)clearShoppingcartView
{
    [shoppingcartViewController.view removeFromSuperview];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
