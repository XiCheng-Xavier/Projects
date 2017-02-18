//
//  SearchViewController.h
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-14.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultTableViewController.h"

@interface SearchViewController : UIViewController
{
    int buttonTag;
    int imageTag;
}
@property(nonatomic,strong)IBOutlet UITextField *searchTextField;
@property(nonatomic,strong)IBOutlet UIButton *searchButton;
@property(nonatomic,strong)IBOutlet UIButton *cityChooseButton;
@property(nonatomic,strong)IBOutlet UILabel *label;
@property(nonatomic,strong)IBOutlet UIView *hotspotBackgroundView;
@property(nonatomic,strong)IBOutlet UILabel *localCityLabel;
@property(nonatomic,strong)IBOutlet UIButton *moreHotspotButton;
@property(nonatomic,strong)IBOutlet UIButton *moreLocalButton;
@property(nonatomic,strong)IBOutlet UIImageView *hotNewsImageView1;
@property(nonatomic,strong)IBOutlet UIImageView *hotNewsImageView2;
@property(nonatomic,strong)IBOutlet UIImageView *localNewsImageView1;
@property(nonatomic,strong)IBOutlet UIImageView *localNewsImageView2;
-(IBAction)goToSearchResult:(id)sender;
-(IBAction)moreHotNews:(id)sender;
-(IBAction)moreLocalNews:(id)sender;

@property(nonatomic,strong) UITabBarItem *tabBaritem;
@end
