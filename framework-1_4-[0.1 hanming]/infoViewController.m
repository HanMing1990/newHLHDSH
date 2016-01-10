//
//  infoViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/6.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "infoViewController.h"
#import "CurrentLevel.h"

@interface infoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *infoTyepImage;
@property (weak, nonatomic) IBOutlet UILabel *infoTypeText;
@property (weak, nonatomic) IBOutlet UILabel *infoTypeNum;

@end

@implementation infoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //0. 获取当前的info 信息
    CurrentLevel * currentLevel = [CurrentLevel new];
    NSLog(@"sleepLevel : %@",currentLevel.sleepLevel);
    
    
    //1. 判断是由哪个按钮跳转过来的
    NSString *infoType = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoType"];
    if ([infoType isEqualToString:@"sleep"]) {
        NSLog(@"sleep");
        
        
        //修改info显示的信息
        self.infoTyepImage.image = [UIImage imageNamed:@"zhe"];
        self.infoTypeText.text = @"睡眠：";
        self.infoTypeNum.text = @"999999";
        
    }
    else if ([infoType isEqualToString:@"pressure"])
    {
        NSLog(@"pressure");
        //修改info显示的信息
        self.infoTyepImage.image = [UIImage imageNamed:@"image"];
        self.infoTypeText.text = @"压力值：";
        self.infoTypeNum.text = @"999999";

    }
    else if ([infoType isEqualToString:@"step"])
    {
        NSLog(@"step");
        //修改info显示的信息
        self.infoTyepImage.image = [UIImage imageNamed:@"zhe"];
        self.infoTypeText.text = @"步数：";
        self.infoTypeNum.text = @"009099";
        

    }
    else if ([infoType isEqualToString:@"kaluli"])
    {
        NSLog(@"kaluli");
        //修改info显示的信息
        self.infoTyepImage.image = [UIImage imageNamed:@"zhe"];
        self.infoTypeText.text = @"卡路里：";
        self.infoTypeNum.text = @"009099";

    }
    
    
}

- (IBAction)backBtn:(id)sender {

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
