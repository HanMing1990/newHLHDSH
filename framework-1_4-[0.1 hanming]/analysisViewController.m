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
#import "CurrentPlan.h"

@interface analysisViewController ()
@property (weak, nonatomic) IBOutlet UIView *lineChartView;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end

@implementation analysisViewController
@synthesize currentId;


//显示第三方库
- (void) showLineChart{
    //1. 从HhaodatISTORY里面的到currentID(这个是计划的历史完成情况的planlist中的id)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.currentId = [defaults valueForKey:HISTORYID];
    //self.currentId = [NSNumber numberWithInt:1];//调试的时候用这个id
    NSLog(@"current id is %@", self.currentId);
    //2. 用id得到对应的字典
    NSMutableArray* showDataArray = [[Plan new] getPlanHistoryItemByID:self.currentId];
    NSLog(@"xxxxxxxxxgetPlanHistoryItemByID %@",showDataArray);
    
    //3. 得到这个病的压力变化情况，array每一个item是一个字典，以下是个栗子
    /*
    {
        NSDateFormatedTime = "2016-01-21 06:34:02 +0000";
        fin = 0;  //只有在fin为1的时候显示此点
        id = 5;
        level = "25.000000";
        type = 1;
    }
     */
    
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, self.lineChartView.frame.size.width*0.8, self.lineChartView.frame.size.height*0.8)];
    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.backgroundColor = [UIColor clearColor];
    
    //[self.lineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5"]];
    
    
    //-----------------------------------------------------------------
    //x坐标值
    NSMutableArray * XLabels = [self getXvaluesForLineChart:showDataArray];
    NSLog(@"ok the x is: %@", XLabels);
    
    
    [self.lineChart setXLabels:XLabels];
    //-----------------------------------------------------------------
    
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
    //-----------------------------------------------------------------
    //y坐标值
    NSMutableArray * data01Array = [self getYvaluesForLineChart:showDataArray];
    NSLog(@"ok the y is: %@",data01Array);
    //-----------------------------------------------------------------
    
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = @"压力值";
    data01.color = [UIColor blueColor];//曲线的颜色
    data01.alpha = 0.3f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    
    //准备显示在折线上的文字
    //Item * item = [[Plan new] getItemById:[NSNumber numberWithInt:1]];//plan中取id, 根据id取item,根据item取info
    //item.info；//要显示的值
    
    
    //-----------------------------------------------------------------
    // 在线上显示文字（默认显示数字，显示文字的话要修改PNLineChart的类函数）
    //NSMutableArray * textArraySideLine = [NSMutableArray new];
    NSMutableArray * textArrayOriginal = [NSMutableArray new];
    
    unsigned long number = showDataArray.count;
    Plan *plan = [Plan new];
    for (int i=0; i<number; i++) {
        NSMutableDictionary *currentDict = showDataArray[i];
        if([[currentDict objectForKey:@"fin"] integerValue]==1){
        NSNumber* idx = [currentDict objectForKey:@"id"];
        Item *itemx = [plan getItemById:idx];
        if(itemx.info){
            [textArrayOriginal addObject:itemx.info];
        }
        else{
            [textArrayOriginal addObject:@""];
        }
        }
    }
    /*以下是老版本，一个疗程的
    NSNumber* id1 = [dic objectForKey:@"id1"];
    NSNumber* id2 = [dic objectForKey:@"id2"];
    NSNumber* id3 = [dic objectForKey:@"id3"];
    NSNumber* id4 = [dic objectForKey:@"id4"];
    
    Plan *plan = [Plan new];
    Item *item1 =[plan getItemById:id1];
    Item *item2 =[plan getItemById:id2];
    Item *item3 =[plan getItemById:id3];
    Item *item4 =[plan getItemById:id4];
    if (item1.info) {
        [textArrayOriginal addObject:item1.info];
    }
    else{
        [textArrayOriginal addObject: @""];
    }
    if (item2.info) {
        [textArrayOriginal addObject:item2.info];
    }
    else{
        [textArrayOriginal addObject: @""];
    }
    if (item3.info) {
        [textArrayOriginal addObject:item3.info];
    }
    else{
        [textArrayOriginal addObject: @""];
    }
    if (item4.info) {
        [textArrayOriginal addObject:item4.info];
    }
    else{
        [textArrayOriginal addObject: @""];
    }
    [textArraySideLine addObject: @"计划开始前"];//计划开始前的状态
    
    
    for (int i=0; i<[[dic objectForKey:@"number"] intValue]; i++) {
        NSString *currentString = [textArrayOriginal objectAtIndex:i];
        [textArraySideLine addObject:currentString];
    }
    [textArraySideLine addObject: @"计划结束3天后"];//计划结束3天后的状况
    self.lineChart.textArraySideLine = textArraySideLine;
     
     */
    
    self.lineChart.textArraySideLine = textArrayOriginal;
    //-----------------------------------------------------------------
    
    // 这句话的作用是设置pointlabel的文本
    data01.showPointLabel = YES;
    
    //这个文本的格式可在createPointLabelFor函数中重写，当然可以设置如下的字段
    //data01.pointLabelFont =
    //data01.pointLabelFormat =
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY: yValue];
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
    //NSArray *showValues;
    //showValues = [[NSArray alloc] initWithObjects: @60., @60.1, @26.4, @20.0, @86.2, @27.2, @76.2, nil];
    
    //得到一周的压力历史数据（舍弃）
    /*
    NSArray* originalArrayFromDB = [[Plan new] getStressLevel];
    NSMutableArray *showValues = [NSMutableArray new];
    showValues = [self getArrayToDisplayinInfoVC: originalArrayFromDB];
    */
    
    //-------------------------------------------------------------------------
    //-1. 使用实现滚动
    [self.myScrollView addSubview:self.lineChartView];
    // 设置UIScrollView的滚动范围（内容大小）
    self.myScrollView.contentSize = CGSizeMake(1500, 0);//只设置宽度，这样就只能左右滑
    
    // 隐藏水平滚动条
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.showsVerticalScrollIndicator = NO;
    
    // 增加额外的滚动区域（逆时针，上、左、下、右）
    // top  left  bottom  right
    self.myScrollView.contentInset = UIEdgeInsetsMake(40, 40, 100, 100);
    
    
    [self showLineChart];
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
 id = 3; //plan的id
 
 id1 = 23; //item的id
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

