//
//  News.h
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-24.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property(nonatomic,strong)NSMutableArray *hotNewsArray;
@property(nonatomic,strong)NSMutableArray *localNewsArray;
-(NSMutableArray *)getHotNewsArray;
-(NSMutableArray *)getLocalNewsArray;
@end
