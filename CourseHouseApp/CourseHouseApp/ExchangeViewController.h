//
//  ExchangeViewController.h
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-22.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShakeViewController.h"
#import "ExchangeSearchViewController.h"
#import "ResultTableViewController.h"
#import "DetailViewController.h"

@interface ExchangeViewController : UIViewController
@property(nonatomic,strong)IBOutlet UIButton *searchButton;
@property(nonatomic,strong)IBOutlet UIButton *shakeButton;
@property(nonatomic,strong)ShakeViewController *shakeViewController;
@property(nonatomic,strong)ExchangeSearchViewController *searchViewController;

-(IBAction)searchButtonClicked:(id)sender;
-(IBAction)shakeButtonClicked:(id)sender;
@end
