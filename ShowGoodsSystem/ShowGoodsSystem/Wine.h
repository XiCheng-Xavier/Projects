//
//  Wine.h
//  BussinessSystem
//
//  Created by 熙 程 on 14-3-10.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Wine : NSObject{
    NSString *name;
    NSMutableDictionary *volumePrice;

}
-(id)initWithName:(NSString *)n andVolumePriceDic:(NSMutableDictionary *)v;
-(NSString *)getName;
-(NSMutableDictionary *)getVolumePriceDic;
@end
