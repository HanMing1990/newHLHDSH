//
//  Logic.h
//  framework-1_4-[0.1 hanming]
//
//  Created by yangjun on 16/2/27.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logic : NSObject

- (void) downLoad; //将手环的数据下载下来并存储到数据库中。 调用地点：1: 在每次app打开时 2: 在手动同步时
- (void) detect; //根据手环得到的数据计算当天的压力值      调用地点：1: 在每次app打开时 2: 在手动同步时
- (void) judge;  //判断是否需要产生计划，如果需要产生，则生成计划，否则不生成  调用地点：1: 在每次app打开时 2: 在手动同步时 3：计划完成之时！！！

@end
