//
//  ResultTableViewController.h
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-24.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "BookResultCell.h"
#import "NSString+EncodingUTF8Additions.h"

@interface ResultTableViewController : UITableViewController
@property(nonatomic,strong)NSString *keyWord;
@property(nonatomic,strong)NSMutableArray *resultsArray;
@end
