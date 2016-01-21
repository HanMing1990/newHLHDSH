//
//  historyViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/5.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "historyViewController.h"
#import "Plan.h"
#import "analysisViewController.h"

@implementation historyViewController
@synthesize count;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray * array = [[Plan new] getPlanHistory];
    for (int i=(int)array.count-1; i >= 0 && i >= (int)array.count - HISTORY_NUM; i--) {
        finishTime[self.count.intValue] = [array[i] objectForKey:@"NSDateFormatedFintime4"];
        startTime[self.count.intValue] = [array[i] objectForKey:@"NSDateFormatedtime0"];
        ID[self.count.intValue] = [array[i] objectForKey:@"id"];
        flowerState[self.count.intValue] = [array[i] objectForKey:@"flowerState"];
        count = [NSNumber numberWithInt:count.intValue + 1];
    }
    for (int i=0; i<self.count.intValue; i++) {
        NSLog(@"history item: %@ %@ %@ %@",finishTime[i],startTime[i],ID[i],flowerState[i]);
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
    if (count.intValue > 0) {
        //页面跳转
        UIStoryboard *mainStoryboard = self.storyboard;
        analysisViewController *SVC;
        SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"analysisViewController"];
        [self presentViewController: SVC animated:YES completion:nil];
    }
}


- (IBAction)history2BtnClicked:(id)sender {
    //页面跳转
    UIStoryboard *mainStoryboard = self.storyboard;
    analysisViewController *SVC;
    SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"analysisViewController"];
    [self presentViewController: SVC animated:YES completion:nil];
    
}

- (IBAction)history3BtnClicked:(id)sender {
    //页面跳转
    UIStoryboard *mainStoryboard = self.storyboard;
    analysisViewController *SVC;
    SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"analysisViewController"];
    [self presentViewController: SVC animated:YES completion:nil];
    
}

- (IBAction)history4BtnClicked:(id)sender {
    //页面跳转
    UIStoryboard *mainStoryboard = self.storyboard;
    analysisViewController *SVC;
    SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"analysisViewController"];
    [self presentViewController: SVC animated:YES completion:nil];
}

@end
