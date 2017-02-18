//
//  RedWines.m
//  BussinessSystem
//
//  Created by 熙 程 on 14-3-10.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "RedWines.h"

@implementation RedWines
+(NSArray *)getItems{
    NSMutableArray *itemsArray =[[NSMutableArray alloc]init];
    [itemsArray addObject:[[RedWine alloc]initWithName:@"弗利欧凯门奈尔干红葡萄酒" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"180",@"2008",@"150",@"2009",@"100",@"2010",nil]]];
    
    [itemsArray addObject:[[RedWine alloc]initWithName:@"弗利欧特级珍藏干红葡萄酒" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"680",@"2008",@"580",@"2009",@"500",@"2010",nil]]];
    
    [itemsArray addObject:[[RedWine alloc]initWithName:@"苏提牵牛星干红葡萄酒" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"1000",@"2008",@"900",@"2009",@"850",@"2010",nil]]];
    
    [itemsArray addObject:[[RedWine alloc]initWithName:@"碧凯隆精选珍藏梅洛红葡萄酒" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"1800",@"2000",@"900",@"2009",@"800",@"2010",nil]]];
    
    [itemsArray addObject:[[RedWine alloc]initWithName:@"爱罗斯白葡萄酒" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"750",@"2008",@"680",@"2009",@"600",@"2010",nil]]];
    return itemsArray;
}

@end
