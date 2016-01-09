//
//  planViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/5.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "planViewController.h"
#import "exeViewController.h"
#import "CurrentPlan.h"

@interface planViewController ()
@property (weak, nonatomic) IBOutlet UIButton *plan1Btn;
@property (weak, nonatomic) IBOutlet UIButton *plan2Btn;


@end

@implementation planViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //0. 获取当前的计划信息
    CurrentPlan * currentPlan = [CurrentPlan new];
    NSLog(@"sleepLevel : %@",currentPlan.type1);

    
    //1.改变计划类型的图标
    //self.planImage1.image = [UIImage imageNamed: imageName1];//改变imageview的图标
    [self.plan1Btn setImage:[UIImage imageNamed:@"zhe"] forState:UIControlStateNormal];
    [self.plan2Btn setImage:[UIImage imageNamed:@"sun"] forState:UIControlStateNormal];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)plan1BtnClicked:(id)sender {
    [self recordBtnTypeAndPresentNewExeVC:@"plan1"];
}
- (IBAction)plan2BtnClicked:(id)sender {
    [self recordBtnTypeAndPresentNewExeVC:@"plan2"];
}
- (IBAction)plan3BtnClicked:(id)sender {
    [self recordBtnTypeAndPresentNewExeVC:@"plan3"];
}
- (IBAction)plan4BtnClicked:(id)sender {
    [self recordBtnTypeAndPresentNewExeVC:@"plan4"];
}





//记录点击的按钮信息和翻页到info页面
- (void)recordBtnTypeAndPresentNewExeVC:(NSString *) BtnType{
    //1.记录点击的按钮类型
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: BtnType forKey:@"planType"];
    [defaults synchronize];
    //2.切换页面，记得先修修改要切换的页面的storyboard id
    UIStoryboard *mainStoryboard = self.storyboard;
    exeViewController *SVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"exeViewController"];
    //设置翻页效果
    [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController: SVC animated:YES completion:nil];
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
