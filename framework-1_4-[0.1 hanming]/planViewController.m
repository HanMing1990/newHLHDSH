//
//  planViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/5.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "planViewController.h"
#import "exe1ViewController.h"
#import "exe2ViewController.h"
#import "exe3ViewController.h"
#import "exe4ViewController.h"
#import "exe5ViewController.h"
#import "exe6ViewController.h"
#import "analysisViewController.h"

#import "CurrentPlan.h"


@interface planViewController ()
@property (weak, nonatomic) IBOutlet UIButton *plan1Btn;
@property (weak, nonatomic) IBOutlet UIButton *plan2Btn;
@property (weak, nonatomic) IBOutlet UIButton *plan3Btn;
@property (weak, nonatomic) IBOutlet UIButton *plan4Btn;
@property (weak, nonatomic) IBOutlet UIButton *plan5Btn;
@property (weak, nonatomic) IBOutlet UIButton *plan6Btn;
@property (weak, nonatomic) IBOutlet UIButton *plan7Btn;
@property (weak, nonatomic) IBOutlet UIButton *plan8Btn;
@property (weak, nonatomic) IBOutlet UIButton *plan9Btn;



@property (weak, nonatomic) IBOutlet UILabel *plan1Date;
@property (weak, nonatomic) IBOutlet UILabel *plan2Date;
@property (weak, nonatomic) IBOutlet UILabel *plan3Date;
@property (weak, nonatomic) IBOutlet UILabel *plan4Date;
@property (weak, nonatomic) IBOutlet UILabel *plan5Date;
@property (weak, nonatomic) IBOutlet UILabel *plan6Date;
@property (weak, nonatomic) IBOutlet UILabel *plan7Date;
@property (weak, nonatomic) IBOutlet UILabel *plan8Date;
@property (weak, nonatomic) IBOutlet UILabel *plan9Date;





@property (weak, nonatomic) IBOutlet UILabel *plan1Text;
@property (weak, nonatomic) IBOutlet UILabel *plan2Text;
@property (weak, nonatomic) IBOutlet UILabel *plan4Text;
@property (weak, nonatomic) IBOutlet UILabel *plan3Text;
@property (weak, nonatomic) IBOutlet UILabel *plan5Text;
@property (weak, nonatomic) IBOutlet UILabel *plan6Text;
@property (weak, nonatomic) IBOutlet UILabel *plan7Text;
@property (weak, nonatomic) IBOutlet UILabel *plan8Text;
@property (weak, nonatomic) IBOutlet UILabel *plan9Text;



@property (weak, nonatomic) IBOutlet UIImageView *flowerImage;

//@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;//计划的显示窗口（小）
//@property (weak, nonatomic) IBOutlet UIView *planCellView;//计划的内容（大）

@property int plan1Type; // 跳转所用的交互类型，由item的inte决定
@property int plan2Type;
@property int plan3Type;
@property int plan4Type;

@property int plan1Sour; // 显示的类别，比如是感恩还是运动，由item的sour决定
@property int plan2Sour;
@property int plan3Sour;
@property int plan4Sour;

@property CurrentPlan* currentPlan;
@end

