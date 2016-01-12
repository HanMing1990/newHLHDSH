//
//  Plan.h
//  store
//
//  Created by yangjun on 16/1/6.
//  Copyright © 2016年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface Plan : NSObject{
    NSNumber* done;  //是否已经完成，1:已经完成 2:没有完成
    NSNumber* have;  //是否有计划，1:有，2:没有
    NSNumber* number; //一个计划含有的事件，一般为3
    NSNumber* id1;    //事件1的id
    NSNumber* id2;    //事件2的id
    NSNumber* id3;    //事件3的id
    NSNumber* id4;    //事件4的id
    NSNumber* type1;  //事件1的交互类型，通过这个可以选择不同的交互界面
    NSNumber* type2;  //事件2的交互类型，通过这个可以选择不同的交互界面
    NSNumber* type3;  //事件3的交互类型，通过这个可以选择不同的交互界面
    NSNumber* type4;  //事件4的交互类型，通过这个可以选择不同的交互界面
    NSDate* time0;    //计划生成时的时间
    NSDate* time1;    //计划1的预设时间
    NSDate* time2;    //计划2的预设时间
    NSDate* time3;    //计划3的预设时间
    NSDate* time4;    //计划4的预设时间
    NSNumber* fin1;   //计划1是否完成
    NSNumber* fin2;   //计划2是否完成
    NSNumber* fin3;   //计划3是否完成
    NSNumber* fin4;   //计划4是否完成
    NSString* content1;  //计划1的内容，由于篇幅限制，只取要显示的第一个内容
    NSString* content2;  //计划2的内容，由于篇幅限制，只取要显示的第一个内容
    NSString* content3;  //计划3的内容，由于篇幅限制，只取要显示的第一个内容
    NSString* content4;  //计划4的内容，由于篇幅限制，只取要显示的第一个内容
    NSString* stress0;  //生成计划时的压力值
    NSString* stress1;  //计划1执行时的压力值
    NSString* stress2;  //计划2执行时的压力值
    NSString* stress3;  //计划3执行时的压力值
    NSString* stress4;  //计划4执行时的压力值
    
    NSString* stress5;  //? 计划4执行后3天的压力值，因为呀，据有关调查显示，这个压力值过一段时间才会降下来
    NSString* effect;   //? 评估整个计划的效果，评估效果作为反馈来更新每一个item的内容
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
@property(retain,nonatomic)    NSNumber* fin1;
@property(retain,nonatomic)    NSNumber* fin2;
@property(retain,nonatomic)    NSNumber* fin3;
@property(retain,nonatomic)    NSNumber* fin4;
@property(retain,nonatomic)    NSString* stress0;
@property(retain,nonatomic)    NSString* stress1;
@property(retain,nonatomic)    NSString* stress2;
@property(retain,nonatomic)    NSString* stress3;
@property(retain,nonatomic)    NSString* stress4;
@property(retain,nonatomic)    NSString* stress5;
@property(retain,nonatomic)    NSString* effect;
- (void) store;                    //当计划完成之后（或者到最后一个ddl之后），需要将计划完成情况存储到数据库中
- (void) recordStress5;            //store调用，内部函数
- (void) calcEffect;               //store调用，内部函数
- (void) update;                   //store调用，内部函数
- (Item *) getItemById:(NSNumber* )newId;
@end