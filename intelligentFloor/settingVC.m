

#import "settingVC.h"
#import "SettingsItem.h"
#import "MessageTableViewController.h"
#import "QuietHoursTableViewController.h"
#import "AccountSecurityViewController.h"
#import "AlarmTimeViewController.h"
#import "loginVC.h"

@interface settingVC () <UITableViewDelegate,UITableViewDataSource> {
    NSArray *_dataArray;
}

@end

@implementation settingVC


-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    
    SettingsItem *item1 = [[SettingsItem alloc]initWithTitle:@"新消息提醒" andClass:[MessageTableViewController class]];
    SettingsItem *item2 = [[SettingsItem alloc]initWithTitle:@"勿扰模式" andClass:[QuietHoursTableViewController class]];
    SettingsItem *item3 = [[SettingsItem alloc]initWithTitle:@"帐号与安全" andClass:[AccountSecurityViewController class]];
    SettingsItem *item4 = [[SettingsItem alloc]initWithTitle:@"报警时段" andClass:[AlarmTimeViewController class]];
    _dataArray = @[item1,item2,item3,item4];
    
    UITableView *settingsView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    settingsView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];;
    
    
    settingsView.delegate = self;
    settingsView.dataSource = self;
    
    [self.view addSubview:settingsView];
    
    self.navigationItem.title = @"设置";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _dataArray.count;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellID"];
    }
    if (indexPath.section == 1) {
        UIButton *quitBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        quitBtn.frame = CGRectMake(self.view.frame.size.width/2-50, 0, 100, 40);
        [quitBtn setTitle:@"退出" forState:(UIControlStateNormal)];
        [quitBtn addTarget:self action:@selector(quit) forControlEvents:(UIControlEventTouchUpInside)];
        [quitBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        
        [cell addSubview:quitBtn];
    }else{
        SettingsItem *item = _dataArray[indexPath.row];
        cell.textLabel.text = item.title;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingsItem *item = _dataArray[indexPath.row];
    if (indexPath.section == 0) {
        if (item.toNewController) {
            id newItem = [[item.toNewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:newItem animated:YES];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)quit{
    loginVC *login = [[loginVC alloc] init];
    [self presentViewController:login animated:YES completion:nil];
    NSLog(@"111");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





@end
