//
//  Logic.m
//  framework-1_4-[0.1 hanming]
//
//  Created by yangjun on 16/2/27.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "Logic.h"
#import "Plan.h"
/*
 1. mainViewController:
    download,detect,judge
 2. 手动同步的按钮触发的函数中：
    download,detect,judge
 3. 一个疗程完成之后：
    judge
 */
@implementation Logic
- (void) downLoad{
    //连接蓝牙，得到 步数，卡路里，睡眠的情况
    //将得到的最新的步数，卡路里，睡眠更新到sleepdata.plist
    //将得到的步数，卡路里，睡眠情况存到历史数据库sqlite3中，需要注意睡眠的特殊性，当获得当前的睡眠值之后再取出的就是空
    
}
- (void) detect{
    //detect 每天进行一次即可，需要判断这一天是否进行了detect
    //需要前一天完整的睡眠数据，得到睡眠质量。从数据库中找对应的日期的睡眠值,如果还没有对应日期的睡眠值，则表示缺失
    //从服务器中获取社交信息，需要存储一个user default变量存储上一次获取社交信息的时间，如果和当前时间的间隔小于24h，则进行向服务器请求并且获取社交信息并融合
    //通过前两个方面的数据：睡眠 ＋ 社交媒体 ＝ 融合数据
    //将得到的社交压力和睡眠质量以及融合的压力值存储到数据库中
}
- (void) judge{
    //根据前三天的压力值判断是否需要进行制定计划
    CurrentPlan * currentPlan = [CurrentPlan new];
    //currentPlan.have 在计划完成的时候要变成no
    //需要有一个user default变量存储上一次judge程序执行的时间，timeinterval指这个时间与当前时间的间隔
    //if (timeInterval <= 24h && currentPlan.have == YES) {
        bool need = YES;
        //判断之后计算need，即根据前三天的压力值判断是否需要进行制定计划
        if (need) {
            //生成新的计划
            Plan * plan = [Plan new];
            [plan createNewPlan];
        }
    //}
}
@end