@implementation planViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //-------------------------------------------------------------------------
    //-1. 使用实现滚动
    /*
    [self.myScrollView addSubview:self.planCellView];
    // 设置UIScrollView的滚动范围（内容大小）
    self.myScrollView.contentSize = CGSizeMake(0, 1500);//只设置长度，这样就只能左右滑
    
    // 隐藏水平滚动条
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.showsVerticalScrollIndicator = NO;
    
    
    // 增加额外的滚动区域（逆时针，上、左、下、右）
    // top  left  bottom  right
    self.myScrollView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
    */
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
    fmt.dateFormat = @"MM月dd日";
    //NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"America/New_York"];
    //[fmt setTimeZone:timeZone];
    
    
    //0. 计算这九个图标中哪些需要显示计划，哪些显示普通的日期
    //得到系统当前的时间
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:60*60*8];
    NSLog(@"current date is %@", currentDate);
    //用来记录该图标是否已经被用来显示计划，False是没有，True是已用作显示计划
    bool flags[9];
    for (int i=0; i<9; i++) {
        flags[i] = false;
    }
    
    //NSMutableArray *showFlags = [[NSArray alloc] initWithObjects:false, false, false, false, false, false, false, false, false, nil];
    
    NSArray *planxDate = [[NSArray alloc] initWithObjects: self.plan1Date, self.plan2Date, self.plan3Date, self.plan4Date, self.plan5Date, self.plan6Date, self.plan7Date, self.plan8Date, self.plan9Date, nil];
    
    NSArray *planxText = [[NSArray alloc] initWithObjects:self.plan1Text, self.plan2Text, self.plan3Text, self.plan4Text, self.plan5Text, self.plan6Text, self.plan7Text, self.plan8Text, self.plan9Text, nil];
    
    NSArray *planxBtn = [[NSArray alloc] initWithObjects:self.plan1Btn, self.plan2Btn,self.plan3Btn,self.plan4Btn,self.plan5Btn,self.plan6Btn,self.plan7Btn,self.plan8Btn,self.plan9Btn,nil];
    
    
    //NSArray *planxType = [[NSArray alloc] initWithaObjects:self.plan1Type, false, false, false, false, false, false, false, false, nil];
    //NSArray *planxSour = [[NSArray alloc] initWithObjects:false, false, false, false, false, false, false, false, false, nil];
    //1. 修改四个plan的显示信息
    //1.1 plan1
    if(self.currentPlan.number > 0){
        //计算应该放在哪个格子中
        NSTimeInterval timeInterval = [self.currentPlan.time1 timeIntervalSinceDate:currentDate];
        int daysNumFromToday;
        daysNumFromToday= (int)timeInterval/(60*60*24); //距离今天多久
        NSLog(@"cell is filled in:%i", daysNumFromToday);
        
        //self.plan1Date.text = [fmt stringFromDate:self.currentPlan.time1];
        //self.plan1Text.text = self.currentPlan.info1;
        flags[daysNumFromToday] = true;//这个格子被占用了
        
        UILabel *currentPlanDate = planxDate[daysNumFromToday];
        UILabel *currentPlanText = planxText[daysNumFromToday];
        UIButton *currentBtn = planxBtn[daysNumFromToday];
        currentPlanDate.text = [fmt stringFromDate:self.currentPlan.time1];
        currentPlanText.text = self.currentPlan.info1;
        
        self.plan1Type = self.currentPlan.type1.intValue;
        self.plan1Sour = self.currentPlan.sour1.intValue;
        NSString *plan1BtnImageName;
        switch (self.plan1Sour) {
            case 0:
                plan1BtnImageName = PLANSOURCE0;
                break;
            case 1:
                plan1BtnImageName = PLANSOURCE1;
                break;
            case 2:
                plan1BtnImageName = PLANSOURCE2;
                break;
            case 3:
                plan1BtnImageName = PLANSOURCE3;
                break;
            case 4:
                plan1BtnImageName = PLANSOURCE4;
                break;
            case 5:
                plan1BtnImageName = PLANSOURCE5;
                break;
            case 6:
                plan1BtnImageName = PLANSOURCE6;
                break;
            case 7:
                plan1BtnImageName = PLANSOURCE7;
                break;
            case 8:
                plan1BtnImageName = PLANSOURCE8;
                break;
            case 9:
                plan1BtnImageName = PLANSOURCE9;
                break;
            case 10:
                plan1BtnImageName = PLANSOURCE10;
                break;
            default:
                plan1BtnImageName = PLANSOURCE0;
                break;
        }
        [currentBtn setImage:[UIImage imageNamed:plan1BtnImageName] forState:UIControlStateNormal];
        
    }else{
       //不显示
        /*
        self.plan1Btn.hidden = YES;
        self.plan1Date.hidden = YES;
        self.plan1Text.hidden = YES;
         */
        
    }
    //1.2 plan2
    if(self.currentPlan.number.intValue > 1){
        //计算应该放在哪个格子中
        NSTimeInterval timeInterval = [self.currentPlan.time2 timeIntervalSinceDate:currentDate];//XXXXXXXXX
        int daysNumFromToday;
        daysNumFromToday= (int)timeInterval/(60*60*24); //距离今天多久
        NSLog(@"cell is filled in:%i", daysNumFromToday);
        
        //self.plan1Date.text = [fmt stringFromDate:self.currentPlan.time1];
        //self.plan1Text.text = self.currentPlan.info1;
        flags[daysNumFromToday] = true;//这个格子被占用了
        
        UILabel *currentPlanDate = planxDate[daysNumFromToday];
        UILabel *currentPlanText = planxText[daysNumFromToday];
        UIButton *currentBtn = planxBtn[daysNumFromToday];
        currentPlanDate.text = [fmt stringFromDate:self.currentPlan.time2];//XXXXXXXXX
        currentPlanText.text = self.currentPlan.info2;//XXXXXXXXX
        
        self.plan2Type = self.currentPlan.type2.intValue;//XXXXXXXXX
        self.plan2Sour = self.currentPlan.sour2.intValue;//XXXXXXXXX
        NSString *plan1BtnImageName;
        switch (self.plan2Sour) {
            case 0:
                plan1BtnImageName = PLANSOURCE0;
                break;
            case 1:
                plan1BtnImageName = PLANSOURCE1;
                break;
            case 2:
                plan1BtnImageName = PLANSOURCE2;
                break;
            case 3:
                plan1BtnImageName = PLANSOURCE3;
                break;
            case 4:
                plan1BtnImageName = PLANSOURCE4;
                break;
            case 5:
                plan1BtnImageName = PLANSOURCE5;
                break;
            case 6:
                plan1BtnImageName = PLANSOURCE6;
                break;
            case 7:
                plan1BtnImageName = PLANSOURCE7;
                break;
            case 8:
                plan1BtnImageName = PLANSOURCE8;
                break;
            case 9:
                plan1BtnImageName = PLANSOURCE9;
                break;
            case 10:
                plan1BtnImageName = PLANSOURCE10;
                break;
            default:
                plan1BtnImageName = PLANSOURCE0;
                break;
        }
        [currentBtn setImage:[UIImage imageNamed:plan1BtnImageName] forState:UIControlStateNormal];
    }else{
        //不显示
        /*
        self.plan2Btn.hidden = YES;
        self.plan2Date.hidden = YES;
        self.plan2Text.hidden = YES;
         */
    }
    //1.3 plan3
    if(self.currentPlan.number.intValue > 2){
        //计算应该放在哪个格子中
        NSTimeInterval timeInterval = [self.currentPlan.time3 timeIntervalSinceDate:currentDate];//XXXXXXXXX
        int daysNumFromToday;
        daysNumFromToday= (int)timeInterval/(60*60*24); //距离今天多久
        NSLog(@"cell is filled in:%i", daysNumFromToday);
        
        //self.plan1Date.text = [fmt stringFromDate:self.currentPlan.time1];
        //self.plan1Text.text = self.currentPlan.info1;
        flags[daysNumFromToday] = true;//这个格子被占用了
        
        UILabel *currentPlanDate = planxDate[daysNumFromToday];
        UILabel *currentPlanText = planxText[daysNumFromToday];
        UIButton *currentBtn = planxBtn[daysNumFromToday];
        currentPlanDate.text = [fmt stringFromDate:self.currentPlan.time3];//XXXXXXXXX
        currentPlanText.text = self.currentPlan.info3;//XXXXXXXXX
        
        self.plan3Type = self.currentPlan.type3.intValue;//XXXXXXXXX
        self.plan3Sour = self.currentPlan.sour3.intValue;//XXXXXXXXX
        NSString *plan1BtnImageName;
        switch (self.plan3Sour) {
            case 0:
                plan1BtnImageName = PLANSOURCE0;
                break;
            case 1:
                plan1BtnImageName = PLANSOURCE1;
                break;
            case 2:
                plan1BtnImageName = PLANSOURCE2;
                break;
            case 3:
                plan1BtnImageName = PLANSOURCE3;
                break;
            case 4:
                plan1BtnImageName = PLANSOURCE4;
                break;
            case 5:
                plan1BtnImageName = PLANSOURCE5;
                break;
            case 6:
                plan1BtnImageName = PLANSOURCE6;
                break;
            case 7:
                plan1BtnImageName = PLANSOURCE7;
                break;
            case 8:
                plan1BtnImageName = PLANSOURCE8;
                break;
            case 9:
                plan1BtnImageName = PLANSOURCE9;
                break;
            case 10:
                plan1BtnImageName = PLANSOURCE10;
                break;
            default:
                plan1BtnImageName = PLANSOURCE0;
                break;
        }
        [currentBtn setImage:[UIImage imageNamed:plan1BtnImageName] forState:UIControlStateNormal];
    }else{
        //不显示
        /*
        self.plan3Btn.hidden = YES;
        self.plan3Date.hidden = YES;
        self.plan3Text.hidden = YES;
         */
    }
    //1.4 plan4
    if(self.currentPlan.number.intValue > 3){
        //计算应该放在哪个格子中
        NSTimeInterval timeInterval = [self.currentPlan.time4 timeIntervalSinceDate:currentDate];//XXXXXXXXX
        int daysNumFromToday;
        daysNumFromToday= (int)timeInterval/(60*60*24); //距离今天多久
        NSLog(@"cell is filled in:%i", daysNumFromToday);
        
        //self.plan1Date.text = [fmt stringFromDate:self.currentPlan.time1];
        //self.plan1Text.text = self.currentPlan.info1;
        flags[daysNumFromToday] = true;//这个格子被占用了
        
        UILabel *currentPlanDate = planxDate[daysNumFromToday];
        UILabel *currentPlanText = planxText[daysNumFromToday];
        UIButton *currentBtn = planxBtn[daysNumFromToday];
        currentPlanDate.text = [fmt stringFromDate:self.currentPlan.time4];//XXXXXXXXX
        currentPlanText.text = self.currentPlan.info4;//XXXXXXXXX
        
        self.plan4Type = self.currentPlan.type4.intValue;//XXXXXXXXX
        self.plan4Sour = self.currentPlan.sour4.intValue;//XXXXXXXXX
        NSString *plan1BtnImageName;
        switch (self.plan4Sour) {
            case 0:
                plan1BtnImageName = PLANSOURCE0;
                break;
            case 1:
                plan1BtnImageName = PLANSOURCE1;
                break;
            case 2:
                plan1BtnImageName = PLANSOURCE2;
                break;
            case 3:
                plan1BtnImageName = PLANSOURCE3;
                break;
            case 4:
                plan1BtnImageName = PLANSOURCE4;
                break;
            case 5:
                plan1BtnImageName = PLANSOURCE5;
                break;
            case 6:
                plan1BtnImageName = PLANSOURCE6;
                break;
            case 7:
                plan1BtnImageName = PLANSOURCE7;
                break;
            case 8:
                plan1BtnImageName = PLANSOURCE8;
                break;
            case 9:
                plan1BtnImageName = PLANSOURCE9;
                break;
            case 10:
                plan1BtnImageName = PLANSOURCE10;
                break;
            default:
                plan1BtnImageName = PLANSOURCE0;
                break;
        }
        [currentBtn setImage:[UIImage imageNamed:plan1BtnImageName] forState:UIControlStateNormal];
    }else{
        //不显示
        /*
        self.plan4Btn.hidden = YES;
        self.plan4Date.hidden = YES;
        self.plan4Text.hidden = YES;
         */
    }
    
    //其余的不显示
    for (int i=0; i<9; i++) {
        if (!flags[i]) {
            UILabel *currentPlanDate = planxDate[i];
            UILabel *currentPlanText = planxText[i];
            UIButton *currentBtn = planxBtn[i];
            
            //currentPlanText.hidden = YES;
            
        }
    }
    
    
    
    //2. 右上角花的状态（同mainVC中的花的状态）
    //2.1 根据历史完成情况获取花的状态名字
    
    int flowerState = [[[NSUserDefaults standardUserDefaults] valueForKey:@"flowerState"] intValue];
    
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
        case 4:
            flowerImageName = @"dahua";
            break;
        case 5:
            flowerImageName = @"dahua";
            break;
        case 6:
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
    NSLog(@"what??");
    if (self.currentPlan.number.intValue > 0) {
        //记录当前plan的信息，以备后面执行界面显示
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSTimeInterval interval = [self.currentPlan.time1 timeIntervalSinceNow];
        NSLog(@"time interval to be judged: %i",(int)interval / 3600);
        if (interval > 24*3600) {          //一天以后
            [defaults setObject:[NSNumber numberWithInt:2] forKey:PLANSTATE];
        }else if (interval > - 24 * 3600){ //前后一天之内
            [defaults setObject:[NSNumber numberWithInt:1] forKey:PLANSTATE];
        }else{                             //一天之前
            [defaults setObject:[NSNumber numberWithInt:0] forKey:PLANSTATE];
        }
        if (self.currentPlan.fin1.boolValue == YES) {
            [defaults setObject:[NSNumber numberWithInt:0] forKey:PLANSTATE];
        }
        [defaults setObject: self.currentPlan.id1      forKey:PLANID];
        [defaults setObject: self.currentPlan.time1    forKey:PLANDATE];
        [defaults setObject: self.currentPlan.content1 forKey:PLANTEXT];
        [defaults setObject: self.currentPlan.info1    forKey:PLANINFO];
        [defaults setObject: self.currentPlan.sour1    forKey:PLANTYPE];
        [defaults setObject: self.currentPlan.fintime1 forKey:PLANFINTIME];
        [defaults setObject: self.currentPlan.output1  forKey:PLANOUTPUT];
        [defaults setObject: self.currentPlan.fin1     forKey:PLANFIN];
        [defaults synchronize];
        //跳转到执行页面
        [self presentExeVC:self.plan1Type];
    }else{
        //do nothing because don't have this item
        NSLog(@"hello~~~~");
    }
}


