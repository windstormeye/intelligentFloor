//
//  loginView.h
//  intelligentFloor
//
//  Created by #incloud on 17/2/26.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>

@interface loginView : UIView

@property (nonatomic ,strong) JVFloatLabeledTextField *nameTxt;
@property (nonatomic ,strong) JVFloatLabeledTextField *passwdTxt;
@property (nonatomic, strong) UIButton *loginBtn_normal;
@property (nonatomic, strong) UIButton *loginBtn_touchID;

@end
