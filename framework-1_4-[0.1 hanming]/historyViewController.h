//
//  historyViewController.h
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/5.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "static.h"

@interface historyViewController : UIViewController{
    NSNumber* ID[HISTORY_NUM];
    NSString* startTime[HISTORY_NUM];
    NSString* finishTime[HISTORY_NUM];
    NSNumber* count;
}
@property (retain,nonatomic) NSNumber* count;
@end
