#import "MessageTableViewController.h"

@interface MessageTableViewController ()
{
    UISwitch *_newMessage;
    UISwitch *_isOpenVoice;
    UISwitch *_isVibration;
    NSArray *_switchInfoArray;
    NSArray *_switchArray;
}
@end

@implementation MessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新消息提醒";
    self.navigationItem.titleView.tintColor = [UIColor whiteColor];
    //初始化所有 switch 开关
    _newMessage = [[UISwitch alloc]init];
    _newMessage.onTintColor = [UIColor colorWithRed:60/255.0 green:182/255.0 blue:228/255.0 alpha:1.0];
    [_newMessage addTarget:self action:@selector(isOpenNewMessage) forControlEvents:(UIControlEventTouchUpInside)];
    
    _isOpenVoice = [[UISwitch alloc]init];
    _isOpenVoice.onTintColor = [UIColor colorWithRed:60/255.0 green:182/255.0 blue:228/255.0 alpha:1.0];
    [_isOpenVoice addTarget:self action:@selector(isOpenVoice) forControlEvents:(UIControlEventTouchUpInside)];
    
    _isVibration = [[UISwitch alloc]init];
    _isVibration.onTintColor = [UIColor colorWithRed:60/255.0 green:182/255.0 blue:228/255.0 alpha:1.0];
    [_isVibration addTarget:self action:@selector(isOpenVibration) forControlEvents:(UIControlEventTouchUpInside)];
    
    UISwitch *emptySwitch = [[UISwitch alloc]init];
    //读取并初始化所有 Switch 开关的状态
    [self initAllSwitches];
    
    NSString *s1 = @"新消息提醒";
    NSString *s2 = @"声音";
    NSString *s3 = @"新消息提示音";
    NSString *s4 = @"振动";
    _switchInfoArray = [[NSArray alloc]initWithObjects:s1,s2,s3,s4, nil];
    
    _switchArray = [[NSArray alloc]initWithObjects:_newMessage,_isOpenVoice,emptySwitch,_isVibration, nil];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

-(void)initAllSwitches{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _newMessage.on = [defaults boolForKey:@"isOpenNewMessage"];
    _isOpenVoice.on = [defaults boolForKey:@"isOpenVoice"];
    _isVibration.on = [defaults boolForKey:@"isOpenVibration"];
    
}

-(void)isOpenNewMessage{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (_newMessage.isOn) {
        // 接收到后台数据后，在用户第一次登录时，请配置好相关个性化数据
        NSLog(@"新消息提醒已开启");
        [defaults setBool:YES forKey:@"isOpenNewMessage"];
    }else{
        NSLog(@"新消息提醒已关闭");
        [defaults setBool:NO forKey:@"isOpenNewMessage"];
    }
    [defaults synchronize];
}

-(void)isOpenVoice{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (_isOpenVoice.isOn) {
        // 接收到后台数据后，在用户第一次登录时，请配置好相关个性化数据
        NSLog(@"声音已开启");
        [defaults setBool:YES forKey:@"isOpenVoice"];
    }else{
        NSLog(@"声音已关闭");
        [defaults setBool:NO forKey:@"isOpenVoice"];
    }
    [defaults synchronize];
}

-(void)isOpenVibration{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (_isVibration.isOn) {
        // 接收到后台数据后，在用户第一次登录时，请配置好相关个性化数据
        NSLog(@"振动已开启");
        [defaults setBool:YES forKey:@"isOpenVibration"];
    }else{
        NSLog(@"振动已关闭");
        [defaults setBool:NO forKey:@"isOpenVibration"];
    }
    [defaults synchronize];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _switchInfoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = _switchInfoArray[indexPath.row];
    if (indexPath.row == 2) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = @"跟随系统";
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentRight;
        cell.accessoryView = label;
    }else{
        cell.accessoryView = _switchArray[indexPath.row];
    }
    return cell;
}

@end
