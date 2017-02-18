//
//  ShoppingcartTableViewCell.m
//  ShowGoodsSystem
//
//  Created by 熙 程 on 14-4-10.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "ShoppingcartTableViewCell.h"

@implementation ShoppingcartTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction)cancelItems:(id)sender
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"cancelGoodsInCart" object:[NSNumber numberWithInteger:self.tag]];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
