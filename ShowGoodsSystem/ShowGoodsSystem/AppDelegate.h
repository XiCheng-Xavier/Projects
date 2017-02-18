//
//  AppDelegate.h
//  ShowGoodsSystem
//
//  Created by 熙 程 on 14-4-9.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayImmeTableViewController.h"
#import "ShoppingcartTableViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)PayImmeTableViewController *payImmeViewController;
@property(nonatomic,strong)ShoppingcartTableViewController *shoppingcartViewController;
@end
