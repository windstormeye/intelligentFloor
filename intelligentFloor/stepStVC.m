//
//  stepStVC.m
//  intelligentFloor
//
//  Created by #incloud on 17/2/26.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "stepStVC.h"
#import "PNChart.h"

@interface stepStVC ()

@property (nonatomic, strong) UIView *PNchartView;
@property (nonatomic, strong) PNLineChart *dayLineChart;
@property (nonatomic, strong) PNLineChart *weekLineChart;
@property (nonatomic, strong) PNLineChart *monthLineChart;
@property (nonatomic, strong) PNLineChart *yearLineChart;


@end

@implementation stepStVC

-(UIView *)PNchartView {
    if (!_PNchartView) {
        _PNchartView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.2, SCREEM_WIDTH, self.view.frame.size.height * 0.5)];
        [self.view addSubview:_PNchartView];
    }
    return _PNchartView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = LogoColor;
    self.view.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    [self initView];
}

- (void)initView {
    // 日折线图
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
    
    // 周折线图
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
    [monthLineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"]];
    NSArray * monthArray = @[@210742, @249875, @247690, @190865, @210987, @209890, @199987, @125785, @209685, @208654, @198790, @190999];
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
    [yearLineChart setXLabels:@[@"2016",@"2017"]];
    NSArray * yearArray = @[@2568790, @22657286];
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

    NSArray *segmentArr = [[NSArray alloc]initWithObjects:@"日",@"周",@"月",@"年",nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:segmentArr];
    segment.frame = CGRectMake((SCREEM_WIDTH - SCREEM_WIDTH * 0.8) / 2, CGRectGetMaxY(self.PNchartView.frame) + 30, SCREEM_WIDTH * 0.8, 40);
    segment.tintColor = LogoColor;
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
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



@end