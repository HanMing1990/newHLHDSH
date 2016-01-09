//
//  exeViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/6.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "exeViewController.h"
#import "CurrentPlan.h"

@interface exeViewController ()

@end

@implementation exeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //0. 获取当前的计划信息
    CurrentPlan * currentPlan = [CurrentPlan new];
    NSLog(@"sleepLevel : %@",currentPlan.type1);
    
    
    //1. 判断是由哪个按钮跳转过来的
    NSString *infoType = [[NSUserDefaults standardUserDefaults] valueForKey:@"planType"];
    if ([infoType isEqualToString:@"plan1"]) {
        NSLog(@"plan1");
        //修改plan显示的信息
        
    }
    else if ([infoType isEqualToString:@"plan2"])
    {
        NSLog(@"plan2");
       //修改plan显示的信息
    }
    else if ([infoType isEqualToString:@"plan3"])
    {
        NSLog(@"plan3");
        //修改plan显示的信息
    }
    else if ([infoType isEqualToString:@"plan4"])
    {
        NSLog(@"plan4!!!");
        //修改plan显示的信息
        
        
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
