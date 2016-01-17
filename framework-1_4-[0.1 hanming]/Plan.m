//
//  Plan.m
//  store
//
//  Created by yangjun on 16/1/6.
//  Copyright © 2016年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCDbManager.h"
#import "Plan.h"


#define EFFECT_BIAS     1.0   //用来计算effect，计算公式暂时定位  （ effe + EFFECT_BIAS ）／ EFFECT_BIAS
#define PREFERENCE_BIAS 0.6   //这个是用来更新这个 pref 滴，如果他做啦就除以这个值（变大啦），如果没做，就乘上这个值（变小啦）
@implementation Plan

@synthesize currentPlan;
- (void) store{
    NSLog(@"inter function store");
    //用currentplan的值给这个类赋值
    currentPlan = [CurrentPlan new];
    
    [self recordStress5];
    [self update];
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO History \
    (done, have, number, currentNumber, id1, id2, id3, id4, type1, type2, type3, type4, time0, time1, time2, time3 ,time4 ,fin1, fin2, fin3, fin4,\
    stress1, stress2, stress3, stress4, stress5, effect) VALUES \
    ('%@',  '%@','%@',   '%@',         '%@', '%@','%@','%@','%@',  '%@',  '%@',  '%@',  '%@',  '%@',  '%@',  '%@',  '%@', '%@', '%@',  '%@', '%@',\
    '%@',    '%@',    '%@',   '%@',    '%@',    '%@');",
     currentPlan.done, currentPlan.have, currentPlan.number, currentPlan.currentNumber, currentPlan.id1, currentPlan.id2, currentPlan.id3, currentPlan.id4, currentPlan.type1, currentPlan.type2, currentPlan.type3, currentPlan.type4, currentPlan.time0, currentPlan.time1, currentPlan.time2, currentPlan.time3 ,currentPlan.time4 ,currentPlan.fin1, currentPlan.fin2, currentPlan.fin3, currentPlan.fin4,
    currentPlan.stress1, currentPlan.stress2, currentPlan.stress3, currentPlan.stress4, currentPlan.stress5, currentPlan.effect];
    KCDbManager *manager = [KCDbManager new];
    [manager openDb:FileName];
    [manager executeNonQuery:sql];
    [manager close];
}
- (void) recordStress5{
    //记录这个计划完成的时候的情况
    currentPlan.stress5 = [NSString stringWithFormat:@"%f",2.0];
}
- (void) update{
    NSLog(@"inter function update weight of pref and effe and so on");
    //先计算一下这个压力的效果啦
    //有两种思路，一种是计算整个计划的减压效果，另外一种呢是计划每个计划中单个的减压时间的效果呢
    //假如就很简单啦 就算整个计划的减压效果 stress0-stress5
    float promote = currentPlan.stress0.floatValue - currentPlan.stress4.floatValue;
    //这里计算出一个效果的比例啦,这个数字5呢，需要调整的，因为压力值是0～5的整型，所以就用5啦
    currentPlan.effect = [NSString stringWithFormat:@"%f",(promote+ EFFECT_BIAS )/ EFFECT_BIAS ];
    //将这个效果的比值更新到减压时间数据库里面啦，这个效果呢，就乘以这个比值就好啦～
    KCDbManager *manager = [KCDbManager new];
    [manager openDb:FileName];
    float effe,pref;
    int numb;
    Item *currentItem;
    if (currentPlan.number.intValue> 0) {
        currentItem = [self getItemById:currentPlan.id1];
        effe = currentItem.effe.floatValue * currentPlan.effect.floatValue;
        if(currentPlan.fin1.intValue == 0){
            //这个家伙竟然没有完成，要么是ta就不喜欢这个，要么就是客观条件不允许，反正呀，都要把权重搞下来
            pref = currentItem.pref.floatValue * PREFERENCE_BIAS;
        }else{
            //不错，这个家伙做啦～
            pref = currentItem.pref.floatValue / PREFERENCE_BIAS;
        }
        NSString * sql = [NSString stringWithFormat:@"UPDATE PlanList SET effe = %@ pref = %@ numb = %@ WHERE ID = %@;",
                         [NSString stringWithFormat:@"%f",effe],[NSString stringWithFormat:@"%f",pref],[NSString stringWithFormat:@"%i",numb],currentPlan.id1];
        [manager executeNonQuery:sql];
    }
    if (currentPlan.number.intValue > 1) {
        currentItem = [self getItemById:currentPlan.id2];
        effe = currentItem.effe.floatValue * currentPlan.effect.floatValue;
        if(currentPlan.fin2.intValue == 0){
            //这个家伙竟然没有完成，要么是ta就不喜欢这个，要么就是客观条件不允许，反正呀，都要把权重搞下来
            pref = currentItem.pref.floatValue * PREFERENCE_BIAS;
        }else{
            //不错，这个家伙做啦～
            pref = currentItem.pref.floatValue / PREFERENCE_BIAS;
        }
        NSString * sql = [NSString stringWithFormat:@"UPDATE PlanList SET effe = %@ pref = %@ numb = %@ WHERE ID = %@;",
                          [NSString stringWithFormat:@"%f",effe],[NSString stringWithFormat:@"%f",pref],[NSString stringWithFormat:@"%i",numb],currentPlan.id2];
        [manager executeNonQuery:sql];
    }
    if (currentPlan.number.intValue > 2) {
        currentItem = [self getItemById:currentPlan.id3];
        effe = currentItem.effe.floatValue * currentPlan.effect.floatValue;
        if(currentPlan.fin3.intValue == 0){
            //这个家伙竟然没有完成，要么是ta就不喜欢这个，要么就是客观条件不允许，反正呀，都要把权重搞下来
            pref = currentItem.pref.floatValue * PREFERENCE_BIAS;
        }else{
            //不错，这个家伙做啦～
            pref = currentItem.pref.floatValue / PREFERENCE_BIAS;
        }
        NSString * sql = [NSString stringWithFormat:@"UPDATE PlanList SET effe = %@ pref = %@ numb = %@ WHERE ID = %@;",
                          [NSString stringWithFormat:@"%f",effe],[NSString stringWithFormat:@"%f",pref],[NSString stringWithFormat:@"%i",numb],currentPlan.id3];
        [manager executeNonQuery:sql];
    }
    if (currentPlan.number.intValue > 3) {
        currentItem = [self getItemById:currentPlan.id4];
        effe = currentItem.effe.floatValue * currentPlan.effect.floatValue;
        if(currentPlan.fin4.intValue == 0){
            //这个家伙竟然没有完成，要么是ta就不喜欢这个，要么就是客观条件不允许，反正呀，都要把权重搞下来
            pref = currentItem.pref.floatValue * PREFERENCE_BIAS;
        }else{
            //不错，这个家伙做啦～
            pref = currentItem.pref.floatValue / PREFERENCE_BIAS;
        }
        NSString * sql = [NSString stringWithFormat:@"UPDATE PlanList SET effe = %@ pref = %@ numb = %@ WHERE ID = %@;",
                          [NSString stringWithFormat:@"%f",effe],[NSString stringWithFormat:@"%f",pref],[NSString stringWithFormat:@"%i",numb],currentPlan.id4];
        [manager executeNonQuery:sql];
    }
    [manager close];
    
}
- (Item *) getItemById:(NSNumber* )newId{
    NSLog(@"in the getitembyid %@",newId);
    KCDbManager* manager = [KCDbManager new];
    [manager openDb:FileName];
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM PlanList WHERE ID=%i;",newId.intValue];
    NSArray * array = [manager executeQuery:sql];
    Item * item = nil;
    NSLog(@"get item by id %@",array);
    if(array.count){
           item  = [[Item alloc] initWithcontent1:[array[0] objectForKey:@"content1"]
                                        content2:[array[0] objectForKey:@"content2"]
                                        content3:[array[0] objectForKey:@"content3"]
                                            info:[array[0] objectForKey:@"info"]
                                            pref:[array[0] objectForKey:@"pref"]
                                            effe:[array[0] objectForKey:@"effe"]
                                            diff:[array[0] objectForKey:@"diff"]
                                            inte:[array[0] objectForKey:@"inte"]
                                            chan:[array[0] objectForKey:@"chan"]
                                            sour:[array[0] objectForKey:@"sour"]
                                            numb:[array[0] objectForKey:@"numb"]
                                            clus:[array[0] objectForKey:@"clus"]
                           ];
        NSLog(@"get item by id %i succeed!",newId.intValue);
    }else{
        NSLog(@"get item by id %i failed!",newId.intValue);
    }

    return item;
}
- (void) createNewPlan{
    NSLog(@"inter function createNewPlan");
    //0.来，搞个随机数种子
    srandom(time(NULL));
    //0.1 准备实例化currentplan
    currentPlan = [CurrentPlan new];
    //1. 我们先根据当前的压力源来选择大类（这个大类呢，对应item.sour, 就是根据压力来源，选择一些优先的类并且设置权重
    //1.1 special[a][b] 表示呀，这个a类型的压力情况下减压类型b的权重
    float special_type_weight[6][10]= {//0    1    2    3    4    5    6    7    8    9
        /*学业压力*/            {0.10,0.10,0.10,0.13,0.23,0.35,0.10,0.13,0.23,0.35},
        /*家庭压力*/            {0.10,0.10,0.10,0.13,0.23,0.35,0.10,0.13,0.23,0.35},
        /*自我认知*/            {0.10,0.10,0.10,0.13,0.23,0.35,0.10,0.13,0.23,0.35},
        /*情感压力*/            {0.10,0.10,0.10,0.13,0.23,0.35,0.10,0.13,0.23,0.35},
        /*人际交往*/            {0.10,0.10,0.10,0.13,0.23,0.35,0.10,0.13,0.23,0.35}
                          };
    //1.2 默认所有的权重都是相同的
    float default_type_weight[10] = {0.10,0.10,0.10,0.10,0.10,0.10,0.10,0.10,0.10,0.10};
    //1.3 最终的权重的计算
    float type_weight[10]={0};
    for (int i=0; i<10; i++) {
        type_weight[i] = default_type_weight[i];
    }
    //1.4 每个条目的权重的声明
    float item_weight[SUM_OF_ITEM] = {0};
    NSString *sql= @"SELECT id, pref, effe, diff, sour FROM PlanList ORDER BY ID";
    KCDbManager* manager = [KCDbManager new];
    [manager openDb:FileName];
    NSArray * all = [manager executeQuery:sql];
    [manager close];
    //1.5 item权重赋值
    for(int i=0;i<all.count;i++){
        NSLog(@"output item %i ",i);
        /*
        [all[i] objectForKey:@"id"];
        [all[i] objectForKey:@"pref"];
        [all[i] objectForKey:@"effe"];
        [all[i] objectForKey:@"diff"];
        [all[i] objectForKey:@"sour"];
         */
        item_weight[i] = [[all[i] objectForKey:@"pref"] floatValue] * [[all[i] objectForKey:@"effe"] floatValue] * type_weight[[[all[i] objectForKey:@"sour"] intValue]];
    }
    // 1.5 item累计权重分布计算
    for (int i=1; i<all.count; i++) {
        item_weight[i] = item_weight[i-1] + item_weight[i];
    }
    // 2 根据item的权重分布选择item
    int plan_item_number = 3;
    int selected_id[4] = {0};
    for (int i=0; i < plan_item_number; i++) {
        int flag = random() % all.count;
        for (int k=0; k<3; k++) {
            float  rand = random() % (all.count * 10000);
            rand = rand / 10000.0;
            for (int j=0; j < all.count; j++) {
                if (type_weight[j] > rand) {
                    flag = j;
                    break;
                }
            }
            if ([self judge:flag round:k] == YES) {
                //fit, just break
                break;
            }else if(k == 2){
                // not fit, select another one
                flag = random() % all.count;
            }
        }
        selected_id[i] = [[all[flag] objectForKey:@"id"] intValue];
    }
    // 3. 根据item制订计划, done,id,type 字段首先很容易确定
    currentPlan.done = 0;
    currentPlan.have = 0;
    currentPlan.stress0 = [[CurrentLevel new] stressLevel];
    Item *selected_item[4];
    if (plan_item_number > 0) {
        currentPlan.id1 = [NSNumber numberWithInt:selected_id[1]];
        selected_item[0] = [self getItemById:currentPlan.id1];
        currentPlan.type1 = selected_item[0].inte ;
        currentPlan.content1 = selected_item[0].content1;
    }
    if (plan_item_number > 1) {
        currentPlan.id2 = [NSNumber numberWithInt:selected_id[2]];
        selected_item[1] = [self getItemById:currentPlan.id2];
        currentPlan.type2 = selected_item[1].inte ;
        currentPlan.content2 = selected_item[1].content1;
    }
    if (plan_item_number > 2) {
        currentPlan.id3 = [NSNumber numberWithInt:selected_id[3]];
        selected_item[2] = [self getItemById:currentPlan.id3];
        currentPlan.type3 = selected_item[2].inte ;
        currentPlan.content3 = selected_item[2].content1;
    }
    if (plan_item_number > 3) {
        currentPlan.id4 = [NSNumber numberWithInt:selected_id[4]];
        selected_item[3] = [self getItemById:currentPlan.id4];
        currentPlan.type4 = selected_item[3].inte ;
        currentPlan.content4 = selected_item[3].content1;
    }
    // 4. 但是这个时间就需要精心策划啦
    currentPlan.time0 = [NSDate date];
    NSTimeInterval interval = [NSDate timeIntervalSinceReferenceDate];
    int day_since_2000 = (int) (interval / 3600 /24);
    //interval(second format) to the o'clock of next day
    int interval_second = (int) ((day_since_2000 + 1) * 3600 * 24 - interval);
    if (plan_item_number == 1) {
        currentPlan.time1 = [[NSDate alloc] initWithTimeInterval: (8)*60*60+interval_second sinceDate:currentPlan.time0];
    }else if(plan_item_number == 2){
        currentPlan.time1 = [[NSDate alloc] initWithTimeInterval: (12) * 60*60+interval_second sinceDate:currentPlan.time0];
        currentPlan.time2 = [[NSDate alloc] initWithTimeInterval: (48 + 18) * 60*60+interval_second sinceDate:currentPlan.time0];

    }else if(plan_item_number == 3){
        currentPlan.time1 = [[NSDate alloc] initWithTimeInterval: (8)*60*60+interval_second sinceDate:currentPlan.time0];
        currentPlan.time2 = [[NSDate alloc] initWithTimeInterval: (72 + 12)*60*60+interval_second sinceDate:currentPlan.time0];
        currentPlan.time3 = [[NSDate alloc] initWithTimeInterval: (120 + 18)*60*60+interval_second sinceDate:currentPlan.time0];
    }else if(plan_item_number == 4){
        currentPlan.time1 = [[NSDate alloc] initWithTimeInterval: (8)*60*60+interval_second sinceDate:currentPlan.time0];
        currentPlan.time2 = [[NSDate alloc] initWithTimeInterval: (48 + 12)*60*60+interval_second sinceDate:currentPlan.time0];
        currentPlan.time3 = [[NSDate alloc] initWithTimeInterval: (120 + 18)*60*60+interval_second sinceDate:currentPlan.time0];
        currentPlan.time4 = [[NSDate alloc] initWithTimeInterval: (168 + 8)*60*60+interval_second sinceDate:currentPlan.time0];
    }
    //5. 赋值到currentplan中去
    [currentPlan save];
}

