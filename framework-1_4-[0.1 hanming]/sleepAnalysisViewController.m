//
//  sleepAnalysisViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/2/22.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "sleepAnalysisViewController.h"

@interface sleepAnalysisViewController ()
@property (weak, nonatomic) IBOutlet UIView *pieChartView;

@end

@implementation sleepAnalysisViewController

//显示第三方库
- (void) showPieChart{
    
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNLightBlue description:@"清醒"],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNFreshGreen description:@"深睡"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNDeepGreen description:@"浅睡"],
                       ];
    
    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, self.pieChartView.frame.size.width, self.pieChartView.frame.size.height) items:items];
    self.pieChart.descriptionTextColor = [UIColor whiteColor];
    self.pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:20.0];
    self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
    self.pieChart.showAbsoluteValues = NO;
    self.pieChart.showOnlyValues = NO;
    [self.pieChart strokeChart];
    
    
    self.pieChart.legendStyle = PNLegendItemStyleStacked;
    self.pieChart.legendFont = [UIFont boldSystemFontOfSize:20.0f];
    
    UIView *legend = [self.pieChart getLegendWithMaxWidth:200];
    [legend setFrame:CGRectMake(90, 350, legend.frame.size.width, legend.frame.size.height)];
    [self.pieChartView addSubview:legend];
    
    [self.pieChartView addSubview:self.pieChart];

}

- (void)viewDidAppear:(BOOL)animated{
    [self.pieChart strokeChart];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showPieChart];
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
