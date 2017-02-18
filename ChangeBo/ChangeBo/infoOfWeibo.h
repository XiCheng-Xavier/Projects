//
//  infoOfWeibo.h
//  ChangeBo
//
//  Created by ioscourse  on 13-8-21.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import <Foundation/Foundation.h>
#define CLIENT_ID                          @"1285033847"
#define CLIENT_SECRET                      @"9b1bc4474991cdc0f9bc0ca1d39d96e6"
#define CLIENT_REDIRECT_URL                @"http://api.weibo.com/oauth2/default.html"
#define OAuth_URL                          @"https://api.weibo.com/oauth2/authorize"
#define ACCESS_TOKEN_URL                   @"https://api.weibo.com/oauth2/access_token"
#define GET_UID_URL                        @"https://api.weibo.com/2/account/get_uid.json"
#define FOLLOWERS_URL                      @"https://api.weibo.com/2/friendships/followers.json"
#define FRIENDS_TIMELINE                   @"https://api.weibo.com/2/statuses/friends_timeline.json"
#define USERS_TIMELINE                     @"https://api.weibo.com/2/statuses/user_timeline.json"
#define MENTIONS                           @"https://api.weibo.com/2/statuses/mentions.json"
#define WEIBO_UPDATE                       @"https://api.weibo.com/2/statuses/update.json"
#define WEIBO_UPLOAD                       @"https://api.weibo.com/2/statuses/upload.json"
#define WEIBO_GET_BY_ID                    @"https://api.weibo.com/2/statuses/show.json"
#define COMMENTS                           @"https://api.weibo.com/2/comments/to_me.json" //评论
#define AT_COMMENTS                        @"https://api.weibo.com/2/comments/mentions.json"//@我的评论
#define REPLY_COMMENT                      @"https://api.weibo.com/2/comments/reply.json"//回复评论
#define GIVE_COMMENT                       @"https://api.weibo.com/2/comments/create.json"//评论微博
#define UID                                @"2169331617"
#define REPOST                             @"https://api.weibo.com/2/statuses/repost.json"//转发
@interface infoOfWeibo : NSObject


@property(strong,nonatomic)NSString *AccessToken;

+(NSString *)returnAccessToken;

@end
