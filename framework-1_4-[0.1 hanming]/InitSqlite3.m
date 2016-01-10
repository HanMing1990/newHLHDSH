//
//  InitSqlite3.m
//  store
//
//  Created by yangjun on 16/1/9.
//  Copyright © 2016年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSArray.h>
#import "InitSqlite3.h"
#import "KCDbManager.h"
#define FileName @"plan.sqlite3"
@implementation InitSqlite3
- (void) createDataBase{
    NSString *key=@"IsCreatedDb";
    NSUserDefaults *defaults=[[NSUserDefaults alloc]init];
    
    [defaults setValue:@0 forKey:key];
    
    if ([[defaults valueForKey:key] intValue]!=1) {
        NSLog(@"we create the world!!!");
        [self createPlanItemTable];
        [self insertPlanItem];
        [self createPlanHistoryTable];
        [defaults setValue:@1 forKey:key];
    }
}
- (void) insertPlanItem{
    NSString* content1 = @"hello";
    NSString* content2 = @"content1";
    NSString* content3 = @"content2";
    
    NSString* info = @"info";
    
    NSString* pref = @"gref";
    NSString* effe = @"effe";
    NSString* diff = @"diff";
    
    NSNumber* inte = [[NSNumber alloc] initWithInt:1];
    NSNumber* chan = [[NSNumber alloc] initWithInt:1];
    NSNumber* sour = [[NSNumber alloc] initWithInt:1];
    NSNumber* numb = [[NSNumber alloc] initWithInt:1];
    NSNumber* clus = [[NSNumber alloc] initWithInt:1];
    NSArray* array = [[NSArray alloc] initWithObjects:content1, content2, content3, info, pref, effe, diff, inte, chan, sour, numb, clus, nil];
    //NSArray *array=[[NSArray alloc] :content1,nil];//,[[NSNumber alloc]  initWithInt:1],[[NSNumber alloc]  initWithInt:1],[[NSNumber alloc]  initWithInt:0],[[NSNumber alloc]  initWithInt:1], nil];
    //NSData *dataFromArray = [NSKeyedArchiver archivedDataWithRootObject:array];
   // NSString *sql=@"INSERT INTO PlanList (\
   //                content1 ,content2 , content3 ,info ,pref , effe ,\
   //                diff , inte , chan , sour , numb , clus) VALUES \
   //               ('写封信给亲人，表达对他们的感恩之情','','','写封信给亲人','1','1','0.5',1,0,1,0,1)";
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO PlanList (\
                                      content1 ,content2 , content3 ,info ,pref , effe ,\
                                      diff , inte , chan , sour , numb , clus) VALUES \
                                     ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",array[0],array[1],array[2],array[3],array[4],array[5],array[6],array[7],array[8],array[9],array[10],array[11]];
    KCDbManager *manager = [KCDbManager new];
    [manager openDb:FileName];
    int loop;
    for(loop = 0; loop < 10; loop ++){
        [manager executeNonQuery:sql];
    }
    
    [manager close];
}
- (void) outputTable{
    NSString *sql= @"SELECT * FROM PlanList ORDER BY ID";
    KCDbManager* manager = [KCDbManager new];
    [manager openDb:FileName];
    NSArray * all = [manager executeQuery:sql];
    for(int i=0;i<all.count;i++){
        
            NSLog([NSString stringWithFormat:@"output item %@",all[i]]);
    }
    [manager close];
}
- (void) createPlanItemTable{
     NSString *sql=      @"CREATE TABLE PlanList (Id integer PRIMARY KEY AUTOINCREMENT,\
         content1 text,content2 text, content3 text,info text,pref text, effe text,\
    diff text, inte integer, chan integer, sour integer, numb integer, clus integer\
    )";
    
    KCDbManager* manager = [KCDbManager new];
    [manager openDb:FileName];
    [manager executeNonQuery:sql];
    [manager close];
}
- (void) createPlanHistoryTable{
    NSString *sql=@"CREATE TABLE History (Id integer PRIMARY KEY AUTOINCREMENT,\
    done integer,have integer, currentNumber integer, id1 integer, id2 integer, \
    id3 integer, id4 integer, type1 integer, type2 integer, type3 integer, type4 integer, \
    time0 text, time1 text,time2 text,time3 text,time4 text, fin1 integer, fin2 integer, \
    fin3 integer, fin4 integer, stress0 text, stress1 text, stress2 text,stress3 text, stress4 text, stress5 text,effect text)";
    KCDbManager* manager = [KCDbManager new];
    [manager openDb:FileName];
    [manager executeNonQuery:sql];
    [manager close];
}
@end