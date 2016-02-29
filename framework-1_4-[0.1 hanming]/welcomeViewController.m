//
//  welcomeViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/2/29.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "welcomeViewController.h"
#import "loginViewController.h"
#import "beforeBindViewController.h"
#import "AppscommDevice.h"
#import "AppscommBluetoothSDK.h"


@interface welcomeViewController ()

@end

@implementation welcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
- (IBAction)enterBtnClicked:(id)sender {
    @try {
        //判断是否绑定了手环
        
        [self connectSpecialDevice];
        
        //顺利绑定的话就到loginVC
        NSLog(@"ok i am here");
        UIStoryboard *mainStoryboard = self.storyboard;
        loginViewController *SVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        //设置翻页效果
        [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController: SVC animated:NO completion:nil];
        
        
        
    }
    @catch (NSException *exception) {
        //说明连不上手环,跳转到绑定界面，重新绑定
        UIStoryboard *mainStoryboard = self.storyboard;
        beforeBindViewController *SVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"beforeBindViewController"];
        //设置翻页效果
        [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController: SVC animated:NO completion:nil];
    }
  
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


#pragma mark - 蓝牙通信相关的函数
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
                
                //3. 测试能否读取数据（只有这样才能读到数据）
                NSLog(@"if read data ok");
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
