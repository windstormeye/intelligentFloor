

#import "QuietHoursTableViewController.h"

@interface QuietHoursTableViewController ()
{
    UISwitch *_isQuietHours;
}
@end

@implementation QuietHoursTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"勿扰模式";
    self.navigationItem.titleView.tintColor = [UIColor whiteColor];
    
    _isQuietHours = [[UISwitch alloc]init];
    _isQuietHours.onTintColor = [UIColor colorWithRed:60/255.0 green:182/255.0 blue:228/255.0 alpha:1.0];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _isQuietHours.on = [defaults boolForKey:@"isOpenQuietHours"];
    
    [_isQuietHours addTarget:self action:@selector(isOpenQuietHours) forControlEvents:(UIControlEventTouchUpInside)];
}

-(instancetype)initWithStyle:(UITableViewStyle)style{
    return [super initWithStyle:UITableViewStyleGrouped];
}

-(void)isOpenQuietHours{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 接收到后台数据后，在用户第一次登录时，请配置好相关个性化数据
    if (_isQuietHours.isOn) {
        NSLog(@"开启勿扰模式");
        [defaults setBool:YES forKey:@"isOpenQuietHours"];
    }else{
        NSLog(@"关闭勿扰模式");
        [defaults setBool:NO forKey:@"isOpenQuietHours"];
    }
    [defaults synchronize];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = @"勿扰模式";
    cell.accessoryView = _isQuietHours;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, 30)];
    label.numberOfLines = 0;
    label.text = @"开启后,收到新消息时不会响铃或振动。";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor grayColor];
    
    UIView *view = [[UIView alloc]init];
    [view addSubview:label];
    return view;
}
@end
