#import "stepStVC.h"

@interface stepStVC ()  {
    SystemSoundID soundID;
}

@property (nonatomic, strong) dispatch_source_t timer;    // 计时器
@property (strong, nonatomic) UIButton *button;    // 测试预警功能的按钮
@property (strong, nonatomic) UILabel *allStepNum;    // 总步数Label
@property (strong, nonatomic) UILabel *nowStepNum;    // 当前步数Label

@property (nonatomic, strong) NSArray *yArr;    // 记录Y轴数据
@property (nonatomic, strong) NSArray *xArr;    // 记录X轴数据

@property (nonatomic, strong) BEMSimpleLineGraphView *myGraph;    // 数据分布图

@end

@implementation stepStVC

- (NSArray *)yArr {
    if (!_yArr) {
        // 优先初始化 日 步数
        _yArr = @[@30, @54, @76, @262, @766, @877, @1200, @355];    // 伪数据，等待后端数据接入
        // 使用KVO方式优先直接计算出总和
        NSNumber *sum = [_yArr valueForKeyPath:@"@sum.self"];
        self.allStepNum.text = [sum stringValue];
    }
    return _yArr;
}

- (NSArray *)xArr {
    if (!_xArr) {
        // 优先初始化 日 人流数
        _xArr = @[@"0",@"3",@"6",@"9",@"12", @"15", @"18", @"21h"];    // 伪数据，等待后端数据接入
    }
    return _xArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = LogoColor;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"步数统计";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   
    // 设置navigationController的titleView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 44)];
    UIImageView *beixingImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, titleView.frame.size.width, titleView.frame.size.height)];
    beixingImg.image = [UIImage imageNamed:@"logo"];
    [titleView addSubview:beixingImg];
    self.navigationItem.titleView = titleView;
    
    UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(settingMethon)];
    self.navigationItem.rightBarButtonItem = settingBtnItem;
    UIBarButtonItem *warningBtnItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"warning_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(warningMethon)];
    self.navigationItem.leftBarButtonItem = warningBtnItem;
    
    // 修改plist文件中相关参数后，加上该代码，把状态栏变为亮色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    // 隐藏navigationBar顶部分割线
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
    //把该按钮显示出来即可体现预警功能
//    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.button.frame = CGRectMake(50, 0, 80, 50);
//    self.button.backgroundColor = [UIColor blueColor];
//    [self.button addTarget:self action:@selector(isAnimotion) forControlEvents:UIControlEventTouchUpInside];
//    [self.button setTitle:@"开始" forState:UIControlStateNormal];
//    [self.view addSubview:self.button];

    [self initChart];
}

// 初始化数据分布图
- (void)initChart {
    // 存放总步数和当前步数Label的view
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 70)];
    topView.backgroundColor = LogoColor;
    [self.view addSubview:topView];
    
    // 总步数 标题Label
    UILabel *allStepNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
    allStepNumLabel.text = @"总步数";
    allStepNumLabel.textAlignment = NSTextAlignmentLeft;
    allStepNumLabel.font = [UIFont systemFontOfSize:12];
    allStepNumLabel.backgroundColor = [UIColor clearColor];
    allStepNumLabel.textColor = [UIColor whiteColor];
    [topView addSubview:allStepNumLabel];
    
    // 总步数 数字Label
    UILabel *allStepNum = [[UILabel alloc] initWithFrame:CGRectMake(allStepNumLabel.frame.origin.x, CGRectGetMaxY(allStepNumLabel.frame), SCREEM_WIDTH / 2, topView.frame.size.height - allStepNumLabel.frame.size.height)];
    allStepNum.textColor = [UIColor whiteColor];
    allStepNum.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:allStepNum];
    allStepNum.font = [UIFont systemFontOfSize:30];
    allStepNum.backgroundColor = [UIColor clearColor];
    self.allStepNum = allStepNum;
    
    // 当前步数 标题Label
    UILabel *nowStepNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEM_WIDTH - allStepNumLabel.frame.size.width, 0, allStepNumLabel.frame.size.width, allStepNumLabel.frame.size.height)];
    nowStepNumLabel.text = @"当前步数";
    nowStepNumLabel.textAlignment =  NSTextAlignmentRight;
    nowStepNumLabel.font = [UIFont systemFontOfSize:12];
    nowStepNumLabel.backgroundColor = [UIColor clearColor];
    nowStepNumLabel.textColor = [UIColor whiteColor];
    [topView addSubview:nowStepNumLabel];
    
    // 当前步数 数字Label
    UILabel *nowStepNum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(allStepNum.frame), allStepNum.frame.origin.y, allStepNum.frame.size.width, allStepNum.frame.size.height)];
    nowStepNum.textColor = [UIColor whiteColor];
    nowStepNum.textAlignment = NSTextAlignmentRight;
    [topView addSubview:nowStepNum];
    nowStepNum.font = [UIFont systemFontOfSize:30];
    nowStepNum.backgroundColor = [UIColor clearColor];
    self.nowStepNum = nowStepNum;
    
    // 分割器设置
    NSArray *segmentArr = [[NSArray alloc]initWithObjects:@"日",@"周",@"月",@"年",nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:segmentArr];
    segment.frame = CGRectMake((SCREEM_WIDTH - SCREEM_WIDTH * 0.8) / 2, self.tabBarController.tabBar.frame.origin.y - 120, SCREEM_WIDTH * 0.8, 40);
    segment.tintColor = LogoColor;
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
    // 数据分布图设置
    BEMSimpleLineGraphView *myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), SCREEM_WIDTH, SCREEM_HEIGHT * 0.5)];
    myGraph.dataSource = self;
    myGraph.delegate = self;
    myGraph.alwaysDisplayDots = YES;
    myGraph.colorTop = LogoColor;
    myGraph.colorBottom = LogoColor;
    myGraph.colorLine = [UIColor whiteColor];
    // 是否允许用户对数据分布图进行交互
    myGraph.enableTouchReport = YES;
    myGraph.colorXaxisLabel = [UIColor whiteColor];
    self.myGraph = myGraph;
    [self.view addSubview:myGraph];
    myGraph.widthLine = 3;
    // 是否允许用户对数据分布图进行交互时触摸的点弹出提示label
    myGraph.enablePopUpReport = YES;
    // 是否允许用户点击数据分布图的x轴label
    myGraph.enableXAxisLabel = YES;
    // 数据分布图的相关动画设置
    self.myGraph.animationGraphStyle = BEMLineAnimationDraw;
    self.myGraph.lineDashPatternForReferenceYAxisLines = @[@(2),@(2)];

    // 数据分布图线条下部分区域颜色渐变设置
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 0.0
    };
    self.myGraph.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
}

