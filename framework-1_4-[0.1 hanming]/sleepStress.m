//
//  sleepStress.m
//  CBChart
//
//  Created by db9-216 on 16/2/10.
//  Copyright © 2016年 pacific. All rights reserved.
//

#import "sleepStress.h"
#import "math.h"


@implementation sleepStress
{
    
    //活动与睡眠特征
    double fallAsleepTime;   //进入睡眠时间
    int    awakeNumber;      //醒的次数
    double awakeTime;        //清醒时间
    double shallowSleepTime; //浅睡时间
    double deepSleepTime;    //深睡时间
    int    walkingSteps;     //行走步数
    
    double goToBedTime;      //上床时间
    double getUpBedTime;     //起床时间

    //线性加权参数
    NSArray *weight;
    
    //心理压力
    double stressValue;
    
    //心理压力阈值
    NSArray *stressThresholds;
}


-(int) calStressLevel {
    int stressLevel = 0;
    //初始化
    [self setInitialWeight:5];
    [self setInitialStressThresholds];
    
    stressValue =  [[weight objectAtIndex:0] doubleValue]*[self calFallAsleepTime:60] +  [[weight objectAtIndex:1] doubleValue]*[self calAwakeNumber:3] + [[weight objectAtIndex:2] doubleValue]*[self calAwakeTime:50] + [[weight objectAtIndex:3] doubleValue]*[self calDaytimeFunction:13000] + [[weight objectAtIndex:4] doubleValue]*[self calGoldSleepRate:150 andShallow:450];
    
    NSLog(@"stressValue: %f",stressValue);
    //NSLog(@"%lu",(unsigned long)[stressThresholds count]);
    
 
    //stress threshold -> abnormal(stress) level
    //stressValue <0.5: no stress; stressValue =0.5: very light; stressValue = 0.6: light;
    //stressValue =0.7: medium; stressValue =0.8: strong; stressValue >0.8: very strong
    if (stressValue < [[stressThresholds objectAtIndex:0] doubleValue]) {
        stressLevel = 0;
        NSLog(@"压力值为: %d, No stress", stressLevel);
    }
    else if ([self doubleEqual:stressValue andB:[[stressThresholds objectAtIndex:0] doubleValue]] )
    {
        stressLevel = 1;
        NSLog(@"压力值为: %d, Very light stress", stressLevel);
    }
    else if ([self doubleEqual:stressValue andB:[[stressThresholds objectAtIndex:1] doubleValue]] )
    {
        stressLevel = 2;
        NSLog(@"压力值为: %d, Light stress", stressLevel);
    }
    else if ([self doubleEqual:stressValue andB:[[stressThresholds objectAtIndex:2] doubleValue]] )
    {
        stressLevel = 3;
        NSLog(@"压力值为: %d, Medium stress", stressLevel);
    }
    else if ([self doubleEqual:stressValue andB:[[stressThresholds objectAtIndex:3] doubleValue]] )
    {
        stressLevel = 4;
        NSLog(@"压力值为: %d, Strong stress", stressLevel);
    }
    else if (stressValue > [[stressThresholds objectAtIndex:3] doubleValue])
    {
        stressLevel = 5;
        NSLog(@"压力值为: %d, Very strong stress", stressLevel);
    }
    return stressLevel;
}


//计算睡眠三个初始参数 abnormal score

-(int) calFallAsleepTime:(double)fallAsleepTime{
    int fATScore;
    // 进入睡眠时间，经验标准 <=40min: O; 40~90min: 1; >90min: 2;
    if (fallAsleepTime<=40) {
        fATScore = 0;
    }
    else if (fallAsleepTime>40 && fallAsleepTime<=90)
    {
        fATScore = 1;
    }
    else if (fallAsleepTime > 90)
    {
        fATScore = 2;
    }
    return fATScore;
}

-(int)calAwakeNumber:(int) awakeNumber{
    int aNScore;
    // 醒的次数，经验标准 <=2: 0; 2-4：1；>4: 2
    if (awakeNumber<=2) {
        aNScore = 0;
    }
    else if (awakeNumber>2 && awakeNumber<=4)
    {
        aNScore = 1;
    }
    else if (awakeNumber>4)
    {
        aNScore = 2;
    }
    return aNScore;
}

-(int) calAwakeTime: (double) awakeTime{
    int aTScore;
    // 清醒时间，经验标准 <=90min: 0; 90min-150min: 1; >150min: 2
    if (awakeTime<=90) {
        aTScore = 0;
    }
    else if (awakeTime>90 && awakeTime<=150)
    {
        aTScore = 1;
    }
    else if (awakeTime>150)
    {
        aTScore = 2;
    }
    return aTScore;
}

-(int) calDaytimeFunction:(int)walkingSteps{
    int dFScore;
    //行走步数，经验标准 3500-10000:0; 1500-3500/10000-20000:1; <1500/>20000:2
    if (walkingSteps>=3500 && walkingSteps<10000) {
        dFScore = 0;
    }
    else if (walkingSteps<1500 && walkingSteps>=20000)
    {
        dFScore = 2;
    }
    else if (walkingSteps>=1500 && walkingSteps<3500)
    {
        dFScore = 1;
    }
    else if (walkingSteps>=10000 && walkingSteps<20000)
    {
        dFScore = 1;
    }
    return dFScore;
}

-(int) calGoldSleepRate:(double) deepSleepTime andShallow:(double)shallowSleepTime{
    double sleepTotalTime;
    double goldSleepRate;
    sleepTotalTime = shallowSleepTime+deepSleepTime;
    goldSleepRate= deepSleepTime/sleepTotalTime;
    
    int gSRScore;
    // 黄金睡眠率，经验标准 >=25%: 0; 15%-25%: 1; <15%: 2
    if (goldSleepRate>=0.25) {
        gSRScore = 0;
    }
    else if (goldSleepRate<0.25 && goldSleepRate>=0.15)
    {
        gSRScore = 1;
    }
    else if (goldSleepRate<0.15)
    {
        gSRScore = 2;
    }
    return  gSRScore;
}


//-(double) calHabitualSleepEff:(double)sleepTotalTime andTakeBed:(double) takeBedTime andGetUp:(double) getUpTime{
//    habitualSleepEff = sleepTotalTime/(getUpTime-takeBedTime);
//    return habitualSleepEff;
//}


//设定权重初始值
-(void) setInitialWeight:(int) weightNum{
    weight = [[NSArray alloc] init];
    for (int i=0; i<5; i++) {
        //各睡眠特征初始时同等重要
        double weightTmp = 1.0/5;
        NSString *weightTmpString = [NSString stringWithFormat:@"%f",weightTmp];
        weight = [weight arrayByAddingObject:weightTmpString];
    }
    //NSLog(@"%f", [[weight objectAtIndex:0] doubleValue]);
}

//设置睡眠压力分值stressValue的阈值
-(void) setInitialStressThresholds{
    stressThresholds = [[NSArray alloc] init];
    for (int i=0; i<=3; i++) {
        double thresholdTmp = i*0.1+0.5;
        NSString *thresholdTmpString = [NSString stringWithFormat:@"%f",thresholdTmp];
        stressThresholds = [stressThresholds arrayByAddingObject: thresholdTmpString];
    }
}

//其他调用函数
-(BOOL) doubleEqual:(double) A  andB:(double) B{
    if (fabs(A-B)<0.000001)
        return true;
    else
        return false;
}
@end
