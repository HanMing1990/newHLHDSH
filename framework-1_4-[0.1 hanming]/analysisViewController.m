//
//  analysisViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/5.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "analysisViewController.h"
#import "mainViewController.h"

@interface analysisViewController ()
@property (weak, nonatomic) IBOutlet UIView *lineChartView;


@end

@implementation analysisViewController



//显示第三方库
- (void) showLineChart:inputYValues{
    
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, self.lineChartView.frame.size.width, self.lineChartView.frame.size.height)];
    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.backgroundColor = [UIColor clearColor];
    [self.lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5",@"SEP 6",@"SEP 7"]];
    self.lineChart.showCoordinateAxis = YES;
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    self.lineChart.yFixedValueMax = 300.0;
    self.lineChart.yFixedValueMin = 0.0;
    
    [self.lineChart setYLabels:@[
                                 @"0 min",
                                 @"50 min",
                                 @"100 min",
                                 @"150 min",
                                 @"200 min",
                                 @"250 min",
                                 @"300 min",
                                 ]
     ];
    // Line Chart #1
    NSArray * data01Array = inputYValues;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = @"Alpha";
    data01.color = PNFreshGreen;
    data01.alpha = 0.3f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
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
    
    self.lineChart.chartData = @[data01, data02];
    //[self.lineChart strokeChart];
    //self.lineChart.delegate = self;
    
    
    [self.lineChartView addSubview:self.lineChart];
    
    self.lineChart.legendStyle = PNLegendItemStyleStacked;
    self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    self.lineChart.legendFontColor = [UIColor redColor];
    
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
