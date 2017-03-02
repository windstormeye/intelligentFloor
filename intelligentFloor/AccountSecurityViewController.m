//
//  AccountSecurityViewController.m
//  SettingsTask
//
//  Created by 徐正科 on 17/2/28.
//  Copyright © 2017年 xzk. All rights reserved.
//

#import "AccountSecurityViewController.h"
#import "FUITextField.h"
#import "FUIButton.h"

@interface AccountSecurityViewController ()
{
    UITextField *_oldPassWord;
    UITextField *_newPassWord;
    UITextField *_confirmNewPassWord;
}

@property (nonatomic, strong) FUITextField *originalTxt;
@property (nonatomic, strong) FUITextField *nowTxt;
@property (nonatomic, strong) FUITextField *nowAgainTxt;

@end

@implementation AccountSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帐号与安全";
    self.navigationItem.titleView.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1];

    [self initView];
}

- (void)initView {
    FUITextField *originalTxt = [[FUITextField alloc] initWithFrame:CGRectMake((SCREEM_WIDTH - SCREEM_WIDTH * 0.8)/2, SCREEM_HEIGHT * 0.05, SCREEM_WIDTH * 0.8, 40)];
    [self.view addSubview:originalTxt];
    self.originalTxt = originalTxt;
    originalTxt.placeholder = @"原密码";
    originalTxt.font = [UIFont systemFontOfSize:16];
    originalTxt.backgroundColor = [UIColor clearColor];
    originalTxt.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    originalTxt.textFieldColor = [UIColor whiteColor];
    originalTxt.borderColor = LogoColor;
    originalTxt.borderWidth = 2.0f;
    originalTxt.cornerRadius = 3.0f;


    FUITextField *nowTxt = [[FUITextField alloc] initWithFrame:CGRectMake(originalTxt.frame.origin.x, CGRectGetMaxY(originalTxt.frame) + 10, originalTxt.frame.size.width, originalTxt.frame.size.height)];
    [self.view addSubview:nowTxt];
    self.nowTxt = nowTxt;
    nowTxt.placeholder = @"修改后的密码";
    nowTxt.font = [UIFont systemFontOfSize:16];
    nowTxt.backgroundColor = [UIColor clearColor];
    nowTxt.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    nowTxt.textFieldColor = [UIColor whiteColor];
    nowTxt.borderColor = LogoColor;
    nowTxt.borderWidth = 2.0f;
    nowTxt.cornerRadius = 3.0f;

    
    FUITextField *nowAgainTxt = [[FUITextField alloc] initWithFrame:CGRectMake(originalTxt.frame.origin.x, CGRectGetMaxY(nowTxt.frame) + 10, originalTxt.frame.size.width, originalTxt.frame.size.height)];
    [self.view addSubview:nowAgainTxt];
    self.nowAgainTxt = nowAgainTxt;
    nowAgainTxt.placeholder = @"再次输入";
    nowAgainTxt.font = [UIFont systemFontOfSize:16];
    nowAgainTxt.backgroundColor = [UIColor clearColor];
    nowAgainTxt.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    nowAgainTxt.textFieldColor = [UIColor whiteColor];
    nowAgainTxt.borderColor = LogoColor;
    nowAgainTxt.borderWidth = 2.0f;
    nowAgainTxt.cornerRadius = 3.0f;

    FUIButton *confirmBtn = [[FUIButton alloc] initWithFrame:CGRectMake((SCREEM_WIDTH - originalTxt.frame.size.width)/2, CGRectGetMaxY(nowAgainTxt.frame) + 20, originalTxt.frame.size.width, 35)];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.buttonColor = LogoColor;
    confirmBtn.shadowColor = [UIColor lightGrayColor];
    confirmBtn.shadowHeight = 1.5f;
    confirmBtn.cornerRadius = 5.0f;
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

// 确定按钮点击事件
- (void)confirmBtnClick {
    
}


@end
