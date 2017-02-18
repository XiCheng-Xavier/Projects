//
//  ShoppingcartTableViewController.h
//  ShowGoodsSystem
//
//  Created by 熙 程 on 14-4-10.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelHeader.h"
#import "ShoppingcartTableViewCell.h"
@interface ShoppingcartTableViewController : UITableViewController
@property(nonatomic,strong)NSMutableArray *goodsArray;

-(void)addObserver;
@end
