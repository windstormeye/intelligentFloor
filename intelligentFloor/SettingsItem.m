

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
