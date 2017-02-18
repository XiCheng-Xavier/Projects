//
//  Tea.m
//  BussinessSystem
//
//  Created by 熙 程 on 14-3-10.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "Tea.h"

@implementation Tea
-(id)initWithName:(NSString *)n andYearPriceDic:(NSMutableDictionary *)y
{
    self = [super init];
    if (self) {
        name = n;
        yearPrice = y;
    }
    return self;
}
-(NSString *)getName
{
    return name;
}
-(NSMutableDictionary *)getYearPriceDic
{
    return yearPrice;
}
@end
