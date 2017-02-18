//
//  Book.h
//  searchResult
//
//  Created by 熙 程 on 14-4-23.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *imageURL;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *soldAmount;
@property(nonatomic,strong)NSString *detailURL;


-(id)initWithTitle:(NSString *)t andPrice:(NSString *)p andImageURL:(NSString *)i andAuthor:(NSString *)a andSoldAmount:(NSString *)s andDetailURL:(NSString *)d;
@end