- (IBAction)plan2BtnClicked:(id)sender {
    if (self.currentPlan.number.intValue > 1) {
        //记录当前plan的信息，以备后面执行界面显示
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSTimeInterval interval = [self.currentPlan.time2 timeIntervalSinceNow];
        NSLog(@"time interval to be judged: %i",(int)interval / 3600);
        if (interval > 24*3600) {          //一天以后
            [defaults setObject:[NSNumber numberWithInt:2] forKey:PLANSTATE];
        }else if (interval > - 24 * 3600){ //前后一天之内
            [defaults setObject:[NSNumber numberWithInt:1] forKey:PLANSTATE];
        }else{                             //一天之前
            [defaults setObject:[NSNumber numberWithInt:0] forKey:PLANSTATE];
        }
        if (self.currentPlan.fin2.boolValue == YES) {
            [defaults setObject:[NSNumber numberWithInt:0] forKey:PLANSTATE];
        }
        [defaults setObject: self.currentPlan.id2      forKey:PLANID];
        [defaults setObject: self.currentPlan.time2    forKey:PLANDATE];
        [defaults setObject: self.currentPlan.content2 forKey:PLANTEXT];
        [defaults setObject: self.currentPlan.info2    forKey:PLANINFO];
        [defaults setObject: self.currentPlan.sour2    forKey:PLANTYPE];
        [defaults setObject: self.currentPlan.fintime2 forKey:PLANFINTIME];
        [defaults setObject: self.currentPlan.output2  forKey:PLANOUTPUT];
        [defaults setObject: self.currentPlan.fin2     forKey:PLANFIN];
        [defaults synchronize];
        //跳转到执行页面
        [self presentExeVC:self.plan2Type];
    }else{
        //do nothing because don't have this item
    }
}


