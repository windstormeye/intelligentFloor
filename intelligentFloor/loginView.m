//
//  loginView.m
//  intelligentFloor
//
//  Created by #incloud on 17/2/26.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "loginView.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>

@implementation loginView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    if (self) {
        
        // 别忘了添加logo
        
        UILabel *welTitleLabel_CN = [[UILabel alloc] initWithFrame:CGRectMake((SCREEM_WIDTH - 220) / 2, SCREEM_HEIGHT * 0.3, 220, 30)];
        welTitleLabel_CN.text = @"欢迎使用极米科技智能地板";
        welTitleLabel_CN.textAlignment = NSTextAlignmentCenter;
        welTitleLabel_CN.font = [UIFont systemFontOfSize:17];
        [self addSubview:welTitleLabel_CN];
        
        UILabel *welTitleLabel_EN = [[UILabel alloc] initWithFrame:CGRectMake((SCREEM_WIDTH - 300) / 2, CGRectGetMaxY(welTitleLabel_CN.frame), 300, 30)];
        welTitleLabel_EN.text = @"Welcome to use Jimi Intelligent floor";
        welTitleLabel_EN.textAlignment = NSTextAlignmentCenter;
        welTitleLabel_EN.font = [UIFont systemFontOfSize:17];
        [self addSubview:welTitleLabel_EN];
        
        JVFloatLabeledTextField *nameTxt = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake((SCREEM_WIDTH - SCREEM_WIDTH * 0.6) / 2, CGRectGetMaxY(welTitleLabel_EN.frame) + 30, SCREEM_WIDTH * 0.6, 40)];
        [self addSubview:nameTxt];
        nameTxt.font = [UIFont systemFontOfSize:16];
        nameTxt.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:NSLocalizedString(@"用户名", @"")
                                        attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        nameTxt.floatingLabelFont = [UIFont boldSystemFontOfSize:11];
        nameTxt.floatingLabelTextColor = [UIColor lightGrayColor];
        nameTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
        nameTxt.keepBaseline = YES;
        
        UIView *nameLineView = [[UIView alloc] initWithFrame:CGRectMake(nameTxt.frame.origin.x, CGRectGetMaxY(nameTxt.frame) + 1, nameTxt.frame.size.width, 1)];
        [self addSubview:nameLineView];
        nameLineView.backgroundColor = [UIColor lightGrayColor];

        JVFloatLabeledTextField *passwdTxt = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(nameTxt.frame.origin.x, CGRectGetMaxY(nameTxt.frame) + 5, nameTxt.frame.size.width, 40)];
        [self addSubview:passwdTxt];
        passwdTxt.font = [UIFont systemFontOfSize:16];
        passwdTxt.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:NSLocalizedString(@"密码", @"")
                                        attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        passwdTxt.floatingLabelFont = [UIFont boldSystemFontOfSize:11];
        passwdTxt.floatingLabelTextColor = [UIColor lightGrayColor];
        passwdTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
        passwdTxt.keepBaseline = YES;
        
        UIView *passwdLineView = [[UIView alloc] initWithFrame:CGRectMake(nameTxt.frame.origin.x, CGRectGetMaxY(passwdTxt.frame) + 1, nameTxt.frame.size.width, 1)];
        [self addSubview:passwdLineView];
        passwdLineView.backgroundColor = [UIColor lightGrayColor];
        
        UIButton *loginBtn_normal = [[UIButton alloc] initWithFrame:CGRectMake(nameTxt.frame.origin.x, CGRectGetMaxY(passwdLineView.frame) + 50, nameTxt.frame.size.width, 35)];
        loginBtn_normal.backgroundColor = DeepSkyBlue;
        [loginBtn_normal setFont:[UIFont systemFontOfSize:14]];
        [loginBtn_normal setTitle:@"登录" forState:UIControlStateNormal];
        loginBtn_normal.layer.cornerRadius = 5;
        [self addSubview:loginBtn_normal];
        
        UIButton *loginBtn_touchID = [[UIButton alloc] initWithFrame:CGRectMake(nameTxt.frame.origin.x, CGRectGetMaxY(loginBtn_normal.frame) + 5, nameTxt.frame.size.width, 35)];
        loginBtn_touchID.backgroundColor = CornflowerBlue;
        [loginBtn_touchID setFont:[UIFont systemFontOfSize:14]];
        [loginBtn_touchID setTitle:@"使用指纹登录" forState:UIControlStateNormal];
        loginBtn_touchID.layer.cornerRadius = 5;
        [self addSubview:loginBtn_touchID];
    }
    return self;
}



@end
