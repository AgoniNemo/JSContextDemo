//
//  JSObject.m
//  XingLiIM
//
//  Created by Mjwon on 2017/1/12.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "JSObject.h"

@implementation JSObject

- (instancetype)initWithDelegate:(id<JSExportDelegate>)scriptDelegate
{
    if (self == [super init]) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

-(NSString *)getAccessToken
{
    return @"这是js的token";
}

-(void)dealloc
{
    NSLog(@"JSObject被释放了!!!");
}
@end
