//
//  ExchangeSearchViewController.h
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-23.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeSearchViewController : UIViewController

@property(nonatomic,strong)IBOutlet UITextField *searchTextField;
@property(nonatomic,strong)IBOutlet UIButton *searchButton;
@property(nonatomic,strong)IBOutlet UIButton *cityChooseButton;
@property(nonatomic,strong)IBOutlet UILabel *label;

-(IBAction)searchButtonClicked:(id)sender;

@end
