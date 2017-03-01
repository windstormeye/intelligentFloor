//
//  ViewController.m
//  intelligentFloor
//
//  Created by #incloud on 17/2/25.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "ViewController.h"
#import "PNChart.h"
#import "stepStVC.h"
#import "peopleStVC.h"
#import <AudioToolbox/AudioToolbox.h>
#import "loginVC.h"



@interface ViewController () {
    
}

@property (strong, nonatomic) UITabBarController *contentTabBarController;


@end

@implementation ViewController

-(UITabBarController *)contentTabBarController
{
    if (!_contentTabBarController)
    {
        _contentTabBarController = [[UITabBarController alloc] init];
        stepStVC *stepVC  = [[stepStVC alloc] init];
        peopleStVC *peopleVC = [[peopleStVC alloc] init];
        UINavigationController *stepNC = [[UINavigationController alloc] initWithRootViewController:stepVC];
        stepNC.navigationBar.translucent = NO;
        UINavigationController *peopleNC = [[UINavigationController alloc] initWithRootViewController:peopleVC];
        peopleNC.navigationBar.translucent = NO;
        _contentTabBarController.viewControllers = [[NSArray alloc] initWithObjects:stepNC, peopleNC, nil];
        
        UIImage *peopleImgNormal  = [[UIImage imageNamed:@"三人_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *peopleImgselected = [[UIImage imageNamed:@"三人_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *stepImgNormal = [[UIImage imageNamed:@"foot_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *stepImgselected = [[UIImage imageNamed:@"step_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        stepNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"步数统计" image:stepImgNormal selectedImage:stepImgselected];
        peopleNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"人流统计" image:peopleImgNormal selectedImage:peopleImgselected];
        
//        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((_contentTabBarController.tabBar.frame.size.width - _contentTabBarController.tabBar.frame.size.height * 0.7) / 2, _contentTabBarController.tabBar.frame.origin.y + (_contentTabBarController.tabBar.frame.size.height - _contentTabBarController.tabBar.frame.size.height * 0.7) / 2, _contentTabBarController.tabBar.frame.size.height * 0.7, _contentTabBarController.tabBar.frame.size.height * 0.7)];

//        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((_contentTabBarController.tabBar.frame.size.width - _contentTabBarController.tabBar.frame.size.height)/2, _contentTabBarController.tabBar.frame.origin.y, _contentTabBarController.tabBar.frame.size.height, _contentTabBarController.tabBar.frame.size.height)];
//        [btn setImage:[UIImage imageNamed:@"warning_normal"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"warning_highlight"] forState:UIControlStateSelected];
//        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//        self.waring_btn = btn;
//        [_contentTabBarController.view addSubview:btn];
        
        _contentTabBarController.tabBar.tintColor = LogoColor;
    }
    return _contentTabBarController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    [self addChildViewController:self.contentTabBarController];
    [self.view addSubview:self.contentTabBarController.view];
    
        
}



@end
