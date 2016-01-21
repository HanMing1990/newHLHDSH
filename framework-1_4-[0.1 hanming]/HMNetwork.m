//
//  HMNetwork.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/20.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMNetwork.h"
#import "static.h"
#import "KCDbManager.h"

@implementation HMNetwork
//@synthesize ID;
@synthesize engine;
-(id)init {
    if(self = [super init]){
        //1. 初始化engine
        self.engine = [[MKNetworkHost alloc] initWithHostName:[NSString stringWithFormat:@"%@:%@",IP,PORT]];
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
- (void)sendPlanHistory{
    NSLog(@"inter function sendPlanHistory");
    KCDbManager* manager = [KCDbManager new];
    [manager openDb:sqlFileName];
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM History"];
    NSArray * array = [manager executeQuery:sql];
    NSLog(@"get all sendPlanHistory %@",array);
    for (int i=0; i<array.count; i++) {
        [self sendData:array[i]];
    }
}
- (void)sendPlanItem{
    NSLog(@"inter function sendPlanItemByID");
    KCDbManager* manager = [KCDbManager new];
    [manager openDb:sqlFileName];
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM PlanList"];
    NSArray * array = [manager executeQuery:sql];
    NSLog(@"get all sendPlanItemByID %@",array);
    for (int i=0; i<array.count; i++) {
        [self sendData:array[i]];
    }
}
@end