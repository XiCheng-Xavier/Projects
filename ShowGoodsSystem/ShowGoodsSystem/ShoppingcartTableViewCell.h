//
//  ShoppingcartTableViewCell.h
//  ShowGoodsSystem
//
//  Created by 熙 程 on 14-4-10.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingcartTableViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UIImageView *goodsImageView;
@property(nonatomic,strong)IBOutlet UILabel *nameLabel;
@property(nonatomic,strong)IBOutlet UILabel *amountLabel;
@property(nonatomic,strong)IBOutlet UILabel *unitPriceLabel;
@property(nonatomic,strong)IBOutlet UILabel *priceLabel;
-(IBAction)cancelItems:(id)sender;
@end
