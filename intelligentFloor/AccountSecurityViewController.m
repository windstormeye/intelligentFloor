//
//  AccountSecurityViewController.m
//  SettingsTask
//
//  Created by 徐正科 on 17/2/28.
//  Copyright © 2017年 xzk. All rights reserved.
//

#import "AccountSecurityViewController.h"

@interface AccountSecurityViewController ()
{
    UITextField *_oldPassWord;
    UITextField *_newPassWord;
    UITextField *_confirmNewPassWord;
}
@end

@implementation AccountSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帐号与安全";
    self.navigationItem.titleView.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/5, self.view.frame.size.width, 20)];
    text.text = @"更改帐号和密码";
    text.textAlignment = NSTextAlignmentCenter;
    text.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:text];
    
    UILabel *oldPwdText = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/5*1.5, self.view.frame.size.width/2, 30)];
    oldPwdText.text = @"原有密码";
    oldPwdText.textAlignment = NSTextAlignmentCenter;
    oldPwdText.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:oldPwdText];
    
    _oldPassWord = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2*0.8, self.view.frame.size.height/5*1.5, self.view.frame.size.width/2, 30)];
    _oldPassWord.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_oldPassWord];
    
    UILabel *newPwdText = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/5*1.75, self.view.frame.size.width/2, 30)];
    newPwdText.text = @"修改密码";
    newPwdText.textAlignment = NSTextAlignmentCenter;
    newPwdText.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:newPwdText];
    
    _newPassWord = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2*0.8, self.view.frame.size.height/5*1.75, self.view.frame.size.width/2,30)];
    _newPassWord.borderStyle = UITextBorderStyleRoundedRect;
    _newPassWord.secureTextEntry = YES;
    [self.view addSubview:_newPassWord];
    
    UILabel *newPwdText2 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/5*2, self.view.frame.size.width/2, 30)];
    newPwdText2.text = @"修改密码";
    newPwdText2.textAlignment = NSTextAlignmentCenter;
    newPwdText2.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:newPwdText2];
    
    _confirmNewPassWord = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2*0.8, self.view.frame.size.height/5*2, self.view.frame.size.width/2,30)];
    _confirmNewPassWord.borderStyle = UITextBorderStyleRoundedRect;
    _confirmNewPassWord.secureTextEntry = YES;
    [self.view addSubview:_confirmNewPassWord];
    
    UIButton *confirmBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    confirmBtn.layer.masksToBounds = YES;
    confirmBtn.layer.cornerRadius = 5;
    confirmBtn.layer.borderWidth = 1;
    confirmBtn.frame = CGRectMake(self.view.frame.size.width/2-30, self.view.frame.size.height/2, 60, 30);
    [confirmBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:confirmBtn];
}

-(void)confirm{
    NSLog(@"密码修改成功");
}



@end
