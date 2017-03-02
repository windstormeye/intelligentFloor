

#import "stepStVC.h"
#import "PNChart.h"
#import "settingVC.h"
#import "AlarmTimeViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface stepStVC () {
    SystemSoundID soundID;
}

@property (nonatomic, strong) UIView *PNchartView;
@property (nonatomic, strong) PNLineChart *dayLineChart;
@property (nonatomic, strong) PNLineChart *weekLineChart;
@property (nonatomic, strong) PNLineChart *monthLineChart;
@property (nonatomic, strong) PNLineChart *yearLineChart;

@property (nonatomic, strong) dispatch_source_t timer;
@property (strong, nonatomic) UIButton *button;


@end

@implementation stepStVC

-(UIView *)PNchartView {
    if (!_PNchartView) {
        _PNchartView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEM_HEIGHT * 0.1, SCREEM_WIDTH, self.view.frame.size.height * 0.5)];
        [self.view addSubview:_PNchartView];
    }
    return _PNchartView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = LogoColor;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"步数统计";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 44)];
    UIImageView *beixingImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, titleView.frame.size.width, titleView.frame.size.height)];
    beixingImg.image = [UIImage imageNamed:@"logo"];
    [titleView addSubview:beixingImg];
    self.navigationItem.titleView = titleView;
    
    UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(settingMethon)];
    self.navigationItem.rightBarButtonItem = settingBtnItem;
    UIBarButtonItem *warningBtnItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"warning_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(warningMethon)];
    self.navigationItem.leftBarButtonItem = warningBtnItem;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    NSArray *segmentArr = [[NSArray alloc]initWithObjects:@"日",@"周",@"月",@"年",nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:segmentArr];
    segment.frame = CGRectMake((SCREEM_WIDTH - SCREEM_WIDTH * 0.8) / 2, self.tabBarController.tabBar.frame.origin.y - 120, SCREEM_WIDTH * 0.8, 40);
    segment.tintColor = LogoColor;
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
//    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.button.frame = CGRectMake(50, 0, 80, 50);
//    self.button.backgroundColor = [UIColor blueColor];
//    [self.button addTarget:self action:@selector(isAnimotion) forControlEvents:UIControlEventTouchUpInside];
//    [self.button setTitle:@"开始" forState:UIControlStateNormal];
//    [self.view addSubview:self.button];

    [self initView];
}


-(void)isAnimotion {
    if([self.button.titleLabel.text isEqualToString:@"停止"]) {
        [self stopNS];
        [self.button setTitle:@"开始" forState:UIControlStateNormal];
    } else {
        [self startNS];
        [self.button setTitle:@"停止" forState:UIControlStateNormal];
    }
}

// 调用系统铃声
-(void)createSystemSoundWithName:(NSString *)soundName soundType:(NSString *)soundType
{
    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",soundName,soundType];
    if (path) {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
        AudioServicesPlaySystemSound(soundID);
    }
}

//加载动画
-(void)startNS {
    __block NSString *str =@"warning_highlight";
    //定时器开始执行的延时时间
    NSTimeInterval delayTime = 0.0f;
    //定时器间隔时间
    NSTimeInterval timeInterval = 0.3f;
    //创建子线程队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //使用之前创建的队列来创建计时器
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置延时执行时间，delayTime为要延时的秒数
    dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
    //设置计时器
    dispatch_source_set_timer(_timer, startDelayTime, timeInterval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        //执行事件
        if ( [str isEqualToString:@"warning_normal"]) {
            str = @"warning_highlight";
            // 在灯亮的时候调用系统铃声
            [self createSystemSoundWithName:@"ct-error" soundType:@"caf"];
        } else {
            str = @"warning_normal";
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationItem.leftBarButtonItem setImage:[[UIImage imageNamed:str] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }) ;
    });
    // 启动计时器
    dispatch_resume(_timer);
}

