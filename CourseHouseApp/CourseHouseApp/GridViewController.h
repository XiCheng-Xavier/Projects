//
//  GridViewController.h
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-18.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridViewController : UIViewController

@property(nonatomic,strong)IBOutlet UIBarButtonItem *barItem;
@property(nonatomic,strong)IBOutlet UILabel *searchBackgroundLabel;
@property(nonatomic,strong)IBOutlet UILabel *gridShopLabel;
@property(nonatomic,strong)IBOutlet UITextField *searchTextField;
@property(nonatomic,strong)IBOutlet UILabel *buttonsLabel;
@property(nonatomic,strong)IBOutlet UIButton *timeButton;
@property(nonatomic,strong)IBOutlet UIButton *soldNumberButton;
@property(nonatomic,strong)IBOutlet UIButton *goodsAmountButton;
@property(nonatomic,strong)IBOutlet UIButton *soldOutButton;
@property(nonatomic,strong)IBOutlet UIScrollView *itemsScrollView;

@end
