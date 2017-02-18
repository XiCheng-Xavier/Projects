//
//  TeaOfXiaguan.m
//  tableViewControllerDemo
//
//  Created by 熙 程 on 14-3-10.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "TeaOfXiaguan.h"

@implementation TeaOfXiaguan
+(NSMutableArray *)getItems{
    NSMutableArray *itemsArray =[[NSMutableArray alloc]init];
    [itemsArray addObject:[[Tea alloc]initWithName:@"FTT8653" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"180",@"2008",@"110",@"2013",nil]]];
    
    [itemsArray addObject:[[Tea alloc]initWithName:@"大雪山" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"550",@"2012",@"533",@"2013",nil]]];
    
    [itemsArray addObject:[[Tea alloc]initWithName:@"FTT8653" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"280",@"2009",@"270",@"2010",nil]]];
    
    [itemsArray addObject:[[Tea alloc]initWithName:@"勐库冰岛母树茶" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"1200",@"2010",@"1100",@"2011",nil]]];
    
    [itemsArray addObject:[[Tea alloc]initWithName:@"8853" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"750",@"2008",@"580",@"2012",nil]]];

    return itemsArray;
    
}
@end