- (BOOL) judge:(int)newId round:(int) newRound{
    NSLog(@"inter function judge");
    //就是判断这个取的条目合不合适
    return YES;
}
- (Item *) selectItemRandomly{
    srandom(time(NULL));
    int  rand = random() % SUM_OF_ITEM;
    Item *item = [self getItemById:[[NSNumber alloc] initWithInt:rand]];
    NSLog(@"RANDOM select item id %i",rand);
    if (item == nil) {
        NSLog(@"FUCK ME ! 竟然没有random到，次处应有自我调用，历史证明，它不会是死循环滴");
        return [self selectItemRandomly];
    }else{
        return item;
    }
}
- (Item *) changeItemById:(NSNumber* )newId{
    NSLog(@"inter function changeItemById");
    /*
     
     以旧换新啦
     
     */
    srandom(time(NULL));
    
    Item * oldItem = [self getItemById:newId];
    
    KCDbManager* manager = [KCDbManager new];
    [manager openDb:FileName];
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM PlanList WHERE clus =%@;",oldItem.clus];
    NSArray * array = [manager executeQuery:sql];
    Item * item = nil;
    NSLog(@"get item by id %@",array);
    if(array.count){
        int  rand = random() % array.count;
        NSLog(@"random select row %i form the all sum %i",rand,array.count);
        item  = [[Item alloc] initWithcontent1:[array[rand] objectForKey:@"content1"]
                                      content2:[array[rand] objectForKey:@"content2"]
                                      content3:[array[rand] objectForKey:@"content3"]
                                          info:[array[rand] objectForKey:@"info"]
                                          pref:[array[rand] objectForKey:@"pref"]
                                          effe:[array[rand] objectForKey:@"effe"]
                                          diff:[array[rand] objectForKey:@"diff"]
                                          inte:[array[rand] objectForKey:@"inte"]
                                          chan:[array[rand] objectForKey:@"chan"]
                                          sour:[array[rand] objectForKey:@"sour"]
                                          numb:[array[rand] objectForKey:@"numb"]
                                          clus:[array[rand] objectForKey:@"clus"]
                 ];
        NSLog(@"select similar item by  id %i succeed!",newId.intValue);
    }else{
        NSLog(@"select similar item by  id %i failed!",newId.intValue);
        NSLog(@"let's just select it randomly!");
        item = [self selectItemRandomly];
    }
    return item;
}
- (void) finishItem:(BOOL) yesOrNo Content:(NSString* ) newContent{
    CurrentPlan * plan = [CurrentPlan new];
    //存储计划完成情况和完成后的内容
    if (plan.currentNumber.intValue == 0) {
        plan.fin1 = [NSNumber numberWithBool:yesOrNo];
        plan.content1 = newContent;
    }
    if (plan.currentNumber.intValue == 1) {
        plan.fin2 = [NSNumber numberWithBool:yesOrNo];
        plan.content2 = newContent;
    }
    if (plan.currentNumber.intValue == 2) {
        plan.fin3 = [NSNumber numberWithBool:yesOrNo];
        plan.content3 = newContent;
    }
    if (plan.currentNumber.intValue == 3) {
        plan.fin4 = [NSNumber numberWithBool:yesOrNo];
        plan.content4 = newContent;
    }
}

@end
