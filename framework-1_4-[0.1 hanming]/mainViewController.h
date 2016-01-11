//
//  mainViewController.h
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/5.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChart.h"
@interface mainViewController : UIViewController

//滑动手势
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@property (nonatomic) PNCircleChart * circleChartStress;
@property (nonatomic) PNCircleChart * circleChartSleep;
@property (nonatomic) PNCircleChart * circleChartStep;
@property (nonatomic) PNCircleChart * circleChartCalorie;
@end
