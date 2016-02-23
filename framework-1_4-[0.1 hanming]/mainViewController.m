//
//  mainViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/5.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "mainViewController.h"
#import "historyViewController.h"
#import "CurrentLevel.h"
#import "InitSqlite3.h"
#import "Plan.h"
#import "PNChart.h"
#import "CurrentLevel.h"
#import "HMNetwork.h"
#import "stdlib.h"

@interface mainViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UITextView *mainTopLabel;
@property (weak, nonatomic) IBOutlet UIButton *flowerBtn;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
- (IBAction)createPlan:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *stressCircleView;
@property (weak, nonatomic) IBOutlet UIView *sleepCircleView;
@property (weak, nonatomic) IBOutlet UIView *stepCircleView;
@property (weak, nonatomic) IBOutlet UIView *calorieCircleView;

@end

@implementation mainViewController

//nothing
@synthesize leftSwipeGestureRecognizer, rightSwipeGestureRecognizer;
#pragma mark- 显示函数
- (void)viewDidLoad {
    [super viewDidLoad];
    //滑动手势
    //

    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    //----------------------------------------------
    //初始化数据库
    InitSqlite3 *initsqlite3 = [InitSqlite3 new];
    [initsqlite3 createDataBase];

    //0. 获取用户的属性
    CurrentLevel * currentLevel = [CurrentLevel new];//获取当前的数值，比如睡眠、压力、卡路里等
    
    //1. 左上角天气，取决于用户当前的压力值，压力小天气好
    //2. 右上角的提示文字,如今天情绪很好哦，花也格外旺盛呢
    NSString * weatherImgeName;
    NSString * topLabelText;
    //streeLevel还没确定时int还是float，如果时float，则需要将float映射成0～2再进行显示
    //yangj
    //NSlog(@"current level %i", currentLevel.stressLevel.intValue);
    switch (currentLevel.stressLevel.intValue) {
        case 0:
            weatherImgeName = @"sun";
            topLabelText = @"今天心情不错，继续保持哦～";
            break;
        case 1:
            weatherImgeName = @"cloudy";
            topLabelText = @"今天心情一般，试着做点开心的事情吧~";
            break;
        case 2:
            weatherImgeName = @"rain";
            topLabelText = @"今天心情有点低沉，要多多照顾下自己的心情哦~";
            break;
        default:
            weatherImgeName = @"snow";
            topLabelText = @"今天心情很差，注意调节啊~";
            break;
    }
    self.weatherImage.image = [UIImage imageNamed:weatherImgeName];
    self.mainTopLabel.text = topLabelText;
    
    //压力值赋值 不一定是int
    //NSlog(@"current level %f", currentLevel.stressLevel.floatValue);
    self.label1.text = currentLevel.stressLevel;
    //睡眠赋值 不一定是int
    //NSlog(@"current level %f", currentLevel.sleepLevel.floatValue);
    self.label2.text = currentLevel.sleepLevel;
    //计步赋值 不一定是int
    //NSlog(@"current level %f", currentLevel.stepLevel.floatValue);
    self.label3.text = currentLevel.stepLevel;
    //卡路里赋值 不一定是int
    //NSlog(@"current level %f", currentLevel.calorieLevel.floatValue);
    self.label4.text = currentLevel.calorieLevel;
    
    
    //
    /*
    
    self.titleLabel.text = @"Circle Chart";
    
    
    self.circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0,150.0, SCREEN_WIDTH, 100.0)
                                                      total:@100
                                                    current:@60
                                                  clockwise:YES];
    
    self.circleChart.backgroundColor = [UIColor clearColor];
    
    [self.circleChart setStrokeColor:[UIColor clearColor]];
    [self.circleChart setStrokeColorGradientStart:[UIColor blueColor]];
    [self.circleChart strokeChart];
    
    [self.view addSubview:self.circleChart];
    
    */
    //
    
    

    // 以下是杨俊写的圆圈显示数值的代码
    // 先取得当前的显示的数值
    NSNumber *stressValue = @([currentLevel.stressLevel floatValue]);
    NSNumber *sleepValue = @([currentLevel.sleepLevel floatValue]);
    NSNumber *stepValue = @([currentLevel.stepLevel floatValue]);
    NSNumber *calorieValue = @([currentLevel.calorieLevel floatValue]);
    
    //取目标值
    
    //设置目标的默认值，按理说这里应该再写一个界面来让用户输入
    NSNumber *kaluliTarget = [[NSUserDefaults standardUserDefaults] valueForKey:@"kaluliTarget"];
    NSNumber *stepTarget = [[NSUserDefaults standardUserDefaults] valueForKey:@"stepTarget"];
    NSNumber *sleepTarget = [[NSUserDefaults standardUserDefaults] valueForKey:@"sleepTarget"];
    //NSNumber *distanceTarget = [[NSUserDefaults standardUserDefaults] valueForKey:@"distanceTarget"];
    // stress
    self.circleChartStress = [[PNCircleChart alloc] initWithFrame:CGRectMake(17,8, 50, 50)
                                                      total:@10
                                                    current:stressValue
                                                  clockwise:YES
                                                  shadow:YES
                                                    shadowColor:PNLightGrey];//调颜色留着以后再扣
                                                  //shadowColor:[UIColor colorWithRed:255.0f/255.0f green:185.0f/255.0f blue:15.0f/255.0f alpha:0.8]];
                               
                                                //shadowColor:[UIColor blueColor]];
    
    self.circleChartStress.backgroundColor = [UIColor clearColor];
    [self.circleChartStress setStrokeColor:[UIColor clearColor]];
    // change color according to the stress lever
    [self.circleChartStress setStrokeColorGradientStart:[UIColor colorWithRed:255.0f/255.0f green:185.0f/255.0f blue:15.0f/255.0f alpha:0.5]];
    //[self.circleChartStress strokeChart];
    [self.stressCircleView addSubview:self.circleChartStress];
    
    
    
    // sleep
    self.circleChartSleep = [[PNCircleChart alloc] initWithFrame:CGRectMake(17,8, 50, 50)
                                                            total:sleepTarget
                                                          current:sleepValue
                                                        clockwise:YES];
    self.circleChartSleep.backgroundColor = [UIColor clearColor];
    [self.circleChartSleep setStrokeColor:[UIColor clearColor]];
    // change color according to the stress lever
    [self.circleChartSleep setStrokeColorGradientStart:[UIColor colorWithRed:127.0f/255.0f green:255.0f/255.0f blue:212.0f/255.0f alpha:0.8]];
    //[self.circleChartSleep strokeChart];
    [self.sleepCircleView addSubview:self.circleChartSleep];
    
    
    
    
    
    // step
    self.circleChartStep = [[PNCircleChart alloc] initWithFrame:CGRectMake(17,8, 50, 50)
                                                           total:stepTarget
                                                         current:stepValue
                                                       clockwise:YES];
    self.circleChartStep.backgroundColor = [UIColor clearColor];
    [self.circleChartStep setStrokeColor:[UIColor clearColor]];
    // change color according to the stress lever
    [self.circleChartStep setStrokeColorGradientStart:[UIColor colorWithRed:178.0f/255.0f green:34.0f/255.0f blue:34.0f/255.0f alpha:0.8]];
    //[self.circleChartStep strokeChart];
    [self.stepCircleView addSubview:self.circleChartStep];
    
    // calorie
    self.circleChartCalorie = [[PNCircleChart alloc] initWithFrame:CGRectMake(17,8, 50, 50)
                                                           total:kaluliTarget
                                                         current:calorieValue
                                                       clockwise:YES];
    self.circleChartCalorie.backgroundColor = [UIColor clearColor];
    [self.circleChartCalorie setStrokeColor:[UIColor clearColor]];
    // change color according to the stress lever
    [self.circleChartCalorie setStrokeColorGradientStart:[UIColor colorWithRed:153.0f/255.0f green:51.0f/255.0f blue:250.0f/255.0f alpha:0.8]];
    //[self.circleChartCalorie strokeChart];
    [self.calorieCircleView addSubview:self.circleChartCalorie];
    
    
    //3. 显示当前花的状态
    //3.1 根据历史完成情况获取花的状态名字
    int flowerState;
    flowerState = [currentLevel.flowerLevel intValue];//0~6

    //3.2 获取花的名字(这是只找了5种花的图片，还缺俩)
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
        case 4:
            flowerImageName = @"dahua";
            break;
        case 5:
            flowerImageName = @"dahua";
            break;
        case 6:
            flowerImageName = @"guoshi";
            break;
        default:
            flowerImageName = @"guoshi";
            break;
    }
    [self.flowerBtn setImage:[UIImage imageNamed:flowerImageName] forState:UIControlStateNormal];
    
    NSString *flowerStateStr = [NSString stringWithFormat:@"%d", flowerState];
    
    //存花的状态以备后面页面使用(这有个潜在的问题：就是可能执行完了计划以后花的状态不变)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: flowerStateStr forKey:@"flowerState"];
    [defaults synchronize];
    

}
- (void)viewDidAppear:(BOOL)animated{
    [self.circleChartCalorie strokeChart];
    [self.circleChartStress strokeChart];
    [self.circleChartSleep strokeChart];
    [self.circleChartStep strokeChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- 辅助函数

//滑动手势
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        //NSlog(@"你在往左面滑动～！");
        
        //切换页面，记得先修修改要切换的页面的storyboard id
        UIStoryboard *mainStoryboard = self.storyboard;
        historyViewController *SVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"historyViewController"];
        
        //设置翻页效果
        [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController: SVC animated:YES completion:nil];
        
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        //NSlog(@"你在往右面滑动～！");
    }
}


