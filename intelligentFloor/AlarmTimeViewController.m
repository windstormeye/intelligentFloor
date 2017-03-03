

#import "AlarmTimeViewController.h"
#import "JVFloatLabeledTextField/JVFloatLabeledTextField.h"
#import "FUIButton.h"
#import "MBProgressHUD+NJ.h"

@interface AlarmTimeViewController ()
{
    UIDatePicker *_beginTime;
    FUIButton *_beginBtn;
    FUIButton *_endBtn;
    BOOL _isPush;
}

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIBarButtonItem *rightBtnItem;

@end

@implementation AlarmTimeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置报警时段";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 64)];
    topView.backgroundColor = LogoColor;
    [self.view addSubview:topView];
    self.topView = topView;
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, (topView.frame.size.height - 10)/2, 60, 30)];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setFont:[UIFont systemFontOfSize:17]];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [topView addSubview:cancleBtn];
    [cancleBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(topView.frame.size.width - cancleBtn.frame.size.width, cancleBtn.frame.origin.y, cancleBtn.frame.size.width, cancleBtn.frame.size.height)];
    [saveBtn setTitle:@"存储" forState:UIControlStateNormal];
    saveBtn.font = cancleBtn.font;
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [topView addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _beginTime = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), SCREEM_WIDTH, SCREEM_HEIGHT * 0.4)];
    [self.view addSubview:_beginTime];

    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_beginTime.frame) + 5, 160, 15)];
    [self.view addSubview:hintLabel];
    hintLabel.text = @"选择时间后点击进行确认";
    hintLabel.font = [UIFont systemFontOfSize:14];
    hintLabel.textColor = [UIColor lightGrayColor];
    
    _beginBtn = [[FUIButton alloc] initWithFrame:CGRectMake((SCREEM_WIDTH - SCREEM_WIDTH*0.7)/2, CGRectGetMaxY(hintLabel.frame) + 20, SCREEM_WIDTH * 0.7, 40)];
    [self.view addSubview:_beginBtn];
    [_beginBtn setTitle:@"设定起始时间" forState:UIControlStateNormal];
    [_beginBtn addTarget:self action:@selector(beginDatePickerClick) forControlEvents:UIControlEventTouchUpInside];
    _beginBtn.buttonColor = LogoColor;
    _beginBtn.shadowColor = [UIColor lightGrayColor];
    _beginBtn.shadowHeight = 1.5f;
    _beginBtn.cornerRadius = 5.0f;
    _beginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_beginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _endBtn = [[FUIButton alloc] initWithFrame:CGRectMake(_beginBtn.frame.origin.x, CGRectGetMaxY(_beginBtn.frame) + 20, _beginBtn.frame.size.width, _beginBtn.frame.size.height)];
    [self.view addSubview:_endBtn];
    [_endBtn setTitle:@"设定结束时间" forState:UIControlStateNormal];
    [_endBtn addTarget:self action:@selector(endDatePickerClick) forControlEvents:UIControlEventTouchUpInside];
    _endBtn.buttonColor = LogoColor;
    _endBtn.shadowColor = [UIColor lightGrayColor];
    _endBtn.shadowHeight = 1.5f;
    _endBtn.cornerRadius = 5.0f;
    _endBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_endBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"存储" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClick)];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    self.rightBtnItem = rightBtnItem;
    
    //设置显示格式
    //默认根据手机本地设置显示为中文还是其他语言
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
    _beginTime.locale = locale;
    
//    //当前时间创建NSDate
//    NSDate *localDate = [NSDate date];
//    //在当前时间加上的时间：格里高利历
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
//    //设置时间
//    [offsetComponents setYear:0];
//    [offsetComponents setMonth:0];
//    [offsetComponents setDay:5];
//    [offsetComponents setHour:20];
//    [offsetComponents setMinute:0];
//    [offsetComponents setSecond:0];
    //设置最大值时间
//    NSDate *maxDate = [gregorian dateByAddingComponents:offsetComponents toDate:localDate options:0];
    //设置属性
//    _endTime.minimumDate = localDate;
//    _endTime.maximumDate = maxDate;
//    _beginTime.minimumDate = localDate;
//    _beginTime.maximumDate = maxDate;
    

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"beginTimeString"]) {
        [_beginBtn setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"beginTimeString"] forState:UIControlStateNormal];
        [_endBtn setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"endTimeString"] forState:UIControlStateNormal];
    }
    
    // 判断当前页面是push还是present进来的
    // 拿到当前导航视图控制器栈
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    // 如果栈大于1，说明为push进来的
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            self.topView.hidden = YES;
            _beginTime.frame = CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT * 0.4);
        }
    }
    // 否则为present进来的
    else{
        self.topView.hidden = NO;
    }
}

- (void)cancelBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveBtnClick {
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    // 如果栈大于1，说明为push进来的
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            self.topView.hidden = YES;
            _beginTime.frame = CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT * 0.4);
            [[NSUserDefaults standardUserDefaults] setObject:[_beginBtn currentTitle] forKey:@"beginTimeString"];
            [[NSUserDefaults standardUserDefaults] setObject:[_endBtn currentTitle] forKey:@"endTimeString"];
            [MBProgressHUD showSuccess:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    // 否则为present进来的
    else{
        self.topView.hidden = NO;
        [self dismissViewControllerAnimated:YES completion:^{
            // 在这里写下上传至服务器的代码
            [[NSUserDefaults standardUserDefaults] setObject:[_beginBtn currentTitle] forKey:@"beginTimeString"];
            [[NSUserDefaults standardUserDefaults] setObject:[_endBtn currentTitle] forKey:@"endTimeString"];
            [MBProgressHUD showSuccess:@"修改成功"];
        }];
        
    }
    
}

// 设置防盗预警起始按钮点击事件
- (void)beginDatePickerClick {
    [_beginBtn setTitle:[self changeBeginTime] forState:UIControlStateNormal];
}

// 设置防盗预警结束按钮点击事件
- (void)endDatePickerClick {
    [_endBtn setTitle:[self changeBeginTime] forState:UIControlStateNormal];
}

-(NSString *)changeBeginTime{
    NSDate *pickerDate = [_beginTime date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"yyyy年MM月dd日HH:mm"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];

    return dateString;
}

@end
