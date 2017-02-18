//
//  NewsViewController.h
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-24.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController
@property(nonatomic,strong)NSString *newsTitle;
@property(nonatomic,strong)NSString *passage;
@property(nonatomic,strong)IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)IBOutlet UITextView *passageTextView;
@end
