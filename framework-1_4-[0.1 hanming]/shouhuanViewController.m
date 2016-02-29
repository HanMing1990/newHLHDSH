//
//  shouhuanViewController.m
//  AppscommBluetoothSDKDemo
//
//  Created by 韩明 on 16/2/27.
//  Copyright © 2016年 Appscomm. All rights reserved.
//

#import "shouhuanViewController.h"
#import "SelectProductTableViewController.h"
#import "ScanDevicesTableViewController.h"
#import "AppscommDevice.h"


@interface shouhuanViewController ()
@property (nonatomic, assign) AppscommDeviceType deviceType;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;
@property (nonatomic, strong) NSArray *devicesArray;
@end

@implementation shouhuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[AppscommBluetoothSDK startRunBluetooth];
    NSLog(@"after start blue");
    //sleep(10);
    //[self searchDevices];
    //[self clickedBtn: self.scanBtn];
    //[self clickedBtn: nil];
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(myScan) object:nil];
    [thread start];
    
    /*sleep(10);
    [self.scanBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    sleep(10);
    [self.scanBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)myScan{
    NSLog(@"oh iam in myscan");
    NSInteger *deviceTypeIndex = 0;//Unlimited
    self.devicesArray = nil;
    self.deviceType = (AppscommDeviceType)deviceTypeIndex;
    NSLog(@"sss%lu", (unsigned long)self.deviceType);
    
    NSLog(@"info list:");
    NSLog(@"%@", [AppscommBluetoothSDK sharedInstance].connectedDevice);
    NSLog(@"%lu", (unsigned long)[AppscommBluetoothSDK sharedInstance].deviceType);
    NSLog(@"%i", [AppscommBluetoothSDK sharedInstance].bluetoothReady);
    NSLog(@"%@", [AppscommBluetoothSDK sharedInstance].version);
    
    [[AppscommBluetoothSDK sharedInstance] scanDevicesWithType:self.deviceType
                                               timeoutInternal:5
                                                    completion:^(NSArray *scanedDevices,NSError *error){
                                                        //ASYNC_MAIN_QUEUE_START
                                                        self.devicesArray = [NSArray arrayWithArray:scanedDevices];
                                                        NSLog(@"I'm in the scanDevices%@", self.devicesArray);
                                                        //ASYNC_MAIN_QUEUE_END
                                                        
                                                    }];
}




- (void)showAlertWithString:(NSString *)msg{
    
    NSString *newMsg = [NSString stringWithFormat:@"HanMing %@",msg];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:newMsg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [alertController dismissViewControllerAnimated:NO completion:nil];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:NO completion:nil];
}
- (IBAction)clickedBtn:(id)sender {
    NSLog(@"sender %@", sender);
    NSInteger *deviceTypeIndex = 0;//Unlimited
    self.devicesArray = nil;
    self.deviceType = (AppscommDeviceType)deviceTypeIndex;
    NSLog(@"sss%lu", (unsigned long)self.deviceType);
    
    NSLog(@"info list:");
    NSLog(@"%@", [AppscommBluetoothSDK sharedInstance].connectedDevice);
    NSLog(@"%lu", (unsigned long)[AppscommBluetoothSDK sharedInstance].deviceType);
    NSLog(@"%i", [AppscommBluetoothSDK sharedInstance].bluetoothReady);
    NSLog(@"%@", [AppscommBluetoothSDK sharedInstance].version);
    
    [[AppscommBluetoothSDK sharedInstance] scanDevicesWithType:self.deviceType
                                               timeoutInternal:5
                                                    completion:^(NSArray *scanedDevices,NSError *error){
                                                        //ASYNC_MAIN_QUEUE_START
                                                        self.devicesArray = [NSArray arrayWithArray:scanedDevices];
                                                        NSLog(@"I'm in the scanDevices%@", self.devicesArray);
                                                        //ASYNC_MAIN_QUEUE_END
                
                                                    }];
}


   
- (IBAction)anotherThing:(id)sender {
    NSLog(@"another");
}
    

- (IBAction)showDevices:(id)sender {
    NSLog(@"%@", self.devicesArray);
}


- (IBAction)connectDevice:(id)sender {
    AppscommDevice *p = [self.devicesArray objectAtIndex:0];
    
    //2. 链接设备
    [[AppscommBluetoothSDK sharedInstance] connectDevice:p timeoutInternal:10 completion:^(NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!error) {
                NSLog(@"ok can connect");
                //读取产品信息
                /*
                [[AppscommBluetoothSDK sharedInstance] readProductType:^(NSString *name,NSError *error){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self showAlertWithString:(error ? error.description : name)];
                    });
                }];
                 */
                
                [[AppscommBluetoothSDK sharedInstance] readSleepData:^(NSArray *data,NSError *error){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error) {
                            [self showAlertWithString:error.description];
                        }else{
                            NSLog(@"详细睡眠数据：%@", data);                        }
                    });
                }];
            }else{
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"连接设备失败"
                                                                    message:[NSString stringWithFormat:@"%@", error]
                                                                   delegate:self
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
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
