//
//  SettingsItem.m
//  SettingsTask
//
//  Created by 徐正科 on 17/2/28.
//  Copyright © 2017年 xzk. All rights reserved.
//

#import "SettingsItem.h"

@implementation SettingsItem

-(instancetype)initWithTitle:(NSString *)title andClass:(Class)toNewController{
    if (self = [super init]) {
        self.title = title;
        self.toNewController = toNewController;
    }
    return self;
}
@end
