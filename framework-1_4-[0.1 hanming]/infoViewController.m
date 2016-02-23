//
//  infoViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/6.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "infoViewController.h"
#import "CurrentLevel.h"
#import "Plan.h"

@interface infoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *infoTyepImage;
@property (weak, nonatomic) IBOutlet UILabel *infoTypeText;
@property (weak, nonatomic) IBOutlet UILabel *infoTypeNum;
@property (weak, nonatomic) IBOutlet UIView *barChartView;

@end


@implementation infoViewController

//显示第三方库
- (void) showBarChart:(NSArray *) inputYValues{
    static NSNumberFormatter *barChartFormatter;
    if (!barChartFormatter){
        barChartFormatter = [[NSNumberFormatter alloc] init];
        barChartFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        barChartFormatter.allowsFloats = NO;
        barChartFormatter.maximumFractionDigits = 0;
    }
    
    //修改柱状图的位置
    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 0, self.barChartView.frame.size.width, self.barChartView.frame.size.height)];
    // self.barChart.showLabel = NO;
    self.barChart.backgroundColor = [UIColor clearColor];
    
    
    self.barChart.yChartLabelWidth = 20.0;
    self.barChart.chartMarginLeft = 40.0;
    self.barChart.chartMarginRight = 15.0;
    self.barChart.chartMarginTop = 5.0;
    self.barChart.chartMarginBottom = 10.0;
    
    self.barChart.labelMarginTop = 5.0;
    self.barChart.showChartBorder = YES;
    [self.barChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]];

    //每个柱的取值
    [self.barChart setYValues:inputYValues];
    
    
    //每个柱的颜色
    [self.barChart setStrokeColors:@[PNGreen,PNGreen,PNYellow,PNYellow,PNRed,PNRed,PNRed]];
    
    
    self.barChart.isGradientShow = NO;
    self.barChart.isShowNumbers = NO;
    
    //[self.barChart strokeChart];
    
    [self.barChartView addSubview:self.barChart];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [self.barChart strokeChart];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //0. 获取当前的info 信息
    CurrentLevel * currentLevel = [CurrentLevel new];
    //NSlog(@"sleepLevel : %@",currentLevel.sleepLevel);
    
    //1. 判断是由哪个按钮跳转过来的
    NSString *infoType = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoType"];
    Plan *currentPlan = [[Plan alloc]init];
    
    if ([infoType isEqualToString:@"sleep"]) {
        //NSlog(@"sleep");
        //修改info显示的信息
        self.infoTyepImage.image = [UIImage imageNamed:@"zhe"];
        self.infoTypeText.text = @"睡眠：";
        self.infoTypeNum.text = [NSString stringWithFormat:@"%f", currentLevel.sleepLevel.floatValue];
        
        //取出最近一周的数据进行显示
        NSArray *originalSleepArrayFromDB = [currentPlan getSleepLevel];
        //NSlog(@"Iam here %@", originalSleepArrayFromDB);
        NSMutableArray *showValues = [NSMutableArray new];
        showValues = [self getArrayToDisplayinInfoVC: originalSleepArrayFromDB];
        
        [self showBarChart:showValues];
        
    }
    else if ([infoType isEqualToString:@"pressure"])
    {
        //NSlog(@"pressure");
        //修改info显示的信息
        self.infoTyepImage.image = [UIImage imageNamed:@"image"];
        self.infoTypeText.text = @"压力值：";
        self.infoTypeNum.text = [NSString stringWithFormat:@"%f", currentLevel.stressLevel.floatValue];
        
        //取出最近一周的数据进行显示
        NSArray *originalStressArrayFromDB = [currentPlan getStressLevel];
        //NSlog(@"Iam here %@", originalSleepArrayFromDB);
        NSMutableArray *showValues = [NSMutableArray new];
        showValues = [self getArrayToDisplayinInfoVC:originalStressArrayFromDB];
        
        [self showBarChart:showValues];

    }
    else if ([infoType isEqualToString:@"step"])
    {
        //NSlog(@"step");
        //修改info显示的信息
        self.infoTyepImage.image = [UIImage imageNamed:@"zhe"];
        self.infoTypeText.text = @"步数：";
        self.infoTypeNum.text = [NSString stringWithFormat:@"%f", currentLevel.stepLevel.floatValue];
        
        //取出最近一周的数据进行显示
        NSArray *originalSteprrayFromDB = [currentPlan getStepLevel];
        NSMutableArray *showValues = [NSMutableArray new];
        showValues = [self getArrayToDisplayinInfoVC: originalSteprrayFromDB];
        
        [self showBarChart:showValues];
        

    }
    else if ([infoType isEqualToString:@"kaluli"])
    {
        //NSlog(@"kaluli");
        //修改info显示的信息
        self.infoTyepImage.image = [UIImage imageNamed:@"zhe"];
        self.infoTypeText.text = @"卡路里：";
        self.infoTypeNum.text = [NSString stringWithFormat:@"%f", currentLevel.calorieLevel.floatValue];
        
        //取出最近一周的数据进行显示
        NSArray *originalCalorieArrayFromDB = [currentPlan getCalorieLevel];
        NSMutableArray *showValues = [NSMutableArray new];
        showValues = [self getArrayToDisplayinInfoVC: originalCalorieArrayFromDB];
        
        [self showBarChart:showValues];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSMutableArray *) getArrayToDisplayinInfoVC:(NSArray *)originalArrayFromDB{
    //把 从数据库中取出近一周的数据 转化成要显示的x,y序列
    //一天有多个数据取得是和
    
    
    //NSLog(@"original data %@", originalArrayFromDB);
    
    
    NSMutableArray *yArray = [NSMutableArray new];//要显示的y轴坐标序列
    
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:60*60*8];
    
    //如果字典需要修改要用mutable 而不是用NSDictionary
    NSMutableDictionary * sumDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@0, @1, @0, @2, @0, @3, @0, @4, @0, @5, @0, @6, @0, @7, nil];//用来收集同一天的时间
    
    //NSLog(@"sumDict%@", sumDict);
    for (int i=0; i<originalArrayFromDB.count; i++) {
        //这里有问题，time
        NSDate * time = [originalArrayFromDB[i] objectForKey:@"NSDateFormatedTime"]; //X轴
        NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:time];
        //NSLog(@"时间间距 %f", timeInterval);
        
        int daysNumFromToday;
        daysNumFromToday= (int)timeInterval/(60*60*24); //距离今天多久
        
        NSNumber *myKey  = [NSNumber numberWithInt:(7-daysNumFromToday)];
        NSNumber *v1 = [sumDict objectForKey: myKey];
        NSNumber *v2 = [originalArrayFromDB[i] objectForKey:@"level"];
        NSNumber *sum = [NSNumber numberWithFloat:([v1 floatValue]+[v2 floatValue])];
        
    
        [sumDict setObject:sum forKey:myKey];
        
        //NSString * level = [originalArrayFromDB[i] objectForKey:@"level"]; //y轴
        //[yArray addObject:[originalArrayFromDB[i] objectForKey:@"level"]];
        //[xArray addObject:[originalArrayFromDB[i] objectForKey:@"time"]];
        
        //NSLog(@"current sumDict, %@", sumDict);

    }
    
    //NSLog(@"要显示的x坐标：%@",xArray);
    //NSLog(@"当前时刻：%@",currentDate);
    
    NSArray *allMyKeys = [[NSArray alloc]initWithObjects:@1, @2, @3, @4 ,@5, @6, @7, nil];
    
    for(NSNumber *currentKey in allMyKeys)
    {
        [yArray addObject:[sumDict objectForKey:currentKey]];
    }
    
    //NSLog(@"要显示的y坐标：%@",yArray);
    return yArray;
    //showValues = [[NSArray alloc] initWithObjects: @"1",@"2",@"3",@"4",@"1",@"1",@"2", nil];
    
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
