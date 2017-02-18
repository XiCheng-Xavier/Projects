//
//  Weibo.m
//  readWeiboDemo
//
//  Created by ioscourse  on 13-8-28.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import "Weibo.h"

@implementation Weibo

- (Weibo*)initWithJsonDictionary:(NSDictionary*)dic {
    
	if (self = [super init]) {
        
		self.WeiboID = [dic objectForKey:@"id"];
        self.createdAt = [dic objectForKey:@"created_at"];
        self.text = [dic objectForKey:@"text"];
		
		//parse source parameter 处理微博信息来源
		NSString *src = [dic objectForKey:@"source"];
			NSRange start,end,r;
			start = [src rangeOfString:@"\">"];
			end   = [src rangeOfString:@"</a>"];
			if (start.location != NSNotFound && end.location != NSNotFound) {
				r.location = start.location + start.length;
				r.length = end.location - r.location;
				self.source = [src substringWithRange:r];
			}
			else {
				self.source = @"";
			}
	
        
        
		//图像地址，小，中，大URL
      
        self.thumbnailPic = [dic objectForKey:@"thumbnail_pic"];
        self.bmiddlePic = [dic objectForKey:@"bmiddle_pic"];
        self.originalPic = [dic objectForKey:@"original_pic"];
		
        
        self.commentsCount = [[dic objectForKey:@"comments_count"] integerValue];
        self.transpondCount = [[dic objectForKey:@"reposts_count"] integerValue];
        
        //发博人姓名信息
		NSDictionary* userDic = [dic objectForKey:@"user"];
		if (userDic) {
			self.hostName = [userDic objectForKey:@"screen_name"];
            self.hostHeadImageURL = [userDic objectForKey:@"profile_image_url"];
		}
	
		NSDictionary* retweetedStatusDic = [dic objectForKey:@"retweeted_status"];
        
		if (retweetedStatusDic) {
            
            self.hasTranspond = YES;  //表示有转发
			self.transpondedWeibo = [[Weibo alloc]WeiboWithJsonDictionary:retweetedStatusDic];
            
            //有转发的博文
            if (self.transpondedWeibo && ![self.transpondedWeibo isEqual:[NSNull null]])
            {
                NSString *url = self.transpondedWeibo.thumbnailPic;
                self.haveTranspondImage = (url != nil && [url length] != 0 ? YES : NO); //转发部分是否有图像
            }
		}
        //无转发
        else
        {
            self.hasTranspond = NO;
            //当没有转发时，可以显示博文的image
            NSString *url = self.thumbnailPic;
            self.hasImage = (url != nil && [url length] != 0 ? YES : NO);
        }
	}
	return self;
}

 -(Weibo*)WeiboWithJsonDictionary:(NSDictionary*)dic
{
	return [[Weibo alloc] initWithJsonDictionary:dic];
}

@end
