//
//  planViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/5.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "planViewController.h"
#import "exeViewController.h"
#import "exe1ViewController.h"
#import "exe2ViewController.h"
#import "exe3ViewController.h"
#import "exe4ViewController.h"
#import "CurrentPlan.h"


@interface planViewController ()
@property (weak, nonatomic) IBOutlet UIButton *plan1Btn;
@property (weak, nonatomic) IBOutlet UIButton *plan2Btn;
@property (weak, nonatomic) IBOutlet UIButton *plan3Btn;
@property (weak, nonatomic) IBOutlet UIButton *plan4Btn;

@property (weak, nonatomic) IBOutlet UILabel *plan1Date;
@property (weak, nonatomic) IBOutlet UILabel *plan2Date;
@property (weak, nonatomic) IBOutlet UILabel *plan3Date;
@property (weak, nonatomic) IBOutlet UILabel *plan4Date;

@property (weak, nonatomic) IBOutlet UILabel *plan1Text;
@property (weak, nonatomic) IBOutlet UILabel *plan2Text;
@property (weak, nonatomic) IBOutlet UILabel *plan4Text;
@property (weak, nonatomic) IBOutlet UILabel *plan3Text;

@property (weak, nonatomic) IBOutlet UIImageView *flowerImage;

@property int plan1Type;
@property int plan2Type;
@property int plan3Type;
@property int plan4Type;

@property CurrentPlan* currentPlan;
@end

@implementation planViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //0. 获取当前的计划信息 xxx
    self.currentPlan = [CurrentPlan new];
    if (self.currentPlan.have.boolValue == 1) {
        //还没有计划，当然需要有一个张图片显示说没有计划啦
        
    }else if(self.currentPlan.done.boolValue == 1){
        //计划已经做完啦，所以呢，显示你已经完成计划的提示啦
        
    }
    
    //设置日期格式啦
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    fmt.dateFormat = @"MM月dd日HH点";
    //1. 修改四个plan的显示信息
    //1.1 plan1
    if(self.currentPlan.number > 0){
        Item * item = [[Plan new] getItemById:self.currentPlan.id1];
        NSString *time1 = [fmt stringFromDate:self.currentPlan.time1];
        self.plan1Date.text = time1;
        self.plan1Text.text = item.info;
        self.plan1Type = item.inte.intValue;
    
    
        NSString *plan1BtnImageName;
        switch (self.plan1Type) {
            case 0:
                plan1BtnImageName = @"planType0";
                break;
            case 1:
                plan1BtnImageName = @"planType1";
                break;
            case 2:
                plan1BtnImageName = @"planType2";
                break;
            case 3:
                plan1BtnImageName = @"planType3";
                break;
            case 4:
                plan1BtnImageName = @"planType4";
                break;
            default:
                plan1BtnImageName = @"planType0";
                break;
        }
    }else{
       //不显示
    }
    //1.2 plan2
    if(self.currentPlan.number.intValue > 1){
        Item * item = [[Plan new] getItemById:self.currentPlan.id2];
        NSString *time2 = [fmt stringFromDate:self.currentPlan.time2];
        self.plan2Date.text = time2;
        self.plan2Text.text = item.info;
        self.plan2Type = item.inte.intValue;

        NSString *plan2BtnImageName;
        switch (self.plan2Type) {
            case 0:
                plan2BtnImageName = @"planType0";
                break;
            case 1:
                plan2BtnImageName = @"planType1";
                break;
            case 2:
                plan2BtnImageName = @"planType2";
                break;
            case 3:
                plan2BtnImageName = @"planType3";
                break;
            case 4:
                plan2BtnImageName = @"planType4";
                break;
            default:
                plan2BtnImageName = @"planType0";
                break;
        }
    }else{
        //不显示
    }
    //1.3 plan3
    if(self.currentPlan.number.intValue > 2){
        Item * item = [[Plan new] getItemById:self.currentPlan.id3];
        NSString *time3 = [fmt stringFromDate:self.currentPlan.time3];
        self.plan3Date.text = time3;
        self.plan3Text.text = item.info;
        self.plan3Type = item.inte.intValue;
        
        NSString *plan3BtnImageName;
        switch (self.plan3Type) {
            case 0:
                plan3BtnImageName = @"planType0";
                break;
            case 1:
                plan3BtnImageName = @"planType1";
                break;
            case 2:
                plan3BtnImageName = @"planType2";
                break;
            case 3:
                plan3BtnImageName = @"planType3";
                break;
            case 4:
                plan3BtnImageName = @"planType4";
                break;
            default:
                plan3BtnImageName = @"planType0";
                break;
        }
    }else{
        //不显示
    }
    //1.4 plan4
    if(self.currentPlan.number.intValue > 3){
        Item * item = [[Plan new] getItemById:self.currentPlan.id4];
        NSString *time4 = [fmt stringFromDate:self.currentPlan.time4];
        self.plan4Date.text = time4;
        self.plan4Text.text = item.info;
        self.plan4Type = item.inte.intValue;
        
        
        NSString *plan4BtnImageName;
        switch (self.plan4Type) {
            case 0:
                plan4BtnImageName = @"planType0";
                break;
            case 1:
                plan4BtnImageName = @"planType1";
                break;
            case 2:
                plan4BtnImageName = @"planType2";
                break;
            case 3:
                plan4BtnImageName = @"planType3";
                break;
            case 4:
                plan4BtnImageName = @"planType4";
                break;
            default:
                plan4BtnImageName = @"planType0";
                break;
        }
    }else{
        //不显示
    }
    
    //2. 右上角花的状态（同mainVC中的花的状态）
    //2.1 根据历史完成情况获取花的状态名字
    
    NSString *flowerStateStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"flowerState"];
    int flowerState;
    flowerState = [flowerStateStr intValue];
    
    //2.2 获取花的名字
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
    
    //上面的代码呀，都是设置值的，下面来调调大小呀，设置美化呀等等
    //那个字太大了，给它弄小点
    self.plan1Date.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    self.plan2Date.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    self.plan3Date.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    self.plan4Date.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//4个button的点击
