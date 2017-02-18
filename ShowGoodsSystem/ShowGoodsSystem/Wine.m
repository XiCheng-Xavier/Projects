//
//  Wine.m
//  BussinessSystem
//
//  Created by 熙 程 on 14-3-10.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "Wine.h"

@implementation Wine
-(id)initWithName:(NSString *)n andVolumePriceDic:(NSMutableDictionary *)v
{
    self = [super init];
    if (self) {
        name = n;
        volumePrice = v;
    }
    
    return self;
}
-(NSString *)getName
{
    return name;
}
-(NSMutableDictionary *)getVolumePriceDic
{
    return volumePrice;
}

@end
