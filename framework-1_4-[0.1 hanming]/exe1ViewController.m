//
//  exe1ViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/11.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "exe1ViewController.h"

@interface exe1ViewController ()

@end

@implementation exe1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
    //0. 获取当前的计划信息(存在静态变量里)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.currentPlanDate.text = [defaults valueForKey:@"currentPlanDate"];
    self.currentPlanText.text = [defaults valueForKey:@"currentPlanText"];
    self.currentPlanType = [[defaults valueForKey:@"currentPlanType"] integerValue];
    
    NSString *planImageName;
    switch (self.currentPlanType) {
        case 0:
            planImageName = @"planType0";
            break;
        case 1:
            planImageName = @"planType1";
            break;
        case 2:
            planImageName = @"planType2";
            break;
        case 3:
            planImageName = @"planType3";
            break;
        case 4:
            planImageName = @"planType4";
            break;
        default:
            planImageName = @"planType0";
            break;
    }
    
    self.currentPlanImage.image = [UIImage imageNamed: planImageName];
    
    
    //1. 右上角花的状态（同mainVC中的花的状态）
    //1.1 根据历史完成情况获取花的状态名字
    
    NSString *flowerStateStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"flowerState"];
    int flowerState;
    flowerState = [flowerStateStr intValue];
    
    //1.2 获取花的名字
    NSString *flowerImageName;
    switch (flowerState) {
        case 0:
            flowerImageName = @"zhongzi";
            break;
        case 1:
            flowerImageName = @"youmiao";
            break;
        case 2:
            flowerImageName = @"xiaohua";
            break;
        case 3:
            flowerImageName = @"dahua";
            break;
        default:
            flowerImageName = @"guoshi";
            break;
    }
    self.flowerImage.image = [UIImage imageNamed: flowerImageName];//改变imageview的图标
    
    //2. 显示plan的内容， xxx
    self.showTextView.text = @"显示plan的内容";
    */
    
    
    
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
