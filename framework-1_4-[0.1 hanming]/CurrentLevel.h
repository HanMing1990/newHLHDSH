//
//  CurrentLevel.h
//  store
//
//  Created by yangjun on 16/1/6.
//  Copyright © 2016年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  CurrentLevel : NSObject{
    NSString* stressLevel;           //当前压力值
    NSDate *stressTime;              //当前压力值测的时间
    NSString*  stepLevel;            //当前步数
    NSDate *stepTime;                //当前步数测的时间
    NSString*  sleepLevel;           //当前睡眠质量
    NSDate *sleepTime;               //当前压力值测的时间
    NSString *colorieLevel;          //当前卡路里量
    NSDate *colorieTime;              //当前卡路里量测的时间
    NSString*  flowerLevel;          //当前花的状态啦
    NSDate *flowerTime;              //当前花的状态测的时间
}
@property(retain,nonatomic)  NSString*  stressLevel;
@property(retain,nonatomic)  NSDate *stressTime;
@property(retain,nonatomic)  NSString*  stepLevel;
@property(retain,nonatomic)  NSDate *stepTime;
@property(retain,nonatomic)  NSString*  sleepLevel;
@property(retain,nonatomic)  NSDate *sleepTime;
@property(retain,nonatomic)  NSString*  calorieLevel;
@property(retain,nonatomic)  NSDate *calorieTime;
@property(retain,nonatomic)  NSString*  flowerLevel;
@property(retain,nonatomic)  NSDate *flowerTime;

- (void) save;
@end


