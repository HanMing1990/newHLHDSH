//
//  testShouHuanViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/2/27.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "testShouHuanViewController.h"
#import "AppscommDevice.h"
#import "AppscommBluetoothSDK.h"
@interface testShouHuanViewController ()
@property (nonatomic, strong) NSArray *devicesArray;
@property (nonatomic, assign) AppscommDeviceType deviceType;
@end

@implementation testShouHuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.devicesArray = [NSArray new];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 辅助函数

- (void)showAlertWithString:(NSString *)msg{
    
    NSString *newMsg = [NSString stringWithFormat:@"HanMing %@",msg];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:newMsg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [alertController dismissViewControllerAnimated:NO completion:nil];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:NO completion:nil];
}


#pragma mark - 蓝牙通信相关的函数的调用

- (IBAction)scanBrand:(id)sender {
    [self searchDevices];
}

- (IBAction)showBrandScand:(id)sender {
    NSLog(@"%@", self.devicesArray);
}

- (IBAction)connectTargetDevice1:(id)sender {
    AppscommDevice *p = [self.devicesArray objectAtIndex:0];
    NSLog(@"connectDevices%@", p.uuid);
    [self connectDevices: p];
}
- (IBAction)connectTargetDevice2:(id)sender {
    AppscommDevice *p = [self.devicesArray objectAtIndex:1];
    NSLog(@"connectDevices%@", p.uuid);
    [self connectDevices: p];
}

- (IBAction)connectTargetDevice3:(id)sender {
    AppscommDevice *p = [self.devicesArray objectAtIndex:2];
    NSLog(@"connectDevices%@", p.uuid);
    [self connectDevices: p];
}

- (IBAction)allInOne:(id)sender {
    [self connectSpecialDevice];
    
    
    [[AppscommBluetoothSDK sharedInstance] readUserInfo:^(BOOL isFemale,
                                                          NSUInteger height,
                                                          NSUInteger weight,
                                                          NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [self showAlertWithString:error.description];
            }else{
                [self showAlertWithString:[NSString stringWithFormat:@"%@,%lucm,%lug", isFemale ? @"女":@"男", (unsigned long)height, (unsigned long)weight]];
            }
        });
    }];
}


- (IBAction)readData:(id)sender {
    /*
    //获取详细的睡眠数据
    [[AppscommBluetoothSDK sharedInstance] readSleepData:^(NSArray *data,NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [self showAlertWithString:error.description];
            }else{
                NSLog(@"详细睡眠数据：%@", data);                        }
        });
    }];*/
    
    
    
    //获取用户信息
    /*
    [[AppscommBluetoothSDK sharedInstance] readUserInfo:^(BOOL isFemale,
                                                          NSUInteger height,
                                                          NSUInteger weight,
                                                          NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [self showAlertWithString:error.description];
            }else{
                [self showAlertWithString:[NSString stringWithFormat:@"%@,%lucm,%lug", isFemale ? @"女":@"男", (unsigned long)height, (unsigned long)weight]];
            }
        });
    }];
     */
    
    
    
    //获取watchID
    [[AppscommBluetoothSDK sharedInstance] readWatchID:^(NSString *name,NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAlertWithString:(error ? error.description : name)];
            //保存下来下次直接链接该手环
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject: name forKey:@"defaultWatchID"];
            [defaults synchronize];
            NSLog(@"read watchID:%@", name);

        });
        
    }];

    
    
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


//连接已绑定的设备
- (void)connectSpecialDevice{
    //1. 获取保存的watchID
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultWatchId = [defaults valueForKey:@"defaultWatchID"];
    
    //2. 链接之
    [[AppscommBluetoothSDK sharedInstance] connectDeviceWithType:0 watchID:defaultWatchId timeoutInternal:10 completion:^(NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^(){
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
