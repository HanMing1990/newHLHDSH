//
//  CurrentLevel.h
//  store
//
//  Created by yangjun on 16/1/6.
//  Copyright © 2016年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  CurrentLevel : NSObject{
    NSString* stressLevel;
    NSDate *stressTime;
    NSString*  stepLevel;
    NSDate *stepTime;
    NSString*  sleepLevel;
    NSDate *sleepTime;
    NSString*  flowerLevel;
    NSDate *flowerTime;
}
@property(retain,nonatomic)  NSString*  stressLevel;
@property(retain,nonatomic)  NSDate *stressTime;
@property(retain,nonatomic)  NSString*  stepLevel;
@property(retain,nonatomic)  NSDate *stepTime;
@property(retain,nonatomic)  NSString*  sleepLevel;
@property(retain,nonatomic)  NSDate *sleepTime;
@property(retain,nonatomic)  NSString*  flowerLevel;
@property(retain,nonatomic)  NSDate *flowerTime;

- (void) save;
@end


