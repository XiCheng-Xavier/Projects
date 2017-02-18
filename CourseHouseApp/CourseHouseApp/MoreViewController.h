//
//  MoreViewController.h
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-18.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *settingCatalog;
@property(nonatomic,strong)IBOutlet UITableView *moreTableView;
@end
