//
//  DetailViewController.h
//  ShowGoodsSystem
//
//  Created by 熙 程 on 14-4-9.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelHeader.h"
#import "PicFrame.h"
@interface DetailViewController : UIViewController<UIScrollViewDelegate>
{
    int section;//masterView中选择的section
    int row;//masterView中选择的row
    int index;//储存当前显示属性下标
    int tag;//scollView中选中的图片下标
    PicFrame *pf;//scrllView中图片选中的白色边框
}
@property(nonatomic,strong)NSMutableArray *goodsInShoppingcart;//购物车数组
@property(nonatomic,strong)NSDictionary *attributeDic;
@property(nonatomic,strong)NSArray *attributeArr;
@property(weak,nonatomic)IBOutlet UIImageView *imageView;
@property(strong,nonatomic)IBOutlet UILabel *nameLabel;
@property(strong,nonatomic)IBOutlet UILabel *attributeLabel;
@property(strong,nonatomic)IBOutlet UITextField *attributeTextField;
-(IBAction)changeAttributeToRight:(id)sender;
-(IBAction)changeAttributeToLeft:(id)sender;
@property(strong,nonatomic)IBOutlet UITextField *numberTextField;
-(IBAction)addNumber:(id)sender;
-(IBAction)reduceNumber:(id)sender;
@property(strong,nonatomic)IBOutlet UILabel *priceLabel;
@property(strong,nonatomic)IBOutlet UIScrollView *scrollView;
@property(strong,nonatomic)IBOutlet UIScrollView *imageScrollView;
-(IBAction)buyImmediately:(id)sender;
-(IBAction)addToShoppingcart:(id)sender;


@end
