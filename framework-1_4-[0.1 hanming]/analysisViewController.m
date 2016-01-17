//
//  analysisViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/5.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "analysisViewController.h"

@interface analysisViewController ()

@end

@implementation analysisViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
<<<<<<< HEAD
    //得到历史数据xxx
=======
    [self showLineChart];
>>>>>>> 749f6a7419ac20c58a7052d8d352dea9f47c8734
   
}

- (void) viewDidAppear:(BOOL)animated{
    [self.lineChart strokeChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnClicked:(id)sender {
    NSLog(@"sssssss");
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
