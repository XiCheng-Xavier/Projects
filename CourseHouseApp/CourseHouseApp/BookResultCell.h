//
//  BookResultCell.h
//  searchResult
//
//  Created by 熙 程 on 14-4-23.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookResultCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)IBOutlet UILabel *shopLabel;
@property(nonatomic,strong)IBOutlet UILabel *priceLabel;
@property(nonatomic,strong)IBOutlet UILabel *soldAmountLabel;
@property(nonatomic,strong)IBOutlet UIImageView *bookImageView;

@end
