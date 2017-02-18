//
//  TeaOfDayi.m
//  BussinessSystem
//
//  Created by 熙 程 on 14-3-10.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "TeaOfDayi.h"

@implementation TeaOfDayi
+(NSMutableArray *)getItems{
    NSMutableArray *itemsArray =[[NSMutableArray alloc]init];
    [itemsArray addObject:[[Tea alloc]initWithName:@"金针白莲" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"400",@"2008",@"251",@"2012",nil]]];
    
    [itemsArray addObject:[[Tea alloc]initWithName:@"龙印" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"1680",@"2012",@"1500",@"2013",nil]]];
    
    [itemsArray addObject:[[Tea alloc]initWithName:@"7572" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"200",@"2009",@"150",@"2011",nil]]];
    
    [itemsArray addObject:[[Tea alloc]initWithName:@"7542-301" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"450",@"2010",@"380",@"2013",nil]]];
    
    [itemsArray addObject:[[Tea alloc]initWithName:@"灵蛇献宝" andYearPriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"660",@"2012",@"580",@"2013",nil]]];

    return itemsArray;
}
@end
