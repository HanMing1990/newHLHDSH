//
//  exeViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/6.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "exe1ViewController.h"
#import "CurrentPlan.h"
#import "planViewController.h"

@interface exe1ViewController ()
/*
@property (weak, nonatomic) IBOutlet UILabel *currentPlanDate;
@property (weak, nonatomic) IBOutlet UIImageView *currentPlanImage;
@property (weak, nonatomic) IBOutlet UILabel *currentPlanText;
@property (weak, nonatomic) IBOutlet UIImageView *flowerImage;
@property (weak, nonatomic) IBOutlet UITextView *showTextView;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
*/
@property (weak, nonatomic) IBOutlet UILabel *currentPlanDate;
@property (weak, nonatomic) IBOutlet UIImageView *currentPlanImage;
@property (weak, nonatomic) IBOutlet UILabel *currentPlanText;
@property (weak, nonatomic) IBOutlet UIImageView *flowerImage;
@property (weak, nonatomic) IBOutlet UITextView *showTextView;



@property long currentPlanType;
@end

@implementation exe1ViewController

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
- (IBAction)laterBtnClicked:(id)sender {
    //1. 这人取消了当前的计划，记录到数据库里 xxx
    NSLog(@"later Btn clicked");
    
    //2. 跳转到planVC中
    UIStoryboard *mainStoryboard = self.storyboard;
    planViewController *SVC;
    SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"planViewController"];
    //设置翻页效果
    [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController: SVC animated:YES completion:nil];
}

- (IBAction)finishBtnClicked:(id)sender {
    
    //1. 这人完成了当前的计划，记录到数据库里 xxx
    //2. 跳转到planVC中
    UIStoryboard *mainStoryboard = self.storyboard;
    planViewController *SVC;
    SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"planViewController"];
    //设置翻页效果
    [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController: SVC animated:YES completion:nil];
    
    
    NSLog(@"finish Btn clicked");
}

- (IBAction)changeBtnClicked:(id)sender {
    //更换计划
    //0. 获取当前的计划信息(存在静态变量里) xxx
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.currentPlanDate.text = [defaults valueForKey:@"currentPlanDate"];
    //1. 需要从数据库里再取出来一个新的plan，xxx
    self.currentPlanText.text = @"需要从数据库里再取";
    self.currentPlanType = 3;
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
    //2. 需要从数据库里再取出来一个新的plan内容，xxx
    self.showTextView.text = @"显示plan的内容";
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
