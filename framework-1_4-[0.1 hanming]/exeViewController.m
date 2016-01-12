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

@property (weak, nonatomic) IBOutlet UILabel *currentPlanDate;
@property (weak, nonatomic) IBOutlet UIImageView *currentPlanImage;
@property (weak, nonatomic) IBOutlet UILabel *currentPlanText;

@property long currentPlanType;
@end

@implementation exeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

    /*
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
