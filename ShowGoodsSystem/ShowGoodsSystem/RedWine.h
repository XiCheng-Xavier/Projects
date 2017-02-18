//
//  RedWine.h
//  BussinessSystem
//
//  Created by 熙 程 on 14-3-10.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedWine : NSObject{
    NSString *name;
    NSMutableDictionary *yearPrice;
}
-(id)initWithName:(NSString *)n andYearPriceDic:(NSDictionary *)y;
-(NSString *)getName;
-(NSMutableDictionary *)getYearPriceDic;
@end

