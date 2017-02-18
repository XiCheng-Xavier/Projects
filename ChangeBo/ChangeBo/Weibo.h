//
//  Weibo.h
//  readWeiboDemo
//
//  Created by ioscourse  on 13-8-28.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weibo : NSObject

@property (nonatomic, strong) NSString*     WeiboID; //微博ID
@property (nonatomic, strong) NSString*     createdAt;//微博创建时间
@property (nonatomic, strong) NSString*     text; //微博信息内容
@property (nonatomic, strong) NSString*     source; //微博来源


@property (nonatomic, strong) NSString*		thumbnailPic; //缩略图
@property (nonatomic, strong) NSString*		bmiddlePic; //中型图片
@property (nonatomic, strong) NSString*		originalPic; //原始图片

@property (nonatomic, strong) NSString*     HostName;//作者姓名
@property (nonatomic, strong) NSString*     HostHeadImageURL; //作者头像

@property (nonatomic, assign) int           commentsCount; //评论数
@property (nonatomic, assign) int           transpondCount; // 转发数
@property (nonatomic, retain) Weibo*       transpondedWeibo; //转发的博文，内容为Weibo，如果不是转发，则没有此字段


@property (nonatomic, assign) BOOL          hasTranspond;
@property (nonatomic, assign) BOOL          haveTranspondImage;
@property (nonatomic, assign) BOOL          hasImage;

- (Weibo*)initWithJsonDictionary:(NSDictionary*)dic;
-(Weibo*)WeiboWithJsonDictionary:(NSDictionary*)dic;
@end
