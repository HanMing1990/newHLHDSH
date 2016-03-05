//
//  bindBrandViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/2/29.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "bindBrandViewController.h"

#import "AppscommDevice.h"
#import "AppscommBluetoothSDK.h"

#import "loginViewController.h"


@interface bindBrandViewController ()
@property (weak, nonatomic) IBOutlet UIButton *deviceBtn1;
@property (weak, nonatomic) IBOutlet UIButton *deviceBtn2;
@property (weak, nonatomic) IBOutlet UIButton *deviceBtn3;

@property (nonatomic, strong) NSArray *devicesArray;
@end

@implementation bindBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.deviceBtn1.hidden = YES;
    self.deviceBtn2.hidden = YES;
    self.deviceBtn3.hidden = YES;
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 辅助函数

- (void)showAlertWithString:(NSString *)msg{
    
    NSString *newMsg = [NSString stringWithFormat:@"%@",msg];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:newMsg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [alertController dismissViewControllerAnimated:NO completion:nil];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:NO completion:nil];
}



-(void) readWatchIdAndToLoginVC{
    //获取watchID
    [[AppscommBluetoothSDK sharedInstance] readWatchID:^(NSString *name,NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                //1. 保存下来下次直接链接该手环
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject: name forKey:@"defaultWatchID"];
                [defaults synchronize];
                
                NSLog(@"read watchID:%@", name);
                
                //2. 跳转到登录界面
                UIStoryboard *mainStoryboard = self.storyboard;
                loginViewController *SVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"loginViewController"];
                //设置翻页效果
                [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                [self presentViewController: SVC animated:NO completion:nil];
                
            }
            else{
                [self showAlertWithString: error.description];
            }
            
        });
        
    }];
}

#pragma mark - 按钮点击的函数们
- (IBAction)btn1Clicked:(id)sender {
    if (self.devicesArray.count>0) {
      AppscommDevice *p = [self.devicesArray objectAtIndex:0];
      [self connectDevices:p];
      [self readWatchIdAndToLoginVC];

    }

}


- (IBAction)btn2Clicked:(id)sender {
    if (self.devicesArray.count>1) {
        AppscommDevice *p = [self.devicesArray objectAtIndex:1];
        [self connectDevices:p];
        [self readWatchIdAndToLoginVC];
       
    }

}


- (IBAction)btn3Clicked:(id)sender {
    if (self.devicesArray.count>2) {
        AppscommDevice *p = [self.devicesArray objectAtIndex:2];
        [self connectDevices:p];
        [self readWatchIdAndToLoginVC];
        
    }

}


- (IBAction)scanDeviceBtnClicked:(id)sender {
    
    [self searchDevices];
}

#pragma mark - 蓝牙通信相关的函数
//搜索设备，未绑定的情况下，并把搜到的设备放到array中
- (void)searchDevices{
    /*
     NSInteger *deviceTypeIndex =0;//Unlimited
     self.devicesArray = nil;
     self.deviceType = (AppscommDeviceType)deviceTypeIndex;
     */
    [[AppscommBluetoothSDK sharedInstance] scanDevicesWithType:0
                                               timeoutInternal:5
                                                    completion:^(NSArray *scanedDevices,NSError *error){
                                                        //ASYNC_MAIN_QUEUE_START
                                                        self.devicesArray = [NSArray arrayWithArray:scanedDevices];
                                                        NSLog(@"xxx%@", self.devicesArray);
                                                        NSLog(@"device num is %lu", (unsigned long)self.devicesArray.count);
                                                        if (self.devicesArray.count>0) {
                                                            self.deviceBtn1.hidden = NO;
                                                            AppscommDevice *p = [self.devicesArray objectAtIndex:0];
                                                            [self.deviceBtn1 setTitle:p.name forState:UIControlStateNormal];
                                                            
                                                            NSLog(@"name 1 is%@", p.name);
                                                        }
                                                        
                                                        if (self.devicesArray.count>1) {
                                                            self.deviceBtn2.hidden = NO;
                                                            AppscommDevice *p = [self.devicesArray objectAtIndex:1];
                                                            [self.deviceBtn2 setTitle:p.name forState:UIControlStateNormal];
                                                             NSLog(@"name 2 is%@", p.name);
                                                        }
                                                        
                                                        if (self.devicesArray.count>2) {
                                                            self.deviceBtn3.hidden = NO;
                                                            AppscommDevice *p = [self.devicesArray objectAtIndex:2];
                                                            [self.deviceBtn3 setTitle:p.name forState:UIControlStateNormal];
                                                             NSLog(@"name 3 is%@", p.name);
                                                        }
                                                        //ASYNC_MAIN_QUEUE_END
                                                    }];
}

//链接设备
- (void)connectDevices: (AppscommDevice *)p{
    [[AppscommBluetoothSDK sharedInstance] connectDevice:p timeoutInternal:10 completion:^(NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                NSLog(@"connect ok");
            }else{
                NSLog(@"connect not ok");
            }
        });
    }];
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
