//
//  AppDelegate.m
//  StudyTourMap
//
//  Created by 熙 程 on 14-4-12.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "AppDelegate.h"
#import "IpadMainViewController.h"


@implementation AppDelegate
@synthesize window;
@synthesize masterViewController;
@synthesize videoViewController;
@synthesize mapViewController;
@synthesize introductionViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"B0lVdTEEVrzB9pmOfDxh9Mvo"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    // Add the navigation controller's view to the window and display.
    [self.window makeKeyAndVisible];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
        masterViewController = [story instantiateViewControllerWithIdentifier:@"master"];
        mapViewController = [story instantiateViewControllerWithIdentifier:@"map"];
        videoViewController = [story instantiateViewControllerWithIdentifier:@"video"];
        [window.rootViewController.view addSubview:masterViewController.view];
        [window.rootViewController.view addSubview:mapViewController.view];
        introductionViewController = [story instantiateViewControllerWithIdentifier:@"introduction"];
        UIViewController *root = window.rootViewController;
        [root addChildViewController:masterViewController];
        [masterViewController didMoveToParentViewController:root];
        [root addChildViewController:mapViewController];
        [mapViewController didMoveToParentViewController:root];
        [root addChildViewController:videoViewController];
        [videoViewController didMoveToParentViewController:root];
        [root addChildViewController:introductionViewController];
        [introductionViewController didMoveToParentViewController:root];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(changeDetailView:) name:@"selectRow" object:nil];
        [center addObserver:self selector:@selector(showVideoView:) name:@"videoShow" object:nil];
        
    }
    return YES;
}
-(void)clearViews//移除所有已有的subviews
{
    for(UIView *view in [window.rootViewController.view subviews])
    {
        [view removeFromSuperview];
    }

}
-(void)changeDetailView:(NSNotification *)notification
{
    NSString *selectedRow = [notification object];
    [self clearViews];
    [window.rootViewController.view addSubview:masterViewController.view];
    if ([selectedRow isEqualToString:@"0"]) {
        [window.rootViewController.view addSubview:mapViewController.view];
    }
    if ([selectedRow isEqualToString:@"1"]) {
        [window.rootViewController.view addSubview:introductionViewController.view];
    }
}
-(void)showVideoView:(NSNotification *)notification
{
    NSString *tag = [notification object];
    if ([tag isEqualToString:@"show"])
    {
        [mapViewController.view removeFromSuperview];
        [window.rootViewController.view addSubview:videoViewController.view];
    }
    if ([tag isEqualToString:@"remove"])
    {
        [videoViewController.view removeFromSuperview];
        [window.rootViewController.view addSubview:mapViewController.view];
    }
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
