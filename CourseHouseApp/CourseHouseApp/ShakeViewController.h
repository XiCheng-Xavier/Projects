//
//  ShakeViewController.h
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-23.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ShakeViewController.h"

@interface ShakeViewController : UIViewController
{
    SystemSoundID soundID;
    IBOutlet UIImageView *imgUp;
    IBOutlet UIImageView *imgDown;
}
@property(nonatomic,strong)UILabel *exchangeLabel1;
@property(nonatomic,strong)UILabel *exchangeLabel2;
@property(nonatomic,strong)NSString *image1URL;
@property(nonatomic,strong)NSString *image2URL;
@property(nonatomic,strong)NSString *goodsName1;
@property(nonatomic,strong)NSString *goodsName2;
@property(nonatomic,strong)NSString *goodsHost1;
@property(nonatomic,strong)NSString *goodsHost2;

@end
