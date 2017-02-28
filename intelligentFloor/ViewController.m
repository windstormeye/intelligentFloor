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
    SystemSoundID soundID;
}

@property (strong, nonatomic) UITabBarController *contentTabBarController;
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UIImageView *backImage;
@property (nonatomic, strong) dispatch_source_t timer;

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
    
    UIImage *img = [UIImage imageNamed:@"warning_normal"];
    self.backImage = [[UIImageView alloc] initWithFrame:CGRectMake((_contentTabBarController.tabBar.frame.size.width - _contentTabBarController.tabBar.frame.size.height)/2, _contentTabBarController.tabBar.frame.origin.y, _contentTabBarController.tabBar.frame.size.height, _contentTabBarController.tabBar.frame.size.height)];
    [self.backImage setImage:img];
    [self.contentTabBarController.view addSubview:self.backImage];
    
    //加载按钮
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(50, 0, 80, 50);
    self.button.backgroundColor = [UIColor blueColor];
    [self.button addTarget:self action:@selector(isAnimotion) forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    
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
    self.backImage.image = [UIImage imageNamed:str];
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
            [self.backImage setImage:[UIImage imageNamed:str]];
        }) ;
    });
    // 启动计时器
    dispatch_resume(_timer);
}

//停止动画
-(void)stopNS {
    dispatch_source_cancel(_timer);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)btnClick {
    
}


@end
