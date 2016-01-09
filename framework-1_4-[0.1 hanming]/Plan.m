//
//  Plan.m
//  store
//
//  Created by yangjun on 16/1/6.
//  Copyright © 2016年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
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

@synthesize done;
@synthesize have;
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

- (NSString *) filePath{
    NSArray * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString * documentsDirectory = [path objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:FileName];
}
- (void) store{
    
    [self recordStress5];
    [self calcEffect];
    [self update];
    
    sqlite3 *database;
    

    
    if(![[NSFileManager defaultManager] fileExistsAtPath:[self filePath]]) {
        NSLog(@"no such file at currentplan.m");
        sqlite3_open([[self filePath] UTF8String], &database);
        char* error;
        const char *createSql = "create table FIELDS (ROW integer, FIELD_DATA integer)";
        if(sqlite3_exec(database, createSql, nil, nil, &error)!= SQLITE_OK){
            NSLog(@"create sql failed1 %s",error);
        }else{
            NSLog(@"create sql succeed1 ");
        }
    }else{
        if(sqlite3_open([[self filePath] UTF8String], &database) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert(0, @"Failed to open database");
        }
    }
    char* error1;
    const char *update = "INSERT INTO FIELDS (ROW, FIELD_DATA) VALUES (1, 1);";
    if(sqlite3_exec(database, update, nil, nil, &error1)!= SQLITE_OK){
        NSLog(@"insert failed2 %s",error1);
    }else{
        NSLog(@"insert succeed");
    }
    sqlite3_close(database);
}
- (void) calcEffect{
    
}
- (void) recordStress5{
    
}
- (void) update{
    
}
@end
