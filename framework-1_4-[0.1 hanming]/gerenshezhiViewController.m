//
//  gerenshezhiViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/2/22.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "gerenshezhiViewController.h"

@interface gerenshezhiViewController ()

@end

@implementation gerenshezhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveBtnClicked:(id)sender {
    
    // 保存设置的目标
    //1.记录点击的按钮类型
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: @([self.kaluliTarget.text floatValue]) forKey:@"kaluliTarget"];
    [defaults setObject: @([self.stepTarget.text floatValue]) forKey:@"stepTarget"];
    [defaults setObject: @([self.sleepTarget.text floatValue]) forKey:@"sleepTarget"];
    [defaults setObject: @([self.distanceTarget.text floatValue]) forKey:@"distanceTarget"];
    [defaults synchronize];
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
