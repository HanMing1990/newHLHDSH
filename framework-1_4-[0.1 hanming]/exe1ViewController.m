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

@property (weak, nonatomic) IBOutlet UILabel     *currentPlanDate;  //时间
@property (weak, nonatomic) IBOutlet UIImageView *currentPlanImage; //事件类型：运动，感恩 等
@property (weak, nonatomic) IBOutlet UILabel     *currentPlanText;  //事件的简称
@property (weak, nonatomic) IBOutlet UIImageView *flowerImage;      //花的图片
@property (weak, nonatomic) IBOutlet UITextView  *showTextView;     //事件显示的文字
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *laterBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;



@property NSNumber* currentPlanType;
@property Item* currentItem;
@property NSNumber* currentId;
@property NSNumber* currentPlanState;

@end

@implementation exe1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    fmt.dateFormat = @"MM月dd日HH点";
    //0. 获取当前的计划信息(存在静态变量里)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.currentId            = [defaults valueForKey:PLANID];
    self.currentPlanText.text = [defaults valueForKey:PLANINFO];
    self.showTextView.text    = [defaults valueForKey:PLANTEXT];
    self.currentPlanType      = [defaults valueForKey:PLANTYPE];
    self.currentPlanState     = [defaults valueForKey:PLANSTATE];
    if (self.currentPlanState.intValue == 0) {  //如果是已经完成的，则需要显示完成时间/内容，否则显示计划时间
        self.currentPlanDate.text = [fmt stringFromDate:[defaults valueForKey:PLANFINTIME]];
    }else{
        self.currentPlanDate.text = [fmt stringFromDate:[defaults valueForKey:PLANDATE]];
    }
    NSString *planImageName;
    switch (self.currentPlanType.intValue) {
        case 0:
            planImageName = PLANSOURCE0;
            break;
        case 1:
            planImageName = PLANSOURCE1;
            break;
        case 2:
            planImageName = PLANSOURCE2;
            break;
        case 3:
            planImageName = PLANSOURCE3;
            break;
        case 4:
            planImageName = PLANSOURCE4;
            break;
        case 5:
            planImageName = PLANSOURCE5;
            break;
        case 6:
            planImageName = PLANSOURCE6;
            break;
        case 7:
            planImageName = PLANSOURCE7;
            break;
        case 8:
            planImageName = PLANSOURCE8;
            break;
        case 9:
            planImageName = PLANSOURCE9;
            break;
        case 10:
            planImageName = PLANSOURCE10;
            break;
        default:
            planImageName = PLANSOURCE0;
            break;
    }
    
    self.currentPlanImage.image = [UIImage imageNamed: planImageName];
    
    
    //1. 右上角花的状态（同mainVC中的花的状态）
    //1.1 根据历史完成情况获取花的状态名字

    int flowerState = [[[NSUserDefaults standardUserDefaults] valueForKey:@"flowerState"] intValue];
    
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
    
    if (self.currentPlanState.intValue == 0) {
        //self.laterBtn.hidden = YES;
        self.changeBtn.hidden = YES;
        self.sureBtn.hidden = YES;
    }else if(self.currentPlanState.intValue == 1){
        
    }else{
        //self.laterBtn.hidden = YES;
        self.changeBtn.hidden = YES;
        self.sureBtn.hidden = YES;
    }
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
    Plan *plan = [Plan new];
    [plan finishItem:YES forId:self.currentId Content:@""];
    //2. 跳转到planVC中
    UIStoryboard *mainStoryboard = self.storyboard;
    planViewController *SVC;
    SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"planViewController"];
    //设置翻页效果
    [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController: SVC animated:YES completion:nil];
    NSLog(@"finish Btn clicked");
}


- (IBAction)changePlanBtnClicked:(id)sender {
    //更换计划
    //1. 从数据库里再取出来一个新的plan
    Plan *plan = [Plan new];
    self.currentItem = [plan changeItemById:self.currentId];
    
    //2. 记录新plan到静态变量中，以备跳转的时候显示
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: self.currentItem.ID       forKey:PLANID];
    //[defaults setObject: forKey:@"currentPlanDate"]; //don't need to set because  there is no change
    [defaults setObject: self.currentItem.content1 forKey:PLANTEXT];
    [defaults setObject: self.currentItem.info     forKey:PLANINFO];
    [defaults setObject: self.currentItem.sour     forKey:PLANTYPE];
    [defaults synchronize];
    //跳转到执行页面
    [self presentExeVC:self.currentItem.inte.intValue];
    
}


- (void) presentExeVC:(int) planType{
    UIStoryboard *mainStoryboard = self.storyboard;
    exe1ViewController *SVC;
    
    NSLog(@"要跳转到%i", planType);
    
    switch (planType) {
        case 0:
        case 1:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exe1ViewController"];
            NSLog(@"jump to page: exe1 ");
            break;
        case 2:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exe2ViewController"];
            NSLog(@"jump to page: exe2 ");
            break;
        case 3:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exe3ViewController"];
            NSLog(@"jump to page: exe3 ");
            break;
        case 4:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exe4ViewController"];
            NSLog(@"jump to page: exe4 ");
            break;
        case 5:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exe5ViewController"];
            NSLog(@"jump to page: exe5 ");
            break;
        case 6:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exe6ViewController"];
            NSLog(@"jump to page: exe6 ");
        case 7:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exe7ViewController"];
            NSLog(@"jump to page: exe6 ");
            break;
    }
    //设置翻页效果
    [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController: SVC animated:YES completion:nil];
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
