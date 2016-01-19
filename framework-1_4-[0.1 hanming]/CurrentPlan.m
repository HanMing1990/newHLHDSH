//
//  CurrentPlan.m
//  store
//
//  Created by yangjun on 16/1/6.
//  Copyright © 2016年 yangjun. All rights reserved.
//


#import "CurrentPlan.h"
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

#define DONE           @"DONE"
#define HAVE           @"HAVE"
#define NUMBER         @"NUMBER"
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
#define FINTIME1 @"FINTIME1"
#define FINTIME2 @"FINTIME2"
#define FINTIME3 @"FINTIME3"
#define FINTIME4 @"FINTIME4"
#define FIN1    @"FIN1"
#define FIN2    @"FIN2"
#define FIN3    @"FIN3"
#define FIN4    @"FIN4"
#define INFO1   @"INFO1"
#define INFO2   @"INFO2"
#define INFO3   @"INFO3"
#define INFO4   @"INFO4"
#define SOUR1   @"SOUR1"
#define SOUR2   @"SOUR2"
#define SOUR3   @"SOUR3"
#define SOUR4   @"SOUR4"
#define CONTENT1 @"CONTENT1"
#define CONTENT2 @"CONTENT2"
#define CONTENT3 @"CONTENT3"
#define CONTENT4 @"CONTENT4"
#define OUTPUT1  @"OUTPUT1"
#define OUTPUT2  @"OUTPUT2"
#define OUTPUT3  @"OUTPUT3"
#define OUTPUT4  @"OUTPUT4"
#define STRESS0 @"STRESS0"
#define STRESS1 @"STRESS1"
#define STRESS2 @"STRESS2"
#define STRESS3 @"STRESS3"
#define STRESS4 @"STRESS4"
#define STRESS5 @"STRESS5"
#define EFFECT  @"EFFECT"


@implementation CurrentPlan

@synthesize done;
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
@synthesize fintime1;
@synthesize fintime2;
@synthesize fintime3;
@synthesize fintime4;
@synthesize fin1;
@synthesize fin2;
@synthesize fin3;
@synthesize fin4;
@synthesize info1;
@synthesize info2;
@synthesize info3;
@synthesize info4;
@synthesize sour1;
@synthesize sour2;
@synthesize sour3;
@synthesize sour4;
@synthesize content1;
@synthesize content2;
@synthesize content3;
@synthesize content4;
@synthesize output1;
@synthesize output2;
@synthesize output3;
@synthesize output4;
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
    return [documentsDirectory stringByAppendingPathComponent:planFileName];
}

