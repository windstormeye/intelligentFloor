#import <Foundation/Foundation.h>

@interface SettingsItem : NSObject

@property(nonatomic,copy)NSString *title;
//要跳转的控制器
@property(nonatomic,assign)Class toNewController;

-(instancetype)initWithTitle:(NSString *)title andClass:(Class)toNewController;

@end
