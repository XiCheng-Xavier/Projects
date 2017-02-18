//
//  RedWine.m
//  BussinessSystem
//
//  Created by 熙 程 on 14-3-10.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "RedWine.h"

@implementation RedWine

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
-(NSDictionary *)getYearPriceDic
{
    return yearPrice;
    
}
@end
