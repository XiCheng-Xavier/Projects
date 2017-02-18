//
//  Location.m
//  StudyTourMap
//
//  Created by 熙 程 on 14-4-13.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "Location.h"

@implementation Location
-(void)setLongtitude:(float)ln andLatitude:(float)lt
{
    lng = ln;
    lat = lt;
}
-(float)getLatitude
{
    return lat;
}

-(float)getLongtitude
{
    return lng;
}
@end
