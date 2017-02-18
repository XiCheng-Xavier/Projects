//
//  Location.h
//  StudyTourMap
//
//  Created by 熙 程 on 14-4-13.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject
{
    float lng;
    float lat;
}
-(void)setLongtitude:(float)ln andLatitude:(float)lt;
-(float)getLongtitude;
-(float)getLatitude;

@end