- (IBAction)plan3BtnClicked:(id)sender {
    if (self.currentPlan.number.intValue > 2) {
        //记录当前plan的信息，以备后面执行界面显示
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSTimeInterval interval = [self.currentPlan.time3 timeIntervalSinceNow];
        NSLog(@"time interval to be judged: %i",(int)interval / 3600);
        if (interval > 24*3600) {          //一天以后
            [defaults setObject:[NSNumber numberWithInt:2] forKey:PLANSTATE];
        }else if (interval > - 24 * 3600){ //前后一天之内
            [defaults setObject:[NSNumber numberWithInt:1] forKey:PLANSTATE];
        }else{                             //一天之前
            [defaults setObject:[NSNumber numberWithInt:0] forKey:PLANSTATE];
        }
        if (self.currentPlan.fin3.boolValue == YES) {
            [defaults setObject:[NSNumber numberWithInt:0] forKey:PLANSTATE];
        }
        [defaults setObject: self.currentPlan.id3      forKey:PLANID];
        [defaults setObject: self.currentPlan.time3    forKey:PLANDATE];
        [defaults setObject: self.currentPlan.content3 forKey:PLANTEXT];
        [defaults setObject: self.currentPlan.info3    forKey:PLANINFO];
        [defaults setObject: self.currentPlan.sour3    forKey:PLANTYPE];
        [defaults setObject: self.currentPlan.fintime3 forKey:PLANFINTIME];
        [defaults setObject: self.currentPlan.output3  forKey:PLANOUTPUT];
        [defaults setObject: self.currentPlan.fin3     forKey:PLANFIN];
        [defaults synchronize];
        //跳转到执行页面
        [self presentExeVC:self.plan3Type];
    }else{
        //do nothing because don't have this item
    }
}