//停止动画
-(void)stopNS {
    dispatch_source_cancel(_timer);
    [self.navigationItem.leftBarButtonItem setImage:[[UIImage imageNamed:@"warning_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    
}

- (void)initView {
    PNLineChart * dayLineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, self.PNchartView.frame.size.width, self.PNchartView.frame.size.height)];
    [dayLineChart setXLabels:@[@"0",@"3",@"6",@"9",@"12", @"15", @"18", @"21"]];
    NSArray * dayArray = @[@30.1, @54.1, @76.4, @262.2, @766.2, @877, @1200, @355];
    PNLineChartData *dayData = [PNLineChartData new];
    dayData.color = PNFreshGreen;
    dayData.itemCount = dayLineChart.xLabels.count;
    dayData.getData = ^(NSUInteger index) {
        CGFloat yValue = [dayArray[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    dayLineChart.chartData = @[dayData];
    [dayLineChart strokeChart];
    self.dayLineChart = dayLineChart;
    [self.PNchartView addSubview:dayLineChart];
    
    PNLineChart * weekLineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, self.PNchartView.frame.size.width, self.PNchartView.frame.size.height)];
    [weekLineChart setXLabels:@[@"周日",@"周一",@"周二",@"周三",@"周四", @"周五", @"周六"]];
    NSArray * weekArray = @[@8990, @7622, @7352, @6098, @6788, @7865, @9055];
    PNLineChartData *weekData = [PNLineChartData new];
    weekData.color = PNLightGreen;
    weekData.itemCount = weekLineChart.xLabels.count;
    weekData.getData = ^(NSUInteger index) {
        CGFloat yValue = [weekArray[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    weekLineChart.chartData = @[weekData];
    [weekLineChart strokeChart];
    self.weekLineChart = weekLineChart;

    
    // 月折线图
    PNLineChart * monthLineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, self.PNchartView.frame.size.width, self.PNchartView.frame.size.height)];
    [monthLineChart setXLabels:@[@"1",@"5",@"10",@"15",@"20", @"25", @"30"]];
    NSArray * monthArray = @[@40992, @45590, @44321, @50111, @48765, @43221, @42010];
    PNLineChartData *monthData = [PNLineChartData new];
    monthData.color = PNLightGreen;
    monthData.itemCount = monthLineChart.xLabels.count;
    monthData.getData = ^(NSUInteger index) {
        CGFloat yValue = [monthArray[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    monthLineChart.chartData = @[monthData];
    [monthLineChart strokeChart];
    self.monthLineChart = monthLineChart;

    // 年折线图
    PNLineChart * yearLineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, self.PNchartView.frame.size.width, self.PNchartView.frame.size.height)];
    [yearLineChart setXLabels:@[@"1",@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"]];
    NSArray * yearArray = @[@256879, @226578, @204542, @208768, @231232, @222168, @298987, @199897, @267980, @198698, @199999, @201768];
    PNLineChartData *yearData = [PNLineChartData new];
    yearData.color = PNLightGreen;
    yearData.itemCount = yearLineChart.xLabels.count;
    yearData.getData = ^(NSUInteger index) {
        CGFloat yValue = [yearArray[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    yearLineChart.chartData = @[yearData];
    [yearLineChart strokeChart];
    self.yearLineChart = yearLineChart;
}

-(void)change:(UISegmentedControl *)sender{
    for(UIView *view in [self.PNchartView subviews])
    {
        [view removeFromSuperview];
    }
    if (sender.selectedSegmentIndex == 0) {

        [self.PNchartView addSubview:self.dayLineChart];
    }else if (sender.selectedSegmentIndex == 1){

        [self.PNchartView addSubview:self.weekLineChart];
    }else if (sender.selectedSegmentIndex == 2){

        [self.PNchartView addSubview:self.monthLineChart];
    }else if (sender.selectedSegmentIndex == 3){

        [self.PNchartView addSubview:self.yearLineChart];
    }
}

- (void)settingMethon {
    settingVC *set = [[settingVC alloc] init];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:set animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

- (void)warningMethon {
    AlarmTimeViewController *alarm = [[AlarmTimeViewController alloc] init];

    [self presentViewController:alarm animated:YES completion:nil];
}


@end
