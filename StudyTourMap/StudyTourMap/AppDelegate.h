//
//  AppDelegate.h
//  StudyTourMap
//
//  Created by 熙 程 on 14-4-12.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "VideoViewController.h"
#import "IpadMainViewController.h"
#import "IntroductionViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)UITableViewController *masterViewController;
@property(nonatomic,strong)VideoViewController *videoViewController;
@property(nonatomic,strong)IpadMainViewController *mapViewController;
@property(nonatomic,strong)IntroductionViewController *introductionViewController;

@end
