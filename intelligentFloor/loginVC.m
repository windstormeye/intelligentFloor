//
//  loginVC.m
//  intelligentFloor
//
//  Created by #incloud on 17/2/26.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "loginVC.h"
#import "loginView.h"

@interface loginVC ()

@end

@implementation loginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    loginView *login = [[loginView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];;
    [self.view addSubview:login];
    [login.loginBtn_normal addTarget:self action:@selector(loginBtn_normalMethon) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loginBtn_normalMethon {
    NSLog(@"111");
}



@end
