//
//  NNRunningLightController.m
//  UsuallyEncapsulation
//
//  Created by 刘朋坤 on 2018/8/1.
//  Copyright © 2018年 LiuPengKun. All rights reserved.
//

#import "NNRunningLightController.h"
#import "NNRunningLightView.h"

@interface NNRunningLightController ()

@end

@implementation NNRunningLightController

- (void)viewDidLoad {
    [super viewDidLoad];
    NNRunningLightView *runningLightView = [[NNRunningLightView alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    runningLightView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:runningLightView];
    NSArray *tempArray = @[@"大江东去", @"浪淘尽浪淘尽浪淘尽浪淘尽浪淘尽浪淘尽", @"千古风流人物"];
    runningLightView.marqueeTextArray = tempArray;
    runningLightView.runningLightBlock = ^(NSInteger index) {
        NSLog(@"%@", tempArray[index]);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
