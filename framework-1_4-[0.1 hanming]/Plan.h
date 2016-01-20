//
//  Plan.h
//  store
//
//  Created by yangjun on 16/1/6.
//  Copyright © 2016年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "InitSqlite3.h"
#import "CurrentLevel.h"
#import "CurrentPlan.h"
#import "static.h"

@interface Plan : NSObject{
    CurrentPlan* currentPlan;
}
@property(retain,nonatomic)    CurrentPlan* currentPlan;
- (void) store;                    //当计划完成之后（或者到最后一个ddl之后），需要将计划完成情况存储到数据库中
- (void) recordStress5;            //store调用，内部函数
- (void) update;                   //store调用，内部函数
- (Item *) getItemById:(NSNumber* )newId;         // 通过id得到item实例
- (Item *) changeItemById:(NSNumber* )newId;      // 根据当前的id换一个事件
- (void) createNewPlan;                           //生成一个新的plan并且赋值给currentPlan
- (Item *) selectItemRandomly;                    //随机滴选一个item
- (BOOL) judge:(int) newId round:(int) newRound;  //判断当前plan的第newRoundg个事件newid是否满足条件－》要考虑的就是一个月内不重复呀等等。
- (void) finishItem:(BOOL) yesOrNo forId:(NSNumber* ) newId Content:(NSString* ) newContent;  //每个事件做完（或取消）之后，都要存储执行结果（是否完成fin字段以及反馈的内容）
- (NSString* )getJokeItemRandomly;
- (NSString* )getPictureItemRandomly;
- (void) insertLevelItem;
- (NSArray* )getStressLevel;
- (NSArray* )getStepLevel;
- (NSArray* )getSleepLevel;
- (NSArray* )getCalorieLevel;
@end