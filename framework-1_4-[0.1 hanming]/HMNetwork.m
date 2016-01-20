//
//  HMNetwork.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/20.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMNetwork.h"
@implementation HMNetwork
//@synthesize ID;
@synthesize engine;
-(id)init {
    if(self = [super init]){
        //1. 初始化engine
        self.engine = [[MKNetworkHost alloc] initWithHostName:@"166.111.69.70:5000"];
    }
    return self;
}
-(void) sendData: (NSMutableDictionary *)param{
    //1. 初始化request
    MKNetworkRequest *request = [engine requestWithPath: @"/" params:param httpMethod:@"POST"];
    //回调函数
    [request addCompletionHandler:^(MKNetworkRequest *operation){
        NSString *data = [operation responseAsString];
        NSLog(@"content is %@",data);
    }];
    //开始网络传输
    [engine startRequest:request];
}

@end