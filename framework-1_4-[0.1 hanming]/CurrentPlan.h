//
//  CurrentPlan.h
//  store
//
//  Created by yangjun on 16/1/6.
//  Copyright © 2016年 yangjun. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "static.h"

@interface  CurrentPlan : NSObject{
    NSNumber* done;
    NSNumber* have;
    NSNumber* number; // 有多少个item
    NSNumber* currentNumber;
    NSNumber* id1;
    NSNumber* id2;
    NSNumber* id3;
    NSNumber* id4;
    NSNumber* type1;
    NSNumber* type2;
    NSNumber* type3;
    NSNumber* type4;
    NSDate* time0;
    NSDate* time1;
    NSDate* time2;
    NSDate* time3;
    NSDate* time4;
    NSDate* fintime1;
    NSDate* fintime2;
    NSDate* fintime3;
    NSDate* fintime4;
    NSNumber* fin1;
    NSNumber* fin2;
    NSNumber* fin3;
    NSNumber* fin4;
    NSString* info1;
    NSString* info2;
    NSString* info3;
    NSString* info4;
    NSNumber* sour1;
    NSNumber* sour2;
    NSNumber* sour3;
    NSNumber* sour4;
    NSString* content1;  //计划1的内容，由于篇幅限制，只取要显示的第一个内容
    NSString* content2;  //计划2的内容，由于篇幅限制，只取要显示的第一个内容
    NSString* content3;  //计划3的内容，由于篇幅限制，只取要显示的第一个内容
    NSString* content4;  //计划4的内容，由于篇幅限制，只取要显示的第一个内容
    NSString* output1;
    NSString* output2;
    NSString* output3;
    NSString* output4;
    NSString* stress0; //初始的压力值
    NSString* stress1;
    NSString* stress2;
    NSString* stress3;
    NSString* stress4;
    NSString* stress5;  //3 day after last day plan结束时候的压力值
    NSString* effect;   //
}
@property(retain,nonatomic)    NSNumber* done;
@property(retain,nonatomic)    NSNumber* have;
@property(retain,nonatomic)    NSNumber* number;
@property(retain,nonatomic)    NSNumber* currentNumber;
@property(retain,nonatomic)    NSNumber* id1;
@property(retain,nonatomic)    NSNumber* id2;
@property(retain,nonatomic)    NSNumber* id3;
@property(retain,nonatomic)    NSNumber* id4;
@property(retain,nonatomic)    NSNumber* type1;
@property(retain,nonatomic)    NSNumber* type2;
@property(retain,nonatomic)    NSNumber* type3;
@property(retain,nonatomic)    NSNumber* type4;
@property(retain,nonatomic)    NSDate* time0;
@property(retain,nonatomic)    NSDate* time1;
@property(retain,nonatomic)    NSDate* time2;
@property(retain,nonatomic)    NSDate* time3;
@property(retain,nonatomic)    NSDate* time4;
@property(retain,nonatomic)    NSDate* fintime1;
@property(retain,nonatomic)    NSDate* fintime2;
@property(retain,nonatomic)    NSDate* fintime3;
@property(retain,nonatomic)    NSDate* fintime4;
@property(retain,nonatomic)    NSNumber* fin1;
@property(retain,nonatomic)    NSNumber* fin2;
@property(retain,nonatomic)    NSNumber* fin3;
@property(retain,nonatomic)    NSNumber* fin4;
@property(retain,nonatomic)    NSString* info1;
@property(retain,nonatomic)    NSString* info2;
@property(retain,nonatomic)    NSString* info3;
@property(retain,nonatomic)    NSString* info4;
@property(retain,nonatomic)    NSNumber* sour1;
@property(retain,nonatomic)    NSNumber* sour2;
@property(retain,nonatomic)    NSNumber* sour3;
@property(retain,nonatomic)    NSNumber* sour4;
@property(retain,nonatomic)    NSString* content1;
@property(retain,nonatomic)    NSString* content2;
@property(retain,nonatomic)    NSString* content3;
@property(retain,nonatomic)    NSString* content4;
@property(retain,nonatomic)    NSString* output1;
@property(retain,nonatomic)    NSString* output2;
@property(retain,nonatomic)    NSString* output3;
@property(retain,nonatomic)    NSString* output4;
@property(retain,nonatomic)    NSString* stress0;
@property(retain,nonatomic)    NSString* stress1;
@property(retain,nonatomic)    NSString* stress2;
@property(retain,nonatomic)    NSString* stress3;
@property(retain,nonatomic)    NSString* stress4;
@property(retain,nonatomic)    NSString* stress5;
@property(retain,nonatomic)    NSString* effect;
- (void) save;
@end