/*这个版本是输出一个疗程的
- (NSMutableArray *) getYvaluesForLineChart: (NSMutableDictionary*) planHistoryDict{
    //0. 得到一共有几个item
    NSNumber* number = [planHistoryDict objectForKey:@"number"];
    
    //2. 得到stress的值
    NSString *stress0 = [planHistoryDict objectForKey:@"stress0"];
    NSString *stress1 = [planHistoryDict objectForKey:@"stress1"];
    NSString *stress2 = [planHistoryDict objectForKey:@"stress2"];
    NSString *stress3 = [planHistoryDict objectForKey:@"stress3"];
    NSString *stress4 = [planHistoryDict objectForKey:@"stress4"];
    NSString *stress5 = [planHistoryDict objectForKey:@"stress5"];
    
    //3. 将stress转化成fLoat
    NSNumber *stressFloat0 = [NSNumber numberWithFloat:[stress0 floatValue]];
    NSNumber *stressFloat1 = [NSNumber numberWithFloat:[stress1 floatValue]];
    NSNumber *stressFloat2 = [NSNumber numberWithFloat:[stress2 floatValue]];
    NSNumber *stressFloat3 = [NSNumber numberWithFloat:[stress3 floatValue]];
    NSNumber *stressFloat4 = [NSNumber numberWithFloat:[stress4 floatValue]];
    NSNumber *stressFloat5 = [NSNumber numberWithFloat:[stress5 floatValue]];
    
    //4. 截取一部分,0 5肯定在，一个是其实压力值，一个是结束压力值
    NSArray *YValuesOrigin = [[NSArray alloc]initWithObjects:stressFloat0, stressFloat1, stressFloat2, stressFloat3, stressFloat4, nil];
    NSMutableArray *YValues = [NSMutableArray arrayWithArray: [YValuesOrigin subarrayWithRange:NSMakeRange(0, [number intValue]+1)]];
    [YValues addObject:stressFloat5];
    
    return YValues;
}
 */


- (NSMutableArray *) getYvaluesForLineChart: (NSMutableArray*) planHistoryArray{
    /*以下是一个输入的栗子
     (
     {
     NSDateFormatedTime = "2016-02-24 02:10:46 +0000";
     fin = 0;
     id = 13;
     level = 0;
     type = 1;
     },
     {
     NSDateFormatedTime = "2016-02-24 02:10:46 +0000";
     fin = 0;
     id = 54;
     level = 0;
     type = 1;
     },
     {
     NSDateFormatedTime = "2016-02-24 02:10:46 +0000";
     fin = 0;
     id = 25;
     level = 0;
     type = 7;
     },
     {
     NSDateFormatedTime = "2016-02-24 02:10:46 +0000";
     fin = 0;
     id = 23;
     level = 0;//
     type = 6;
     }
     )
     */
    
    NSMutableArray *YValues = [NSMutableArray new];
    //0. 得到一共有几个item
    unsigned long number =  planHistoryArray.count;
    for (int i=0; i<number; i++) {
        NSMutableDictionary *currentDict = planHistoryArray[i];
        if([[currentDict objectForKey:@"fin"] integerValue]==1){
        //2. 得到stress的值
        NSString *currentStress = [currentDict objectForKey: @"level"];
        //3. 将stress转化成fLoat
        NSNumber *stressFloat = [NSNumber numberWithFloat:[currentStress floatValue]];
        [YValues addObject: stressFloat];
        }
    }
    return YValues;
    
}