- (IBAction)plan4BtnClicked:(id)sender {
    if (self.currentPlan.number.intValue > 3) {
        //记录当前plan的信息，以备后面执行界面显示
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSTimeInterval interval = [self.currentPlan.time4 timeIntervalSinceNow];
        NSLog(@"time interval to be judged: %i",(int)interval / 3600);
        if (interval > 24*3600) {          //一天以后
            [defaults setObject:[NSNumber numberWithInt:2] forKey:PLANSTATE];
        }else if (interval > - 24 * 3600){ //前后一天之内
            [defaults setObject:[NSNumber numberWithInt:1] forKey:PLANSTATE];
        }else{                             //一天之前
            [defaults setObject:[NSNumber numberWithInt:0] forKey:PLANSTATE];
        }
        if (self.currentPlan.fin4.boolValue == YES) {
            [defaults setObject:[NSNumber numberWithInt:0] forKey:PLANSTATE];
        }
        [defaults setObject: self.currentPlan.id4      forKey:PLANID];
        [defaults setObject: self.currentPlan.time4    forKey:PLANDATE];
        [defaults setObject: self.currentPlan.content4 forKey:PLANTEXT];
        [defaults setObject: self.currentPlan.info4    forKey:PLANINFO];
        [defaults setObject: self.currentPlan.sour4    forKey:PLANTYPE];
        [defaults setObject: self.currentPlan.fintime4 forKey:PLANFINTIME];
        [defaults setObject: self.currentPlan.output4  forKey:PLANOUTPUT];
        [defaults setObject: self.currentPlan.fin4     forKey:PLANFIN];
        [defaults synchronize];
        //跳转到执行页面
        [self presentExeVC:self.plan4Type];
    }else{
        //do nothing because don't have this item

    }
}


