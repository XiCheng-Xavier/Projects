//
//  PayImmeTableViewController.h
//  ShowGoodsSystem
//
//  Created by 熙 程 on 14-4-10.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelHeader.h"
@interface PayImmeTableViewController : UITableViewController

@property(nonatomic,strong)Goods *goods;
-(void)addObserver;
@end
