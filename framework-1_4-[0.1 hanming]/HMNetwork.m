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

- (NSMutableDictionary *)convertDataToBeSend:(NSMutableDictionary *)theData{
    NSMutableDictionary * convertedData = [NSMutableDictionary new];
    NSEnumerator *enumerator = [theData keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        NSString *strData = @"sss";
        [convertedData setObject: strData forKey:key];
    }
    return convertedData;
}


-(void) sendData: (NSMutableDictionary *)param{
    //0. 处理下param
    NSLog(@"param:  %@", param);
    //NSMutableDictionary *dataToBeSend = [self convertDataToBeSend:param];
    
    //NSMutableDictionary *dataToBeSend = [NSMutableDictionary new];
    //[dataToBeSend setObject:@"xxx" forKey:@"yyy"];

    
    //1. 初始化request
    MKNetworkRequest *request = [engine requestWithPath: @"/" params: param httpMethod:@"POST"];
    //回调函数
    [request addCompletionHandler:^(MKNetworkRequest *operation){
        NSString *data = [operation responseAsString];
        NSLog(@"content is %@",data);
    }];
    //开始网络传输
    [engine startRequest:request];
}




- (void)sendPlanHistory{
    
    /* 计划的完成情况
     currentNumber = 0; 没用
     done = 0; 做了没有（暂时没用）
     effect = "6.000000"; 权重
     fin1 = 1; 完成
     fin2 = 0; 没完成
     fin3 = 0;
     fin4 = 0;
     fintime1 = "2016-01-21 19:58:27"; 完成的时间
     fintime2 = "2016-01-20 19:30:45";
     fintime3 = "2016-01-20 19:30:47";
     fintime4 = "2016-01-20 19:30:42";
     flowerState = 2; 完成时花的状态
     have = 1; 有无计划
     id = 13; 各个plan条目的计划
     id1 = 63;
     id2 = 15;
     id3 = 23;
     id4 = 0;
     number = 3; plan条目的数量
     output1 = ""; 用户的输入
     output2 = "";
     output3 = "";
     output4 = "";
     stress0 = "5.000000"; 计划产生时的压力
     stress1 = "5.000000"; plan条目1完成时的压力
     stress2 = "76.000000";
     stress3 = "76.000000";
     stress4 = 0;
     stress5 = "2.000000";
     time0 = "2016-01-21 19:56:44"; 计划生成的时间
     time1 = "2016-01-22 16:00:00"; 各个条目设定的时间
     time2 = "2016-01-25 20:00:00";
     time3 = "2016-01-28 02:00:00";
     time4 = "2016-01-20 19:30:42";
     type1 = 1; 交互类型
     type2 = 1;
     type3 = 6;
     type4 = 0;
     */
    NSLog(@"inter function sendPlanHistory");
    KCDbManager* manager = [KCDbManager new];
    [manager openDb:sqlFileName];
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM History"];
    NSArray * array = [manager executeQuery:sql];
    NSLog(@"get all sendPlanHistory %@",array);
    [self sendData:array[0]];
    /*
    for (int i=0; i<array.count; i++) {
        [self sendData:array[i]];
        NSLog(@"have sent data");
        break;
        
    }
     */
}

- (void)sendPlanItem{//计划具体是啥内容
    /* item.h里有写
     chan = 1;
     clus = 1;
     content1 = "\U9633\U5149\U660e\U5a9a\U7684\U65e5\U5b50\U548c\U4e00\U4f17\U670b\U53cb\U53bb\U9a91\U884c";
     content2 = "";
     content3 = "";
     diff = "1.0";
     effe = 1;
     id = 100;
     info = "\U548c\U670b\U53cb\U53bb\U9a91\U884c";
     inte = 1;
     numb = 0;
     pref = 1;
     sour = 9;
     */
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