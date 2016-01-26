//
//  loginViewController.m
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/26.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import "loginViewController.h"
#import "mainViewController.h"
@interface loginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *passwd;
@property (weak, nonatomic) IBOutlet UILabel *loginAidText;

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginBtnClicked:(id)sender {
    //1. 取出用户的账号和密码(存在静态变量里)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [defaults valueForKey:@"account"];
    NSString *passwd = [defaults valueForKey:@"passwd"];
    //2. 比较
    if ([account isEqualToString:self.account.text] && [passwd isEqualToString:self.passwd.text]) {
        //2.1 输入正确，跳转到mainVC
        UIStoryboard *mainStoryboard = self.storyboard;
        mainViewController *SVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"mainViewController"];
        //设置翻页效果
        [SVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController: SVC animated:NO completion:nil];
    }
    else{
        //2.2 输入错误，继续输入
        self.loginAidText.text = @"账号或密码输入错误";
    }
    
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
