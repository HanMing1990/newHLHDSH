//
//  signinViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/26.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "signinViewController.h"
#import "loginViewController.h"

@interface signinViewController ()
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *passwd;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *sex;
@property (weak, nonatomic) IBOutlet UILabel *signinAidText;

@end

@implementation signinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //# 设立委托
    self.account.delegate = self;
    self.passwd.delegate = self;
    self.name.delegate = self;
    self.sex.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitBtnClicked:(id)sender {
    //按理说应该上传服务器判断是否这个账号已经注册过了，简单版本先不上传
    //1. 将用户输入的信息存入本地
    //1.1 判断账号输入是否非法（空值）
    if ([self.account.text isEqualToString:@""]) {
        self.signinAidText.text = @"账号输入不合法";
    }
    else{
        //1.2 保存用户的账户信息
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: self.account.text forKey:@"account"];
        [defaults setObject: self.passwd.text forKey:@"passwd"];
        [defaults setObject: self.name.text forKey:@"name"];
        [defaults setObject: self.sex.text forKey:@"sex"];
        [defaults synchronize];
        
        //2. 跳转到主界面
        UIStoryboard *mainStoryboard = self.storyboard;
        loginViewController *SVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        //设置翻页效果
        [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController: SVC animated:NO completion:nil];
        
     }
    
    
    //设置目标的默认值，按理说这里应该再写一个界面来让用户输入
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: @1000 forKey:@"kaluliTarget"];
    [defaults setObject: @1000 forKey:@"stepTarget"];
    [defaults setObject: @8 forKey:@"sleepTarget"];
    [defaults setObject: @3000 forKey:@"distanceTarget"];
    [defaults synchronize];
    
}

//#实现协议,这样键盘就会撤回了
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
