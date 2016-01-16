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

#define DONE           @"DONE"
#define HAVE           @"HAVE"
#define CURRENTNUMBER  @"CURRENTNUMBER"
#define ID1            @"ID1"
#define ID2            @"ID2"
#define ID3            @"ID3"
#define ID4            @"ID4"
#define TYPE1   @"TYPE1"
#define TYPE2   @"TYPE2"
#define TYPE3   @"TYPE3"
#define TYPE4   @"TYPE4"
#define TIME0   @"TIME0"
#define TIME1   @"TIME1"
#define TIME2   @"TIME2"
#define TIME3   @"TIME3"
#define TIME4   @"TIME4"
#define FIN1    @"FIN1"
#define FIN2    @"FIN2"
#define FIN3    @"FIN3"
#define FIN4    @"FIN4"
#define STRESS0 @"STRESS0"
#define STRESS1 @"STRESS1"
#define STRESS2 @"STRESS2"
#define STRESS3 @"STRESS3"
#define STRESS4 @"STRESS4"
#define STRESS5 @"STRESS5"
#define EFFECT  @"EFFECT"
#define FileName @"plan.sqlite3"


#define EFFECT_BIAS     1.0   //用来计算effect，计算公式暂时定位  （ effe + EFFECT_BIAS ）／ EFFECT_BIAS
#define PREFERENCE_BIAS 0.6   //这个是用来更新这个 pref 滴，如果他做啦就除以这个值（变大啦），如果没做，就乘上这个值（变小啦）
@implementation Plan

