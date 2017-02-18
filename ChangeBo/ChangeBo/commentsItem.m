//
//  commentsItem.m
//  ChangeBo
//
//  Created by ioscourse  on 13-8-27.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import "commentsItem.h"

@implementation commentsItem
-(id)initWithUserName:(NSString *)n andComment:(NSString *)c andImageURL:(NSString *)u andCommentID:(NSString *)i andCreateTime:(NSString *)t andWeiboID:(NSString *)w
{
    self=[super init];
    if(self){
        self.UserName = n;
        self.Comment = c;
        self.ImageURL = u;
        self.CommentID = i;
        self.CreateTime = t;
        self.WeiboID = w;
    }
    return self;
}
@end