- (id) init{
    if(self = [super init]){
        NSLog(@"init at currentplan.m");
        if(![[NSFileManager defaultManager] fileExistsAtPath:[self filePath]]) {
            NSLog(@"no such file at currentplan.m");
            do{
                NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                have = [NSNumber numberWithBool:1];
                done = [NSNumber numberWithBool:0];
                number = [NSNumber numberWithInt:3];
                currentNumber = [NSNumber numberWithInt:0];
                id1 = [NSNumber numberWithInt:3];
                id2 = [NSNumber numberWithInt:5];
                id3 = [NSNumber numberWithInt:6];
                id4 = [NSNumber numberWithInt:0];
                type1 = [NSNumber numberWithInt:2];
                type2 = [NSNumber numberWithInt:3];
                type3 = [NSNumber numberWithInt:4];
                type4 = [NSNumber numberWithInt:0];
                time0 = [NSDate date];
                time1 = [NSDate date];
                time2 = [NSDate date];
                time3 = [NSDate date];
                time4 = [NSDate date];
                fintime1 = [NSDate date];
                fintime2 = [NSDate date];
                fintime3 = [NSDate date];
                fintime4 = [NSDate date];
                fin1 = [NSNumber numberWithBool:0];
                fin2 = [NSNumber numberWithBool:0];
                fin3 = [NSNumber numberWithBool:0];
                fin4 = [NSNumber numberWithBool:0];
                info1 = @"default";
                info2 = @"default";
                info3 = @"default";
                info4 = @"default";
                sour1 = [NSNumber numberWithInt:1];
                sour2 = [NSNumber numberWithInt:2];
                sour3 = [NSNumber numberWithInt:3];
                sour4 = [NSNumber numberWithInt:4];
                content1 = @"default";
                content2 = @"default";
                content3 = @"default";
                content4 = @"default";
                output1 = @"default";
                output2 = @"default";
                output3 = @"default";
                output4 = @"default";
                stress0 = @"0";
                stress1 = @"0";
                stress2 = @"0";
                stress3 = @"0";
                stress4 = @"0";
                stress5 = @"0";
                effect = @"0";
                [dic setObject:have forKey:HAVE];
                [dic setObject:done forKey:DONE];
                [dic setObject:number forKey:NUMBER];
                [dic setObject:currentNumber forKey:CURRENTNUMBER];
                [dic setObject:id1  forKey:ID1];
                [dic setObject:id2 forKey:ID2];
                [dic setObject:id3 forKey:ID3];
                [dic setObject:id4 forKey:ID4];
                [dic setObject:type1 forKey:TYPE1];
                [dic setObject:type2 forKey:TYPE2];
                [dic setObject:type3 forKey:TYPE3];
                [dic setObject:type4 forKey:TYPE4];
                [dic setObject:time0 forKey:TIME0];
                [dic setObject:time1 forKey:TIME1];
                [dic setObject:time2 forKey:TIME2];
                [dic setObject:time3 forKey:TIME3];
                [dic setObject:time4 forKey:TIME4];
                [dic setObject:fintime1 forKey:FINTIME1];
                [dic setObject:fintime2 forKey:FINTIME2];
                [dic setObject:fintime3 forKey:FINTIME3];
                [dic setObject:fintime4 forKey:FINTIME4];
                [dic setObject:fin1 forKey:FIN1];
                [dic setObject:fin2 forKey:FIN2];
                [dic setObject:fin3 forKey:FIN3];
                [dic setObject:fin4 forKey:FIN4];
                [dic setObject:info1 forKey:INFO1];
                [dic setObject:info2 forKey:INFO2];
                [dic setObject:info3 forKey:INFO3];
                [dic setObject:info4 forKey:INFO4];
                [dic setObject:sour1 forKey:SOUR1];
                [dic setObject:sour2 forKey:SOUR2];
                [dic setObject:sour3 forKey:SOUR3];
                [dic setObject:sour4 forKey:SOUR4];
                [dic setObject:content1 forKey:CONTENT1];
                [dic setObject:content2 forKey:CONTENT2];
                [dic setObject:content3 forKey:CONTENT3];
                [dic setObject:content4 forKey:CONTENT4];
                [dic setObject:output1 forKey:OUTPUT1];
                [dic setObject:output2 forKey:OUTPUT2];
                [dic setObject:output3 forKey:OUTPUT3];
                [dic setObject:output4 forKey:OUTPUT4];
                [dic setObject:stress0 forKey:STRESS0];
                [dic setObject:stress1 forKey:STRESS1];
                [dic setObject:stress2 forKey:STRESS2];
                [dic setObject:stress3 forKey:STRESS3];
                [dic setObject:stress4 forKey:STRESS4];
                [dic setObject:stress5 forKey:STRESS5];
                [dic setObject:effect forKey:EFFECT];
                if([dic writeToFile:[self filePath] atomically:YES]){
                    NSLog(@"save succeed at currentplan.m");
                }else{
                    NSLog(@"save failed at currentplan.m");
                }
                
                NSLog(@"flag1 at currentplan.m");
                
            }while(0);
        }
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[self filePath]];
        
        done = [dictionary objectForKey:DONE];
        have  = [dictionary objectForKey:HAVE];
        number = [dictionary objectForKey:NUMBER];
        currentNumber   = [dictionary objectForKey:CURRENTNUMBER];
        id1    = [dictionary objectForKey:ID1];
        id2  = [dictionary objectForKey:ID2];
        id3   = [dictionary objectForKey:ID3];
        id4 = [dictionary objectForKey:ID4];
        type1 = [dictionary objectForKey:TYPE1];
        type2 = [dictionary objectForKey:TYPE2];
        type3 = [dictionary objectForKey:TYPE3];
        type4 = [dictionary objectForKey:TYPE4];
        time0 = [dictionary objectForKey:TIME0];
        time1 = [dictionary objectForKey:TIME1];
        time2 = [dictionary objectForKey:TIME2];
        time3 = [dictionary objectForKey:TIME3];
        time4 = [dictionary objectForKey:TIME4];
        fintime1 = [dictionary objectForKey:FINTIME1];
        fintime2 = [dictionary objectForKey:FINTIME2];
        fintime3 = [dictionary objectForKey:FINTIME3];
        fintime4 = [dictionary objectForKey:FINTIME4];
        fin1 = [dictionary objectForKey:FIN1];
        fin2 = [dictionary objectForKey:FIN2];
        fin3 = [dictionary objectForKey:FIN3];
        fin4 = [dictionary objectForKey:FIN4];
        info1 = [dictionary objectForKey:INFO1];
        info2 = [dictionary objectForKey:INFO2];
        info3 = [dictionary objectForKey:INFO3];
        info4 = [dictionary objectForKey:INFO4];
        sour1 = [dictionary objectForKey:SOUR1];
        sour2 = [dictionary objectForKey:SOUR2];
        sour3 = [dictionary objectForKey:SOUR3];
        sour4 = [dictionary objectForKey:SOUR4];
        content1 = [dictionary objectForKey:CONTENT1];
        content2 = [dictionary objectForKey:CONTENT2];
        content3 = [dictionary objectForKey:CONTENT3];
        content4 = [dictionary objectForKey:CONTENT4];
        output1 = [dictionary objectForKey:OUTPUT1];
        output2 = [dictionary objectForKey:OUTPUT2];
        output3 = [dictionary objectForKey:OUTPUT3];
        output4 = [dictionary objectForKey:OUTPUT4];
        stress0 = [dictionary objectForKey:STRESS0];
        stress1 = [dictionary objectForKey:STRESS1];
        stress2 = [dictionary objectForKey:STRESS2];
        stress3 = [dictionary objectForKey:STRESS3];
        stress4 = [dictionary objectForKey:STRESS4];
        stress5 = [dictionary objectForKey:STRESS5];
        effect = [dictionary objectForKey:EFFECT];
    }
    return self;
}
- (void) save{
    do{
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:have forKey:HAVE];
        [dic setObject:done forKey:DONE];
        [dic setObject:number forKey:NUMBER];
        [dic setObject:currentNumber forKey:CURRENTNUMBER];
        [dic setObject:id1  forKey:ID1];
        [dic setObject:id2 forKey:ID2];
        [dic setObject:id3 forKey:ID3];
        [dic setObject:id4 forKey:ID4];
        [dic setObject:type1 forKey:TYPE1];
        [dic setObject:type2 forKey:TYPE2];
        [dic setObject:type3 forKey:TYPE3];
        [dic setObject:type4 forKey:TYPE4];
        [dic setObject:time0 forKey:TIME0];
        [dic setObject:time1 forKey:TIME1];
        [dic setObject:time2 forKey:TIME2];
        [dic setObject:time3 forKey:TIME3];
        [dic setObject:time4 forKey:TIME4];
        [dic setObject:fintime1 forKey:FINTIME1];
        [dic setObject:fintime2 forKey:FINTIME2];
        [dic setObject:fintime3 forKey:FINTIME3];
        [dic setObject:fintime4 forKey:FINTIME4];
        [dic setObject:fin1 forKey:FIN1];
        [dic setObject:fin2 forKey:FIN2];
        [dic setObject:fin3 forKey:FIN3];
        [dic setObject:fin4 forKey:FIN4];
        [dic setObject:info1 forKey:INFO1];
        [dic setObject:info2 forKey:INFO2];
        [dic setObject:info3 forKey:INFO3];
        [dic setObject:info4 forKey:INFO4];
        [dic setObject:sour1 forKey:SOUR1];
        [dic setObject:sour2 forKey:SOUR2];
        [dic setObject:sour3 forKey:SOUR3];
        [dic setObject:sour4 forKey:SOUR4];
        [dic setObject:content1 forKey:CONTENT1];
        [dic setObject:content2 forKey:CONTENT2];
        [dic setObject:content3 forKey:CONTENT3];
        [dic setObject:content4 forKey:CONTENT4];
        [dic setObject:output1 forKey:OUTPUT1];
        [dic setObject:output2 forKey:OUTPUT2];
        [dic setObject:output3 forKey:OUTPUT3];
        [dic setObject:output4 forKey:OUTPUT4];
        [dic setObject:stress0 forKey:STRESS0];
        [dic setObject:stress1 forKey:STRESS1];
        [dic setObject:stress2 forKey:STRESS2];
        [dic setObject:stress3 forKey:STRESS3];
        [dic setObject:stress4 forKey:STRESS4];
        [dic setObject:stress5 forKey:STRESS5];
        [dic setObject:effect forKey:EFFECT];

        
        if([dic writeToFile:[self filePath] atomically:YES]){
            
            
            NSLog(@"save succeed at currentplan.m");
            
            NSLog(@"%@",have);
            NSLog(@"%@",done);
            NSLog(@"%@",currentNumber);
            NSLog(@"%@",id1);
            NSLog(@"%@",id2);
            NSLog(@"%@",id3);
            NSLog(@"%@",id4);
        }else{
            NSLog(@"save failed at currentplan.m");
        }
        
    }while(0);
}
@end
/*
 #import "CurrentPlan.h"
 
 CurrentPlan *newPlan = [CurrentPlan new];
 newPlan.done = [NSNumber numberWithBool:1];
  newPlan.id1 = [NSNumber numberWithInt:1];
 newPlan.stressLevel = @"12.2";
 [newPlan save];
 */
