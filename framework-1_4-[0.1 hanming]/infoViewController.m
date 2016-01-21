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
    NSLog(@"sleepLevel : %@",currentLevel.sleepLevel);
    
    //1. 判断是由哪个按钮跳转过来的
    NSArray *showValues;
    NSString *infoType = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoType"];
    Plan *currentPlan = [[Plan alloc]init];
    
    if ([infoType isEqualToString:@"sleep"]) {
        NSLog(@"sleep");
        //修改info显示的信息
        self.infoTyepImage.image = [UIImage imageNamed:@"zhe"];
        self.infoTypeText.text = @"睡眠：";
        self.infoTypeNum.text = @"999999";
        
        //xxx 取出最近一周的数据进行显示
        NSArray *originalSleepArrayFromDB = [currentPlan getSleepLevel];
        NSLog(@"Iam here %@", originalSleepArrayFromDB);
        for (int i=0; i<originalSleepArrayFromDB.count; i++) {
            NSDate * time = [originalSleepArrayFromDB[i] objectForKey:@"time"]; //X轴
            NSString * level = [originalSleepArrayFromDB[i] objectForKey:@"level"]; //y轴
            NSLog(@"detail:%@ and %@", time, level);
        }
        
        showValues = [[NSArray alloc] initWithObjects: @"1",@"2",@"3",@"4",@"1",@"1",@"2", nil];
        
        [self showBarChart:showValues];
        
    }
    else if ([infoType isEqualToString:@"pressure"])
    {
        NSLog(@"pressure");
        //修改info显示的信息
        self.infoTyepImage.image = [UIImage imageNamed:@"image"];
        self.infoTypeText.text = @"压力值：";
        
        //xxx
        self.infoTypeNum.text = @"999999";
        
        //xxx 取出最近一周的数据进行显示
        NSArray *originalSleepArrayFromDB = [currentPlan getSleepLevel];
        NSLog(@"Iam here %@", originalSleepArrayFromDB);
        for (int i=0; i<originalSleepArrayFromDB.count; i++) {
            NSDate * time = [originalSleepArrayFromDB[i] objectForKey:@"time"];
            NSString * level = [originalSleepArrayFromDB[i] objectForKey:@"level"];
            NSLog(@"detail:%@ and %@", time, level);
        }
        
        
        showValues = [[NSArray alloc] initWithObjects: @"1",@"2",@"3",@"4",@"1",@"1",@"2", nil];
        
        
        [self showBarChart:showValues];

    }
    else if ([infoType isEqualToString:@"step"])
    {
        NSLog(@"step");
        //修改info显示的信息
        self.infoTyepImage.image = [UIImage imageNamed:@"zhe"];
        self.infoTypeText.text = @"步数：";
        
        //xxx
        self.infoTypeNum.text = @"009099";
        
        //xxx 取出最近一周的数据进行显示
        showValues = [[NSArray alloc] initWithObjects: @"1",@"2",@"3",@"4",@"1",@"1",@"2", nil];
        
        
        [self showBarChart:showValues];
        

    }
    else if ([infoType isEqualToString:@"kaluli"])
    {
        NSLog(@"kaluli");
        //修改info显示的信息
        self.infoTyepImage.image = [UIImage imageNamed:@"zhe"];
        self.infoTypeText.text = @"卡路里：";
        
        //xxx
        self.infoTypeNum.text = @"009099";
        
        //xxx 取出最近一周的数据进行显示
        showValues = [[NSArray alloc] initWithObjects: @"1",@"2",@"3",@"4",@"1",@"1",@"2", nil];
        
        [self showBarChart:showValues];

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
