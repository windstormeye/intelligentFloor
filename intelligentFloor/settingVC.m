//
//  settingVC.m
//  intelligentFloor
//
//  Created by #incloud on 17/2/27.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "settingVC.h"
#import "PopoverSelector.h"

@interface settingVC () <SelectorDelegate>

@end

@implementation settingVC 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)btnClick {
    [self showTimeRangeSelector:YYYYMM];
}

- (void)showTimeRangeSelector:(TimeRangeType)rangeType{
    PopoverSelector *selector = [[PopoverSelector alloc] initSelectorWithFrameRangeType:CGRectMake(5, SCREEM_HEIGHT - 216, SCREEM_WIDTH - 20, 216) RangeType:rangeType];
    [selector setTitle:@"选择时间范围"];
    [selector setTag:BASE_RANGE_TAG + 1];
    [selector setSelectDelegate:self];
    
    [selector show];
}


@end
