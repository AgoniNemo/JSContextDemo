//
//  JSObject.m
//  XingLiIM
//
//  Created by Mjwon on 2017/1/12.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "JSObject.h"

@implementation JSObject


-(NSString *)getAccessToken
{
    return @"这是JSObject的token";
}

-(void)dealloc
{
    NSLog(@"JSObject被释放了!!!");
}
@end
