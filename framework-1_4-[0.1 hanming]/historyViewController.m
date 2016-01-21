//
//  historyViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/5.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "historyViewController.h"
#import "Plan.h"

@interface historyViewController ()

@end

@implementation historyViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray * array = [[Plan new] getPlanHistory];
    int historyNum = 4;
    [NSNumber ];
    for (int i=(int)array.count-1; i >= 0 && i >= (int)array.count - historyNum; i++) {
        NSDate * time1 = [array[i] objectForKey:@"NSDateFormatedFintime4"];
        NSString* flowerState = [array[i] objectForKey:@"NSDateFormatedFintime4"];
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
- (IBAction)history1BtnClicked:(id)sender {
  
}


- (IBAction)history2BtnClicked:(id)sender {
    
    
}

- (IBAction)history3BtnClicked:(id)sender {
    
    
}

- (IBAction)history4BtnClicked:(id)sender {
    
}

@end
