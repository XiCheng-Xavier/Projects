//
//  MainViewController.h
//  ShowGoodsSystem
//
//  Created by 熙 程 on 14-4-9.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayImmeTableViewController.h"
@interface MainViewController : UIViewController<UIScrollViewDelegate>
@property(nonatomic,strong)IBOutlet UINavigationBar *masterNavBar;
@property(nonatomic,strong)UIScrollView *blowupScrollView;
@property(nonatomic,strong)UIView *backgroundView;
-(IBAction)gotoShopppingcart:(id)sender;
@end