- (IBAction)plan1BtnClicked:(id)sender {
   // if (self.currentPlan.number.intValue > 0) {
        //记录当前plan的信息，以备后面执行界面显示
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: self.plan1Date.text forKey:@"currentPlanDate"];
        [defaults setObject: self.plan1Text.text forKey:@"currentPlanText"];
        [defaults setObject: self.currentPlan.id1 forKey:@"currentPlanId"];
        [defaults setObject: [NSString stringWithFormat:@"%i",self.plan1Type] forKey:@"currentPlanType"];
        [defaults synchronize];
        //跳转到执行页面
        [self presentExeVC:self.plan1Type];
    //}else{
        //do nothing because don't have this item
    //}
}


- (IBAction)plan2BtnClicked:(id)sender {
    //if (self.currentPlan.number.intValue > 1) {
        //记录当前plan的信息，以备后面执行界面显示
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: self.plan2Date.text forKey:@"currentPlanDate"];
        [defaults setObject: self.plan2Text.text forKey:@"currentPlanText"];
        [defaults setObject: self.currentPlan.id2 forKey:@"currentPlanId"];
        [defaults setObject: [NSString stringWithFormat:@"%i",self.plan2Type] forKey:@"currentPlanType"];
        [defaults synchronize];
        //跳转到执行页面
        [self presentExeVC:self.plan2Type];
    //}else{
        //do nothing because don't have this item
    //}
}


- (IBAction)plan3BtnClicked:(id)sender {
    //if (self.currentPlan.number.intValue > 2) {
        //记录当前plan的信息，以备后面执行界面显示
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: self.plan3Date.text forKey:@"currentPlanDate"];
        [defaults setObject: self.plan3Text.text forKey:@"currentPlanText"];
        [defaults setObject: self.currentPlan.id3 forKey:@"currentPlanId"];
        [defaults setObject: [NSString stringWithFormat:@"%i",self.plan3Type] forKey:@"currentPlanType"];
        [defaults synchronize];
        //跳转到执行页面
        [self presentExeVC:self.plan3Type];
    //}else{
        //do nothing because don't have this item
    //}
}

- (IBAction)plan4BtnClicked:(id)sender {
    //if (self.currentPlan.number.intValue > 2) {
        //记录当前plan的信息，以备后面执行界面显示
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: self.plan4Date.text forKey:@"currentPlanDate"];
        [defaults setObject: self.plan4Text.text forKey:@"currentPlanText"];
        [defaults setObject: self.currentPlan.id4 forKey:@"currentPlanId"];
        [defaults setObject: [NSString stringWithFormat:@"%i",self.plan4Type] forKey:@"currentPlanType"];
        [defaults synchronize];
        //跳转到执行页面
        [self presentExeVC:self.plan4Type];
    //}else{
        //do nothing because don't have this item

    //}
}


- (void) presentExeVC:(int) planType{
    UIStoryboard *mainStoryboard = self.storyboard;
    exeViewController *SVC;
    NSLog(@"to %i", planType);
    switch (planType) {
        case 0:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exeViewController"];
            break;
        case 1:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exe1ViewController"];
            break;
        case 2:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exe2ViewController"];
            break;
        case 3:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exe3ViewController"];
            break;
        case 4:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exe4ViewController"];
            break;
        default:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exeViewController"];
            break;
    }
    //设置翻页效果
    [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController: SVC animated:YES completion:nil];
}

/*

//记录点击的按钮信息和翻页到info页面
- (void)recordBtnTypeAndPresentNewExeVC:(NSString *) BtnType{
    //1.记录点击的按钮类型
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: BtnType forKey:@"planType"];
    [defaults synchronize];

    //2.切换页面，记得先修修改要切换的页面的storyboard id
    //2.1 判断要调到哪种类型的页面
    NSString *whichVCtoJump;
    
    UIStoryboard *mainStoryboard = self.storyboard;
    exeViewController *SVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"exeViewController"];
    
    //设置翻页效果
    [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController: SVC animated:YES completion:nil];
}
*/



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
