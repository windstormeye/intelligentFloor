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

#import "loginVC.h"



@interface ViewController ()

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
        
//        UIImage *userImgNormal  = [[UIImage imageNamed:@"user_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        UIImage *userImghighlight = [[UIImage imageNamed:@"user_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        UIImage *homeImgNormal = [[UIImage imageNamed:@"notepad_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        UIImage *homeImghighlight = [[UIImage imageNamed:@"notepad_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        stepNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"步数统计" image:nil selectedImage:nil];
        peopleNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"人流统计" image:nil selectedImage:nil];
        
        _contentTabBarController.tabBar.tintColor = LogoColor;
    }
    return _contentTabBarController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addChildViewController:self.contentTabBarController];
    [self.view addSubview:self.contentTabBarController.view];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
