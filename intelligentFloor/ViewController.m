//
//  ViewController.m
//  intelligentFloor
//
//  Created by #incloud on 17/2/25.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "ViewController.h"
#import "PNChart.h"
#import "loginView.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    loginView *log = [[loginView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:log];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
