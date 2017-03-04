#import "loginVC.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import "FUIButton.h"
#import "MBProgressHUD+NJ.h"

@interface loginVC ()

@property (nonatomic ,strong) JVFloatLabeledTextField *nameTxt;  // 用户名文本框
@property (nonatomic ,strong) JVFloatLabeledTextField *passwdTxt;  // 密码文本框
@property (nonatomic, strong) FUIButton *loginBtn;  // 登录按钮
@property (nonatomic, strong) FUIButton *signUpBtn;  // 注册按钮
@property (nonatomic, strong) UIButton *signUpBtn_small;  // 前往注册按钮
@property (nonatomic, strong) UIButton *loginBtn_small; // 前往登录按钮

@end

@implementation loginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置当前高斯模糊背景图
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    imgView.image = [UIImage imageNamed:@"login_background"];
    [self.view addSubview:imgView];
    UIVisualEffectView *effectView =[[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    effectView.frame = CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT);
    [self.view addSubview:effectView];
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView {
    // 公司logo
    UIImageView *logoImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEM_WIDTH - SCREEM_WIDTH * 0.7)/2, 30, SCREEM_WIDTH * 0.7, SCREEM_HEIGHT * 0.2)];
    logoImg.image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:logoImg];
    // 欢迎词_中文
    UILabel *welTitleLabel_CN = [[UILabel alloc] initWithFrame:CGRectMake((SCREEM_WIDTH - 220) / 2, SCREEM_HEIGHT * 0.3, 220, 25)];
    welTitleLabel_CN.text = @"欢迎使用极米科技智能地板";
    welTitleLabel_CN.textColor = [UIColor lightGrayColor];
    welTitleLabel_CN.textAlignment = NSTextAlignmentCenter;
    welTitleLabel_CN.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:welTitleLabel_CN];
    // 欢迎词_英文
    UILabel *welTitleLabel_EN = [[UILabel alloc] initWithFrame:CGRectMake((SCREEM_WIDTH - 300) / 2, CGRectGetMaxY(welTitleLabel_CN.frame), 300, 25)];
    welTitleLabel_EN.text = @"Welcome to use Jimi Intelligent floor";
    welTitleLabel_EN.textAlignment = NSTextAlignmentCenter;
    welTitleLabel_EN.textColor = [UIColor lightGrayColor];
    welTitleLabel_EN.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:welTitleLabel_EN];
    // 用户名输入框
    JVFloatLabeledTextField *nameTxt = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake((SCREEM_WIDTH - SCREEM_WIDTH * 0.6) / 2, CGRectGetMaxY(welTitleLabel_EN.frame) + 30, SCREEM_WIDTH * 0.6, 40)];
    [self.view addSubview:nameTxt];
    self.nameTxt = nameTxt;
    nameTxt.textColor = [UIColor whiteColor];
    nameTxt.font = [UIFont systemFontOfSize:16];
    nameTxt.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"用户名", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    nameTxt.floatingLabelFont = [UIFont boldSystemFontOfSize:11];
    nameTxt.floatingLabelTextColor = [UIColor lightGrayColor];
    nameTxt.floatingLabelActiveTextColor = DeepSkyBlue;
    nameTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTxt.keepBaseline = YES;
    // 用户名输入框下划线
    UIView *nameLineView = [[UIView alloc] initWithFrame:CGRectMake(nameTxt.frame.origin.x, CGRectGetMaxY(nameTxt.frame) + 1, nameTxt.frame.size.width, 1)];
    [self.view addSubview:nameLineView];
    nameLineView.backgroundColor = [UIColor lightGrayColor];
    // 密码输入框
    JVFloatLabeledTextField *passwdTxt = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(nameTxt.frame.origin.x, CGRectGetMaxY(nameTxt.frame) + 5, nameTxt.frame.size.width, 40)];
    [self.view addSubview:passwdTxt];
    self.passwdTxt = passwdTxt;
    passwdTxt.textColor = [UIColor whiteColor];
    passwdTxt.floatingLabelActiveTextColor = DeepSkyBlue;
    passwdTxt.secureTextEntry = YES;
    passwdTxt.font = [UIFont systemFontOfSize:16];
    passwdTxt.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"密码", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    passwdTxt.floatingLabelFont = [UIFont boldSystemFontOfSize:11];
    passwdTxt.floatingLabelTextColor = [UIColor lightGrayColor];
    passwdTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwdTxt.keepBaseline = YES;
    // 密码输入框下划线
    UIView *passwdLineView = [[UIView alloc] initWithFrame:CGRectMake(nameTxt.frame.origin.x, CGRectGetMaxY(passwdTxt.frame) + 1, nameTxt.frame.size.width, 1)];
    [self.view addSubview:passwdLineView];
    passwdLineView.backgroundColor = [UIColor lightGrayColor];
    // 登录按钮
    FUIButton *loginBtn = [[FUIButton alloc] initWithFrame:CGRectMake(nameTxt.frame.origin.x, CGRectGetMaxY(passwdLineView.frame) + 50, nameTxt.frame.size.width, 40)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.buttonColor = DeepSkyBlue;
    loginBtn.shadowColor = [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1];
    loginBtn.shadowHeight = 3.0f;
    loginBtn.cornerRadius = 5.0f;
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    FUIButton *signUpBtn = [[FUIButton alloc] initWithFrame:CGRectMake(loginBtn.frame.origin.x, loginBtn.frame.origin.y, loginBtn.frame.size.width, loginBtn.frame.size.height)];
    [signUpBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.view addSubview:signUpBtn];
    self.signUpBtn = signUpBtn;
    signUpBtn.hidden = YES;
    [signUpBtn addTarget:self action:@selector(signUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    signUpBtn.buttonColor = [UIColor orangeColor];
    signUpBtn.shadowColor = [UIColor colorWithRed:139/255.0 green:90/255.0 blue:43/255.0 alpha:1];
    signUpBtn.shadowHeight = 3.0f;
    signUpBtn.cornerRadius = 5.0f;
    signUpBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [signUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // 前往注册按钮
    UIButton *signUpBtn_small = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(loginBtn.frame) - 115, CGRectGetMaxY(loginBtn.frame) + 10, 115, 20)];
    [self.view addSubview:signUpBtn_small];
    self.signUpBtn_small = signUpBtn_small;
    signUpBtn_small.titleLabel.textAlignment = NSTextAlignmentCenter;
    signUpBtn_small.font = [UIFont systemFontOfSize:12];
    [signUpBtn_small setTitle:@"没有账号？前往注册" forState:UIControlStateNormal];
    [signUpBtn_small addTarget:self action:@selector(signUpBtn_smallClick) forControlEvents:UIControlEventTouchUpInside];
    // 前往登录按钮
    UIButton *loginBtn_small = [[UIButton alloc] initWithFrame:CGRectMake(signUpBtn_small.frame.origin.x, signUpBtn_small.frame.origin.y, signUpBtn_small.frame.size.width, signUpBtn_small.frame.size.height)];
    [self.view addSubview:loginBtn_small];
    loginBtn_small.titleLabel.textAlignment = NSTextAlignmentCenter;
    loginBtn_small.font = [UIFont systemFontOfSize:12];
    [loginBtn_small setTintColor:[UIColor greenColor]];
    loginBtn_small.hidden = YES;
    self.loginBtn_small = loginBtn_small;
    [loginBtn_small setTitle:@"已有账号？前往登录" forState:UIControlStateNormal];
    [loginBtn_small addTarget:self action:@selector(loginBtn_smallClick) forControlEvents:UIControlEventTouchUpInside];
}

// 注册
- (void)signUpBtnClick {
    [MBProgressHUD showError:@"未开放注册"];
}

// 点击前往登录
- (void)signUpBtn_smallClick {
    self.loginBtn.hidden = YES;
    self.loginBtn_small.hidden = NO;
    self.signUpBtn_small.hidden = YES;
    self.signUpBtn.hidden = NO;
}

// 点击前往注册
- (void)loginBtn_smallClick {
    self.loginBtn.hidden = NO;
    self.loginBtn_small.hidden = YES;
    self.signUpBtn_small.hidden = NO;
    self.signUpBtn.hidden = YES;
}

// 登录
- (void)loginBtnClick {
    NSString *nameStr = [NSString stringWithString:self.nameTxt.text];
    NSString *passwdStr = [NSString stringWithString:self.passwdTxt.text];
    // 请在此与服务器进行用户登录及注册的交互
    if ([nameStr  isEqual: @"test"] && [passwdStr  isEqual: @"test"]) {
        [[NSUserDefaults standardUserDefaults] setObject:nameStr forKey:@"user_name"];
        [[NSUserDefaults standardUserDefaults] setObject:passwdStr forKey:@"user_passwd"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [MBProgressHUD showError:@"请检查账号和密码"];
    }
}

@end
