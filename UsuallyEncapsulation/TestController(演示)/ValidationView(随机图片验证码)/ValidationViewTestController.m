//
//  ValidationViewTestController.m
//  UsuallyEncapsulation
//
//  Created by yizhilu on 2018/5/21.
//  Copyright © 2018年 LiuPengKun. All rights reserved.
//

#import "ValidationViewTestController.h"
#import "NNValidationView.h"

@interface ValidationViewTestController ()

@property (nonatomic, strong) NNValidationView *testView;

@end

@implementation ValidationViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    _testView = [[NNValidationView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) / 2, 200, 100, 40) andCharCount:4 andLineCount:4];
    [self.view addSubview:self.testView];
    NNWeakSelf
    // 返回验证码数字
    self.testView.changeValidationCodeBlock = ^(void){
        NSLog(@"验证码被点击了：%@", weakSelf.testView.charString);
    };
    NSLog(@"第一次打印：%@", self.testView.charString);
}

@end
