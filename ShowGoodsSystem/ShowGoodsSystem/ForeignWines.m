//
//  ForeignWines.m
//  BussinessSystem
//
//  Created by 熙 程 on 14-3-10.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "ForeignWines.h"

@implementation ForeignWines

+(NSArray *)getItems
{
    NSMutableArray *itemsArray =[[NSMutableArray alloc]init];
    [itemsArray addObject:[[Wine alloc]initWithName:@"卡慕vsop干邑" andVolumePriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"568",@"1000",@"1000",@"1500",nil]]];
    
    [itemsArray addObject:[[Wine alloc]initWithName:@"人头马club干邑" andVolumePriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"1000",@"1000",@"1360",@"1500",nil]]];
    
    [itemsArray addObject:[[Wine alloc]initWithName:@"马爹利名士干邑" andVolumePriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"458",@"700",@"600",@"1000",nil]]];
    
    [itemsArray addObject:[[Wine alloc]initWithName:@"嘉宝20年陈酿干邑" andVolumePriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"1218",@"700",@"1680",@"1000",nil]]];
    
    [itemsArray addObject:[[Wine alloc]initWithName:@"轩尼诗vsop" andVolumePriceDic:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"800",@"1000",@"976",@"1500",nil]]];
    
    return itemsArray;
}

@end