@synthesize done; //是否完成，1:完成 0:不完成
@synthesize have;
@synthesize number;
@synthesize currentNumber;
@synthesize id1;
@synthesize id2;
@synthesize id3;
@synthesize id4;
@synthesize type1;
@synthesize type2;
@synthesize type3;
@synthesize type4;
@synthesize time0;
@synthesize time1;
@synthesize time2;
@synthesize time3;
@synthesize time4;
@synthesize fin1;
@synthesize fin2;
@synthesize fin3;
@synthesize fin4;
@synthesize content1;
@synthesize content2;
@synthesize content3;
@synthesize content4;
@synthesize stress0;
@synthesize stress1;
@synthesize stress2;
@synthesize stress3;
@synthesize stress4;
@synthesize stress5;
@synthesize effect;
@synthesize currentPlan;
- (void) store{
    NSLog(@"inter function store");
    //用currentplan的值给这个类赋值
    currentPlan = [CurrentPlan new];
    self.done = currentPlan.done;
    self.have = currentPlan.have;
    self.number = currentPlan.number;
    self.currentNumber = currentPlan.currentNumber;
    self.id1 = currentPlan.id1;
    self.id2 = currentPlan.id2;
    self.id3 = currentPlan.id3;
    self.id4 = currentPlan.id4;
    self.type1 = currentPlan.type1;
    self.type2 = currentPlan.type2;
    self.type3 = currentPlan.type3;
    self.type4 = currentPlan.type4;
    self.time0 = currentPlan.time0;
    self.time1 = currentPlan.time1;
    self.time2 = currentPlan.time2;
    self.time3 = currentPlan.time3;
    self.time4 = currentPlan.time4;
    self.fin1 = currentPlan.fin1;
    self.fin2 = currentPlan.fin2;
    self.fin3 = currentPlan.fin3;
    self.fin4 = currentPlan.fin4;
    self.stress0 = currentPlan.stress0;
    self.stress1 = currentPlan.stress1;
    self.stress2 = currentPlan.stress2;
    self.stress3 = currentPlan.stress3;
    self.stress4 = currentPlan.stress4;
    
    [self recordStress5];
    [self update];
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO History \
    (done, have, number, currentNumber, id1, id2, id3, id4, type1, type2, type3, type4, time0, time1, time2, time3 ,time4 ,fin1, fin2, fin3, fin4,\
    stress1, stress2, stress3, stress4, stress5, effect) VALUES \
    ('%@',  '%@','%@',   '%@',         '%@', '%@','%@','%@','%@',  '%@',  '%@',  '%@',  '%@',  '%@',  '%@',  '%@',  '%@', '%@', '%@',  '%@', '%@',\
    '%@',    '%@',    '%@',   '%@',    '%@',    '%@');",
     done, have, number, currentNumber, id1, id2, id3, id4, type1, type2, type3, type4, time0, time1, time2, time3 ,time4 ,fin1, fin2, fin3, fin4,
    stress1, stress2, stress3, stress4, stress5, effect];
    KCDbManager *manager = [KCDbManager new];
    [manager openDb:FileName];
    [manager executeNonQuery:sql];
    [manager close];
}
- (void) recordStress5{
    //记录这个计划完成的时候的情况
    self.stress5 = [NSString stringWithFormat:@"%f",2.0];
    currentPlan.stress5 = self.stress5;
}
- (void) update{
    NSLog(@"inter function update weight of pref and effe and so on");
    //先计算一下这个压力的效果啦
    //有两种思路，一种是计算整个计划的减压效果，另外一种呢是计划每个计划中单个的减压时间的效果呢
    //假如就很简单啦 就算整个计划的减压效果 stress0-stress5
    float promote = stress0.floatValue - stress4.floatValue;
    //这里计算出一个效果的比例啦,这个数字5呢，需要调整的，因为压力值是0～5的整型，所以就用5啦
    self.effect = [NSString stringWithFormat:@"%f",(promote+ EFFECT_BIAS )/ EFFECT_BIAS ];
    [currentPlan save];
    //将这个效果的比值更新到减压时间数据库里面啦，这个效果呢，就乘以这个比值就好啦～
    KCDbManager *manager = [KCDbManager new];
    [manager openDb:FileName];
    float effe,pref;
    int numb;
    Item *currentItem;
    if (self.number.intValue> 0) {
        currentItem = [self getItemById:self.id1];
        effe = currentItem.effe.floatValue * self.effect.floatValue;
        if(self.fin1.intValue == 0){
            //这个家伙竟然没有完成，要么是ta就不喜欢这个，要么就是客观条件不允许，反正呀，都要把权重搞下来
            pref = currentItem.pref.floatValue * PREFERENCE_BIAS;
        }else{
            //不错，这个家伙做啦～
            pref = currentItem.pref.floatValue / PREFERENCE_BIAS;
        }
        NSString * sql = [NSString stringWithFormat:@"UPDATE PlanList SET effe = %@ pref = %@ numb = %@ WHERE ID = %@;",
                         [NSString stringWithFormat:@"%f",effe],[NSString stringWithFormat:@"%f",pref],[NSString stringWithFormat:@"%i",numb],self.id1];
        [manager executeNonQuery:sql];
    }
    if (self.number.intValue > 1) {
        currentItem = [self getItemById:self.id2];
        effe = currentItem.effe.floatValue * self.effect.floatValue;
        if(self.fin2.intValue == 0){
            //这个家伙竟然没有完成，要么是ta就不喜欢这个，要么就是客观条件不允许，反正呀，都要把权重搞下来
            pref = currentItem.pref.floatValue * PREFERENCE_BIAS;
        }else{
            //不错，这个家伙做啦～
            pref = currentItem.pref.floatValue / PREFERENCE_BIAS;
        }
        NSString * sql = [NSString stringWithFormat:@"UPDATE PlanList SET effe = %@ pref = %@ numb = %@ WHERE ID = %@;",
                          [NSString stringWithFormat:@"%f",effe],[NSString stringWithFormat:@"%f",pref],[NSString stringWithFormat:@"%i",numb],self.id2];
        [manager executeNonQuery:sql];
    }
    if (self.number.intValue > 2) {
        currentItem = [self getItemById:self.id3];
        effe = currentItem.effe.floatValue * self.effect.floatValue;
        if(self.fin3.intValue == 0){
            //这个家伙竟然没有完成，要么是ta就不喜欢这个，要么就是客观条件不允许，反正呀，都要把权重搞下来
            pref = currentItem.pref.floatValue * PREFERENCE_BIAS;
        }else{
            //不错，这个家伙做啦～
            pref = currentItem.pref.floatValue / PREFERENCE_BIAS;
        }
        NSString * sql = [NSString stringWithFormat:@"UPDATE PlanList SET effe = %@ pref = %@ numb = %@ WHERE ID = %@;",
                          [NSString stringWithFormat:@"%f",effe],[NSString stringWithFormat:@"%f",pref],[NSString stringWithFormat:@"%i",numb],self.id3];
        [manager executeNonQuery:sql];
    }
    if (self.number.intValue > 3) {
        currentItem = [self getItemById:self.id4];
        effe = currentItem.effe.floatValue * self.effect.floatValue;
        if(self.fin4.intValue == 0){
            //这个家伙竟然没有完成，要么是ta就不喜欢这个，要么就是客观条件不允许，反正呀，都要把权重搞下来
            pref = currentItem.pref.floatValue * PREFERENCE_BIAS;
        }else{
            //不错，这个家伙做啦～
            pref = currentItem.pref.floatValue / PREFERENCE_BIAS;
        }
        NSString * sql = [NSString stringWithFormat:@"UPDATE PlanList SET effe = %@ pref = %@ numb = %@ WHERE ID = %@;",
                          [NSString stringWithFormat:@"%f",effe],[NSString stringWithFormat:@"%f",pref],[NSString stringWithFormat:@"%i",numb],self.id4];
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
    self.done = 0;
    self.have = 0;
    self.stress0 = [[CurrentLevel new] stressLevel];
    Item *selected_item[4];
    if (plan_item_number > 0) {
        self.id1 = [NSNumber numberWithInt:selected_id[1]];
        selected_item[0] = [self getItemById:self.id1];
        self.type1 = selected_item[0].inte ;
        self.content1 = selected_item[0].content1;
    }
    if (plan_item_number > 1) {
        self.id2 = [NSNumber numberWithInt:selected_id[2]];
        selected_item[1] = [self getItemById:self.id2];
        self.type2 = selected_item[1].inte ;
        self.content2 = selected_item[1].content1;
    }
    if (plan_item_number > 2) {
        self.id3 = [NSNumber numberWithInt:selected_id[3]];
        selected_item[2] = [self getItemById:self.id3];
        self.type3 = selected_item[2].inte ;
        self.content3 = selected_item[2].content1;
    }
    if (plan_item_number > 3) {
        self.id4 = [NSNumber numberWithInt:selected_id[4]];
        selected_item[3] = [self getItemById:self.id4];
        self.type4 = selected_item[3].inte ;
        self.content4 = selected_item[3].content1;
    }
    // 4. 但是这个时间就需要精心策划啦
    self.time0 = [NSDate date];
    NSTimeInterval interval = [NSDate timeIntervalSinceReferenceDate];
    int day_since_2000 = (int) (interval / 3600 /24);
    //interval(second format) to the o'clock of next day
    int interval_second = (int) ((day_since_2000 + 1) * 3600 * 24 - interval);
    if (plan_item_number == 1) {
        self.time1 = [[NSDate alloc] initWithTimeInterval: (8)*60*60+interval_second sinceDate:self.time0];
    }else if(plan_item_number == 2){
        self.time1 = [[NSDate alloc] initWithTimeInterval: (12) * 60*60+interval_second sinceDate:self.time0];
        self.time2 = [[NSDate alloc] initWithTimeInterval: (48 + 18) * 60*60+interval_second sinceDate:self.time0];

    }else if(plan_item_number == 3){
        self.time1 = [[NSDate alloc] initWithTimeInterval: (8)*60*60+interval_second sinceDate:self.time0];
        self.time2 = [[NSDate alloc] initWithTimeInterval: (72 + 12)*60*60+interval_second sinceDate:self.time0];
        self.time3 = [[NSDate alloc] initWithTimeInterval: (120 + 18)*60*60+interval_second sinceDate:self.time0];
    }else if(plan_item_number == 4){
        self.time1 = [[NSDate alloc] initWithTimeInterval: (8)*60*60+interval_second sinceDate:self.time0];
        self.time2 = [[NSDate alloc] initWithTimeInterval: (48 + 12)*60*60+interval_second sinceDate:self.time0];
        self.time3 = [[NSDate alloc] initWithTimeInterval: (120 + 18)*60*60+interval_second sinceDate:self.time0];
        self.time4 = [[NSDate alloc] initWithTimeInterval: (168 + 8)*60*60+interval_second sinceDate:self.time0];
    }
    //5. 赋值到currentplan中去
    currentPlan.done = self.done;
    currentPlan.have = self.have;
    currentPlan.number = self.number;
    currentPlan.currentNumber = self.currentNumber;
    currentPlan.id1 = self.id1;
    currentPlan.id2 = self.id2;
    currentPlan.id3 = self.id3;
    currentPlan.id4 = self.id4;
    currentPlan.type1 = self.type1;
    currentPlan.type2 = self.type2;
    currentPlan.type3 = self.type3;
    currentPlan.type4 = self.type4;
    currentPlan.time0 = self.time0;
    currentPlan.time1 = self.time1;
    currentPlan.time2 = self.time2;
    currentPlan.time3 = self.time3;
    currentPlan.time4 = self.time4;
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

@end
