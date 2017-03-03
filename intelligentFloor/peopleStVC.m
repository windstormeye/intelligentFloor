#import "peopleStVC.h"
#import "BEMSimpleLineGraphView.h"
#import "PNChart.h"
#import "settingVC.h"
#import "AlarmTimeViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface peopleStVC () <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>

@property (nonatomic, strong) dispatch_source_t timer;    // 计时器
@property (strong, nonatomic) UIButton *button;    // 测试防盗预警功能按钮
@property (strong, nonatomic) UILabel *allStepNum;    // 总步数Label
@property (strong, nonatomic) UILabel *nowStepNum;    // 当前步数Label

@property (nonatomic, strong) NSArray *yArr;    // 记录Y轴数据
@property (nonatomic, strong) NSArray *xArr;    // 记录X轴数据

@property (nonatomic, strong) BEMSimpleLineGraphView *myGraph;    // 数据分布图

@end

@implementation peopleStVC

- (NSArray *)yArr {
    if (!_yArr) {
        // 优先初始化成日步数
        _yArr = @[@60, @20, @9, @50, @192, @200, @452, @369];
        // 使用KVO方式优先直接计算出总和
        NSNumber *sum = [_yArr valueForKeyPath:@"@sum.self"];
        self.allStepNum.text = [sum stringValue];
    }
    return _yArr;
}

- (NSArray *)xArr {
    if (!_xArr) {
        _xArr = @[@"0",@"3",@"6",@"9",@"12", @"15", @"18", @"21h"];
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
    self.navigationItem.title = @"人流统计";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // 设置navigationController的titleView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 44)];
    UIImageView *beixingImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, titleView.frame.size.width, titleView.frame.size.height)];
    beixingImg.image = [UIImage imageNamed:@"logo"];
    [titleView addSubview:beixingImg];
    self.navigationItem.titleView = titleView;
    
    UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(settingMethon)];
    self.navigationItem.rightBarButtonItem = settingBtnItem;
    
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
    allStepNumLabel.text = @"总人数";
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
    nowStepNumLabel.text = @"当前人数";
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

// 分割器改变事件
-(void)change:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        self.yArr = @[@60, @20, @9, @50, @192, @200, @452, @369];
        self.xArr = @[@"0",@"3",@"6",@"9",@"12", @"15", @"18", @"21h"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myGraph reloadGraph];
            self.allStepNum.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
        });
    } else if (sender.selectedSegmentIndex == 1) {
        self.yArr = @[@1305, @1501, @1209, @1122, @1500, @1249, @1988];
        self.xArr = @[@"周日",@"周一",@"周二",@"周三",@"周四", @"周五", @"周六"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myGraph reloadGraph];
            self.allStepNum.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
        });
    } else if (sender.selectedSegmentIndex == 2) {
        self.yArr = @[@1305, @5988, @6099, @6011, @7201, @5921, @6999];
        self.xArr = @[@"1",@"5",@"10",@"15",@"20", @"25", @"30d"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myGraph reloadGraph];
            self.allStepNum.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
        });
    } else if (sender.selectedSegmentIndex == 3) {
        self.yArr = @[@37012, @35012, @30251, @35678, @30987, @34562, @33321, @29989, @40987, @34980, @40981, @38769];
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

@end
