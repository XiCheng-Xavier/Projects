//
//  commentsItem.h
//  ChangeBo
//
//  Created by ioscourse  on 13-8-27.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commentsItem : NSObject

@property(nonatomic, strong)NSString *UserName;
@property(nonatomic, strong)NSString *Comment;
@property(nonatomic, strong)NSString *ImageURL;
@property(nonatomic, strong)NSString *CommentID;
@property(nonatomic, strong)NSString *CreateTime;
@property(nonatomic, strong)NSString *WeiboID;
-(id)initWithUserName:(NSString *)u andComment:(NSString *)c andImageURL:(NSString *)u andCommentID:(NSString *)i andCreateTime:(NSString *)t andWeiboID:(NSString *)w;
@end
