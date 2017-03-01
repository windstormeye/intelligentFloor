//
//  SettingsItem.h
//  SettingsTask
//
//  Created by 徐正科 on 17/2/28.
//  Copyright © 2017年 xzk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsItem : NSObject

@property(nonatomic,copy)NSString *title;
//要跳转的控制器
@property(nonatomic,assign)Class toNewController;

-(instancetype)initWithTitle:(NSString *)title andClass:(Class)toNewController;

@end