/*这个版本是输出一个疗程的
- (NSMutableArray *) getXvaluesForLineChart: (NSMutableDictionary*) planHistoryDict{
    //0. 得到一共有几个item
    NSNumber* number = [planHistoryDict objectForKey:@"number"];
    
    //1. 得到时间
    NSDate *time0d = [planHistoryDict objectForKey:@"NSDateFormatedTime0"];
    NSDate *time1d = [planHistoryDict objectForKey:@"NSDateFormatedTime1"];
    NSDate *time2d = [planHistoryDict objectForKey:@"NSDateFormatedTime2"];
    NSDate *time3d = [planHistoryDict objectForKey:@"NSDateFormatedTime3"];
    NSDate *time4d = [planHistoryDict objectForKey:@"NSDateFormatedTime4"];
    NSString *lasttimename = [NSString stringWithFormat:@"NSDateFormatedTime%@", number];
    NSDate *time5d =[[planHistoryDict objectForKey:lasttimename] dateByAddingTimeInterval:3*60*60*24];
    
    //2. 转换成字符串类型
    NSString * time0 = [[NSString stringWithFormat:@"%@", time0d]substringWithRange:NSMakeRange(5, 5)];//截取月日
    NSString * time1 = [[NSString stringWithFormat:@"%@", time1d]substringWithRange:NSMakeRange(5, 5)];
    NSString * time2 = [[NSString stringWithFormat:@"%@", time2d]substringWithRange:NSMakeRange(5, 5)];
    NSString * time3 = [[NSString stringWithFormat:@"%@", time3d]substringWithRange:NSMakeRange(5, 5)];
    NSString * time4 = [[NSString stringWithFormat:@"%@", time4d]substringWithRange:NSMakeRange(5, 5)];
    NSString * time5 = [[NSString stringWithFormat:@"%@", time5d]substringWithRange:NSMakeRange(5, 5)];
    
    //4. 截取一部分,0 5肯定在，一个是其实压力值，一个是结束压力值
    NSArray *XValuesOrigin = [[NSArray alloc]initWithObjects:time0, time1, time2, time3, time4, nil];
    NSMutableArray *XValues = [NSMutableArray arrayWithArray: [XValuesOrigin subarrayWithRange:NSMakeRange(0, [number intValue]+1)]];
    [XValues addObject:time5];
    return XValues;
}*/


- (NSMutableArray *) getXvaluesForLineChart: (NSMutableArray*) planHistoryArray{
    /*以下是一个输入的栗子
     (
     {
     NSDateFormatedTime = "2016-02-24 02:10:46 +0000";
     fin = 0;
     id = 13;
     level = 0;
     type = 1;
     },
     {
     NSDateFormatedTime = "2016-02-24 02:10:46 +0000";
     fin = 0;
     id = 54;
     level = 0;
     type = 1;
     },
     {
     NSDateFormatedTime = "2016-02-24 02:10:46 +0000";
     fin = 0;
     id = 25;
     level = 0;
     type = 7;
     },
     {
     NSDateFormatedTime = "2016-02-24 02:10:46 +0000";
     fin = 0;
     id = 23;
     level = 0;
     type = 6;
     }
     )
     */
    
    NSMutableArray *XValues = [NSMutableArray new];
    
    //0. 得到一共有几个item
    unsigned long number =  planHistoryArray.count;
    for (int i=0; i<number; i++) {
        NSMutableDictionary *currentDict = planHistoryArray[i];
        if([[currentDict objectForKey:@"fin"] integerValue]==1){
        //1. 得到时间
        NSDate *currentTime = [currentDict objectForKey:@"NSDateFormatedTime"];
        
        //2. 转换成字符串类型
        NSString * currentTimeString = [[NSString stringWithFormat:@"%@", currentTime]substringWithRange:NSMakeRange(5, 5)];
        
        [XValues addObject:currentTimeString];
        }
    }
    return XValues;
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
