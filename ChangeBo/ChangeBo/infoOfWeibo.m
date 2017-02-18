//
//  infoOfWeibo.m
//  ChangeBo
//
//  Created by ioscourse  on 13-8-21.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import "infoOfWeibo.h"





@implementation infoOfWeibo

+ (NSString *) returnAccessToken {
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];

}

@end