// 图表中数据点的个数
- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return self.yArr.count;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [self.yArr[index] floatValue];
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    return self.xArr[index];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
    self.nowStepNum.text = [NSString stringWithFormat:@"%@", [self.yArr objectAtIndex:index]];
}

// 防盗预警  图标动画设置
-(void)isAnimotion {
    if([self.button.titleLabel.text isEqualToString:@"停止"]) {
        [self stopNS];
        [self.button setTitle:@"开始" forState:UIControlStateNormal];
    } else {
        [self startNS];
        [self.button setTitle:@"停止" forState:UIControlStateNormal];
    }
}

// 防盗预警  调用系统铃声
-(void)createSystemSoundWithName:(NSString *)soundName soundType:(NSString *)soundType
{
    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",soundName,soundType];
    if (path) {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
        AudioServicesPlaySystemSound(soundID);
    }
}

//防盗预警  加载动画
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

//防盗预警  停止动画
-(void)stopNS {
    dispatch_source_cancel(_timer);
    [self.navigationItem.leftBarButtonItem setImage:[[UIImage imageNamed:@"warning_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

// 分割器改变事件
-(void)change:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        self.yArr = @[@30, @54, @76, @262, @766, @877, @1200, @355];    // 伪数据，等待后端数据接入
        self.xArr = @[@"0",@"3",@"6",@"9",@"12", @"15", @"18", @"21h"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myGraph reloadGraph];
            self.allStepNum.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
        });
    } else if (sender.selectedSegmentIndex == 1) {
        self.yArr = @[@8990, @7622, @7352, @6098, @6788, @7865, @9055];    // 伪数据，等待后端数据接入
        self.xArr = @[@"周日",@"周一",@"周二",@"周三",@"周四", @"周五", @"周六"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myGraph reloadGraph];
            self.allStepNum.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
        });
    } else if (sender.selectedSegmentIndex == 2) {
        self.yArr = @[@40992, @45590, @44321, @50111, @48765, @43221, @42010];    // 伪数据，等待后端数据接入
        self.xArr = @[@"1",@"5",@"10",@"15",@"20", @"25", @"30d"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myGraph reloadGraph];
            self.allStepNum.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
        });
    } else if (sender.selectedSegmentIndex == 3) {
        self.yArr = @[@256879, @226578, @204542, @208768, @231232, @222168, @298987, @199897, @267980, @198698, @199999, @201768];    // 伪数据，等待后端数据接入
        self.xArr = @[@"1",@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12m"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myGraph reloadGraph];
            self.allStepNum.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
        });
    }
}

// 设置按钮点击事件
- (void)settingMethon {
    settingVC *set = [[settingVC alloc] init];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:set animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

// 防盗预警按钮点击事件
- (void)warningMethon {
    AlarmTimeViewController *alarm = [[AlarmTimeViewController alloc] init];

    [self presentViewController:alarm animated:YES completion:nil];
}


@end
