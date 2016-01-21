//
//  analysisViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/5.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "analysisViewController.h"
#import "mainViewController.h"
#import "static.h"
#import "Plan.h"

@interface analysisViewController ()
@property (weak, nonatomic) IBOutlet UIView *lineChartView;


@end

@implementation analysisViewController
@synthesize currentId;


//显示第三方库
- (void) showLineChart:inputYValues{
    //1. 从HISTORY里面的到currentID(这个是计划的历史完成情况的planlist中的id)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.currentId            = [defaults valueForKey:HISTORYID];
    //2. 用id得到对应的字典
    /*
     {
     NSDateFormatedFintime1 = "2016-01-21 08:10:34 +0000";
     NSDateFormatedFintime2 = "2016-01-19 08:51:16 +0000";
     NSDateFormatedFintime3 = "2016-01-19 08:51:16 +0000";
     NSDateFormatedFintime4 = "2016-01-19 08:51:16 +0000";
     NSDateFormatedTime0 = "2016-01-21 08:10:45 +0000";
     NSDateFormatedTime1 = "2016-01-22 08:00:00 +0000";
     NSDateFormatedTime2 = "2016-01-25 12:00:00 +0000";
     NSDateFormatedTime3 = "2016-01-27 18:00:00 +0000";
     NSDateFormatedTime4 = "2016-01-19 08:51:16 +0000";
     currentNumber = 0;
     done = 0;
     effect = "26.000000";
     fin1 = 0;
     fin2 = 0;
     fin3 = 0;
     fin4 = 0;
     fintime1 = "2016-01-21 16:10:34";
     fintime2 = "2016-01-19 16:51:16";
     fintime3 = "2016-01-19 16:51:16";
     fintime4 = "2016-01-19 16:51:16";
     flowerState = 0;
     have = 1;
     id = 3;
     id1 = 23;
     id2 = 75;
     id3 = 25;
     id4 = 0;
     number = 3;
     output1 = "";
     output2 = "";
     output3 = "";
     output4 = default;
     stress0 = "25.000000";
     stress1 = "25.000000";
     stress2 = 0;
     stress3 = "1.1";
     stress4 = 0;
     stress5 = "2.000000";
     time0 = "2016-01-21 16:10:45";
     time1 = "2016-01-22 16:00:00";
     time2 = "2016-01-25 20:00:00";
     time3 = "2016-01-28 02:00:00";
     time4 = "2016-01-19 16:51:16";
     type1 = 6;
     type2 = 1;
     type3 = 7;
     type4 = 0;
     }
     */
    NSMutableDictionary* dic = [[Plan new] getPlanHistoryItemByID:self.currentId];
    NSLog(@"getPlanHistoryItemByID %@",dic);
    //3. 得到上一周的压力情况，array每一个item是一个字典
    /*
    {
        NSDateFormatedTime = "2016-01-21 06:34:02 +0000";
        id = 5;
        level = "25.000000";
        time = "2016-01-21 14:34:02";
        type = 1;
    }
     */
    NSArray* array = [[Plan new] getStressLevel];
    NSLog(@"get array %@",array);
    
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, self.lineChartView.frame.size.width, self.lineChartView.frame.size.height)];
    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.backgroundColor = [UIColor clearColor];
    [self.lineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]]; //x坐标值
    self.lineChart.showCoordinateAxis = YES;
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    self.lineChart.yFixedValueMax = 100.0;//Y的最大值
    self.lineChart.yFixedValueMin = 0.0;  //Y的最小值
    
    //y轴labels
    /*
    [self.lineChart setYLabels:@[
         @"0",
         @"50",
         @"100",
         @"150",
         @"200",
         @"250",
         @"300",
         ]
     ];
     */
    
    // Line Chart #1
    NSArray * data01Array = inputYValues;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = @"压力值";
    data01.color = [UIColor blueColor];//曲线的颜色
    data01.alpha = 0.3f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    /*
    // Line Chart #2
    NSArray * data02Array = @[@0.0, @180.1, @26.4, @202.2, @126.2, @167.2, @276.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.dataTitle = @"Beta";
    data02.color = PNTwitterColor;
    data02.alpha = 0.5f;
    data02.itemCount = data02Array.count;
    data02.inflexionPointStyle = PNLineChartPointStyleCircle;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    self.lineChart.chartData = @[data01, data02];//显示两条线
     */
    
    
    self.lineChart.chartData = @[data01];//显示一条线
    //[self.lineChart strokeChart];
    //self.lineChart.delegate = self;
    
    
    [self.lineChartView addSubview:self.lineChart];
    
    
    self.lineChart.legendStyle = PNLegendItemStyleStacked;
    self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    self.lineChart.legendFontColor = [UIColor blueColor];
    
    UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
    [legend setFrame:CGRectMake(40,5 , legend.frame.size.width, legend.frame.size.width)];
    [self.lineChartView addSubview:legend];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //得到历史数据xxx
    NSArray *showValues;
    showValues = [[NSArray alloc] initWithObjects: @60., @60.1, @26.4, @20.0, @86.2, @27.2, @76.2, nil];
    
    
    
    [self showLineChart:showValues];
    
    
}

-(void) viewWillAppear:(BOOL)animated{
    [self.lineChart strokeChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnClicked:(id)sender {
    
    UIStoryboard *mainStoryboard = self.storyboard;
    mainViewController *SVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"mainViewController"];
    //设置翻页效果
    
    [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController: SVC animated:NO completion:nil];
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
