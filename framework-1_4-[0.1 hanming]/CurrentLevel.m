//
//  CurrentLevel.m
//  store
//
//  Created by yangjun on 16/1/6.
//  Copyright © 2016年 yangjun. All rights reserved.
//

#import "CurrentLevel.h"
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

#define STRESSLEVEL @"STRESSLEVEL"
#define STRESSTIME  @"STRESSTIME"
#define STEPLEVEL   @"STEPLEVEL"
#define STEPTIME    @"STEPTIME"
#define SLEEPLEVEL  @"SLEEPLEVEL"
#define SLEEPTIME   @"SLEEPTIME"
#define CALORIELEVEL @"CALORIELEVEL"
#define CALORIETIME  @"CALORIETIME"
#define FLOWERLEVEL @"FLOWERLEVEL"
#define FLOWERTIME  @"FLOWERTIME"



@implementation CurrentLevel

@synthesize stressLevel;
@synthesize stressTime;
@synthesize stepLevel;
@synthesize stepTime;
@synthesize sleepLevel;
@synthesize sleepTime;
@synthesize calorieLevel;
@synthesize calorieTime;
@synthesize flowerLevel;
@synthesize flowerTime;

- (NSString *) filePath{
    NSArray * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString * documentsDirectory = [path objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:levelFileName];
}

- (id) init{
    if(self = [super init]){
        //NSlog(@"init at currentplan.m");
        if(![[NSFileManager defaultManager] fileExistsAtPath:[self filePath]]) {
            //NSlog(@"no such file at currentplan.m");
            do{
                NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                
                stressLevel = @"1.1";
                stressTime = [NSDate date];
                stepLevel = @"2700";
                stepTime = [NSDate date];
                sleepLevel = @"80";
                sleepTime = [NSDate date];
                calorieLevel = @"80";
                calorieTime = [NSDate date];
                flowerLevel = @"60";
                flowerTime  = [NSDate date];
                
                [dic setObject:stressLevel forKey:STRESSLEVEL];
                [dic setObject:stressTime forKey:STRESSTIME];
                [dic setObject:stepLevel forKey:STEPLEVEL];
                [dic setObject:stepTime forKey:STEPTIME];
                [dic setObject:sleepTime forKey:SLEEPTIME];
                [dic setObject:sleepLevel forKey:SLEEPLEVEL];
                [dic setObject:calorieTime forKey:CALORIETIME];
                [dic setObject:calorieLevel forKey:CALORIELEVEL];
                [dic setObject:flowerTime forKey:FLOWERTIME];
                [dic setObject:flowerLevel forKey:FLOWERLEVEL];
                
                if([dic writeToFile:[self filePath] atomically:YES]){
                    //NSlog(@"save succeed at currentplan.m");
                }else{
                    //NSlog(@"save failed at currentplan.m");
                }
                
                //NSlog(@"flag1 at currentplan.m");
                
            }while(0);
        }
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[self filePath]];
        
        stressLevel = [dictionary objectForKey:STRESSLEVEL];
        stressTime  = [dictionary objectForKey:STRESSTIME];
        stepLevel   = [dictionary objectForKey:STEPLEVEL];
        stepTime    = [dictionary objectForKey:STEPTIME];
        sleepLevel  = [dictionary objectForKey:SLEEPLEVEL];
        sleepTime   = [dictionary objectForKey:SLEEPTIME];
        calorieTime = [dictionary objectForKey:CALORIETIME];
        calorieLevel = [dictionary objectForKey:CALORIELEVEL];
        flowerLevel = [dictionary objectForKey:FLOWERLEVEL];
        flowerTime  = [dictionary objectForKey:FLOWERTIME];
        
    }
    return self;
}
- (void) save{
    do{
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:stressLevel forKey:STRESSLEVEL];
        [dic setObject:stressTime forKey:STRESSTIME];
        [dic setObject:stepLevel forKey:STEPLEVEL];
        [dic setObject:stepTime forKey:STEPTIME];
        [dic setObject:sleepTime forKey:SLEEPTIME];
        [dic setObject:sleepLevel forKey:SLEEPLEVEL];
        [dic setObject:calorieTime forKey:CALORIETIME];
        [dic setObject:calorieLevel forKey:CALORIELEVEL];
        [dic setObject:flowerTime forKey:FLOWERTIME];
        [dic setObject:flowerLevel forKey:FLOWERLEVEL];
        
        
        if([dic writeToFile:[self filePath] atomically:YES]){
            
            
            //NSlog(@"save succeed at currentplan.m");
            
            //NSlog(@"%@",stressLevel);
            //NSlog(@"%@",stressTime);
            //NSlog(@"%@",stepLevel);
            //NSlog(@"%@",stepTime);
            //NSlog(@"%@",sleepLevel);
            //NSlog(@"%@",sleepTime);
            //NSlog(@"%@",calorieLevel);
            //NSlog(@"%@",calorieTime);
            //NSlog(@"%@",flowerLevel);
            //NSlog(@"%@",flowerTime);
        }else{
            //NSlog(@"save failed at currentplan.m");
        }
        
    }while(0);
}
@end
/*
 #import "CurrentLevel.h"
 
 CurrentLevel *newLevel = [CurrentLevel new];
 newLevel.stressTime = [NSDate date];
 newLevel.stressLevel = @"12.2";
 [newLevel save];
 */

