//
//  ValidationCodeViewTestController.m
//  UsuallyEncapsulation
//
//  Created by yizhilu on 2018/5/21.
//  Copyright © 2018年 LiuPengKun. All rights reserved.
//

#import "ValidationCodeViewTestController.h"
#import "NNValidationCodeView.h"

@interface ValidationCodeViewTestController ()

@end

@implementation ValidationCodeViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    NNValidationCodeView *view = [[NNValidationCodeView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-265)/2, SafeAreaTopHeight+100, 265, 40) andLabelCount:6 andLabelDistance:5];
    [self.view addSubview:view];
    view.changedColor = [UIColor blueColor];
    view.codeBlock = ^(NSString *codeString) {
        NSLog(@"验证码:%@", codeString);
    };
    
    NNValidationCodeView *view1 = [[NNValidationCodeView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-210)/2, SafeAreaTopHeight+200, 210, 45) andLabelCount:4 andLabelDistance:10];
    [self.view addSubview:view1];
    view1.changedColor = [UIColor redColor];
    view1.codeBlock = ^(NSString *codeString) {
        NSLog(@"验证码:%@", codeString);
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
