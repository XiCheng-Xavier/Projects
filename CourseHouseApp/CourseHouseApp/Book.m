
//
//  Book.m
//  searchResult
//
//  Created by 熙 程 on 14-4-23.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "Book.h"

@implementation Book

-(id)initWithTitle:(NSString *)t andPrice:(NSString *)p andImageURL:(NSString *)i andAuthor:(NSString *)a andSoldAmount:(NSString *)s andDetailURL:(NSString *)d
{
    self = [super init];
    self.title = t;
    self.price = p;
    self.imageURL = i;
    self.author = a;
    self.soldAmount = s;
    self.detailURL = d;
    return self;
}

@end
