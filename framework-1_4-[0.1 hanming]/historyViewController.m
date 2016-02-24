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
    /*
     NSDateFormatedtime0 = "2016-02-23 06:03:17 +0000";
     NSDateFormatedtime4 = "2016-02-23 06:01:35 +0000";
     sickNumber = 25;
     */
    for (int i=(int)array.count-1; i >= 0 && i >= (int)array.count - HISTORY_NUM; i--) {
        finishTime[self.count.intValue] = [array[i] objectForKey:@"NSDateFormatedtime4"];
        startTime[self.count.intValue] = [array[i] objectForKey:@"NSDateFormatedtime0"];
        ID[self.count.intValue] = [array[i] objectForKey:@"sickNumber"];
        count = [NSNumber numberWithInt:count.intValue + 1];
    }
    for (int i=0; i<self.count.intValue; i++) {
        NSLog(@"history item: %@ %@ %@",finishTime[i],startTime[i],ID[i]);
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
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: ID[0]     forKey:HISTORYID];
        [defaults synchronize];
        UIStoryboard *mainStoryboard = self.storyboard;
        analysisViewController *SVC;
        SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"analysisViewController"];
        [self presentViewController: SVC animated:YES completion:nil];
    }
}


- (IBAction)history2BtnClicked:(id)sender {
    if (count.intValue > 1) {
        //页面跳转
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: ID[1]     forKey:HISTORYID];
        [defaults synchronize];
        UIStoryboard *mainStoryboard = self.storyboard;
        analysisViewController *SVC;
        SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"analysisViewController"];
        [self presentViewController: SVC animated:YES completion:nil];
    }
}

- (IBAction)history3BtnClicked:(id)sender {
    if (count.intValue > 2) {
        //页面跳转
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: ID[2]     forKey:HISTORYID];
        [defaults synchronize];
        UIStoryboard *mainStoryboard = self.storyboard;
        analysisViewController *SVC;
        SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"analysisViewController"];
        [self presentViewController: SVC animated:YES completion:nil];
    }
}

- (IBAction)history4BtnClicked:(id)sender {
    if (count.intValue > 3) {
        //页面跳转
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: ID[3]     forKey:HISTORYID];
        [defaults synchronize];
        UIStoryboard *mainStoryboard = self.storyboard;
        analysisViewController *SVC;
        SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"analysisViewController"];
        [self presentViewController: SVC animated:YES completion:nil];
    }
}

@end
