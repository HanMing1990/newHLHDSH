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
@synthesize stress0;
@synthesize stress1;
@synthesize stress2;
@synthesize stress3;
@synthesize stress4;
@synthesize stress5;
@synthesize effect;

- (void) store{
    [self recordStress5];
    [self calcEffect];
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
- (void) calcEffect{
    
}
- (void) recordStress5{
    
}
- (void) update{
    
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
@end