- (void) presentExeVC:(int) planType{
    UIStoryboard *mainStoryboard = self.storyboard;
    exe1ViewController *SVC;
    NSLog(@"to %i", planType);

    switch (planType) {
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
            break;
        case 7:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exe7ViewController"];
            NSLog(@"jump to page: exe7 ");
            break;
        default:
            SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"exe1ViewController"];
            NSLog(@"jump to page: exe1 ");
            break;
    }
    //设置翻页效果
    [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController: SVC animated:YES completion:nil];
}
- (IBAction)finishBtnClicked:(id)sender {
    
    //以下三行代码是当这个疗程不属于这个病时，需要自增
    CurrentPlan * currentPlan = [CurrentPlan new];
    currentPlan.sickNumber = [NSNumber numberWithInt:currentPlan.sickNumber.intValue + 1];
    [currentPlan save];
    
    Plan * plan = [Plan new];
    [plan store];

    /*
    NSMutableArray * array = [NSMutableArray new];
    array = [plan getPlanHistoryItemByID:[NSNumber numberWithInt:0]];
    NSLog(@" the array we find is%@",array);
     */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentPlan.sickNumber forKey:HISTORYID];
    [defaults synchronize];
    
    NSArray * array = [NSMutableArray new];
    array = [plan getPlanHistory];
    
   
    UIStoryboard *mainStoryboard = self.storyboard;
    analysisViewController *SVC;
    SVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"analysisViewController"];
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