//记录点击的按钮信息和翻页到info页面
- (void)recordBtnTypeAndPresentNewInfoVC:(NSString *) BtnType{
    //1.记录点击的按钮类型
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: BtnType forKey:@"infoType"];
    [defaults synchronize];
    //2.切换页面，记得先修修改要切换的页面的storyboard id
    UIStoryboard *mainStoryboard = self.storyboard;
    historyViewController *SVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"infoViewController"];
    //设置翻页效果
    [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController: SVC animated:NO completion:nil];
}


#pragma mark- 事件响应函数
//点击压力值按钮
- (IBAction)pressureBtn:(id)sender {
    [self recordBtnTypeAndPresentNewInfoVC:@"pressure"];
}
//点击睡眠按钮
- (IBAction)sleepBtn:(id)sender {
   [self recordBtnTypeAndPresentNewInfoVC:@"sleep"];
}

//点击计步按钮
- (IBAction)stepBtn:(id)sender {
   [self recordBtnTypeAndPresentNewInfoVC:@"step"];
}

//点击卡路里按钮
- (IBAction)kaluliBtn:(id)sender {
    [self recordBtnTypeAndPresentNewInfoVC:@"kaluli"];
}


- (IBAction)sendDataToServerBtnClicked:(id)sender {
    //1. 初始化网络对象
    HMNetwork *hmnetwork = [[HMNetwork alloc]init];
    
    //3. 传输数据
    //[hmnetwork sendData:dataToSend];//用来测试是否
    [hmnetwork sendPlanHistory];
    //[hmnetwork sendPlanItem];
    
}
- (IBAction)generateSensorData:(id)sender {
    
    float stressValueRandom = arc4random()%6;
    float sleepValueRandom = arc4random()%100;
    float stepValueRandom = arc4random()%100;
    float calorieValueRandom = arc4random()%100;
    
    //1. 记录到数据库里， xxx
    //NSlog(@"stress %f", stressValueRandom);
    //NSlog(@"sleep %f", sleepValueRandom);
    //NSlog(@"step %f", stepValueRandom);
    //NSlog(@"calorie %f", calorieValueRandom);
    
    CurrentLevel * currentLevel = [CurrentLevel new];
    currentLevel.stressLevel = [NSString stringWithFormat:@"%f",stressValueRandom];
    currentLevel.stepLevel = [NSString stringWithFormat:@"%f",stepValueRandom];
    currentLevel.sleepLevel = [NSString stringWithFormat:@"%f",sleepValueRandom];
    currentLevel.calorieLevel = [NSString stringWithFormat:@"%f",calorieValueRandom];
    currentLevel.stressTime = currentLevel.sleepTime = currentLevel.stepTime = currentLevel.calorieTime = [NSDate date];
    [currentLevel save];
    
    Plan *plan = [Plan new];
    [plan calculateFlowerLevel];//如果压力值变化了，要重新调用这个还是，计算花的状态值
    [plan insertLevelItem];
}

- (IBAction)createPlan:(id)sender {
    Plan *plan = [Plan new];
    [plan createNewPlan]; //生成一个新的计划
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
