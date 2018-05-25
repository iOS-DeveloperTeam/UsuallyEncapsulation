//
//  SlideTitleViewTestController.m
//  UsuallyEncapsulation
//
//  Created by yizhilu on 2018/5/21.
//  Copyright © 2018年 LiuPengKun. All rights reserved.
//

#import "SlideTitleViewTestController.h"
#import "NNSlideTitleView.h"

@interface SlideTitleViewTestController ()

@end

@implementation SlideTitleViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = NNRGBColor(250, 250, 250);
    [self simpleTest];
    [self textWidthTest];
    [self textSizeTest];
    [self backgroundColorTest];
    [self adaptiveArrayLength];
}

/** 最简模式*/
- (void)simpleTest {
    NNSlideTitleView *titleView = [[NNSlideTitleView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 35) titleArray:@[@"今日头条", @"优酷", @"百词斩"]];
    titleView.buttonSelected = ^(NSInteger index) {
        NSLog(@"block: 你点击了第 %ld 个按钮", index+1);
    };
    [self.view addSubview:titleView];
}

/** 标签栏底部的下划线与当前标签文本等宽*/
- (void)textWidthTest {
    NNSlideTitleView *titleView = [[NNSlideTitleView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 35) titleArray:@[@"今日头条", @"优酷", @"百词斩"]];
    titleView.sliderWidthType = NNTextWidth;
    titleView.buttonSelected = ^(NSInteger index) {
        NSLog(@"block: 你点击了第 %ld 个按钮", index+1);
    };
    [self.view addSubview:titleView];
}

/** 点击改变背景色*/
- (void)backgroundColorTest {
    NNSlideTitleView *titleView = [[NNSlideTitleView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 35) titleArray:@[@"今日头条", @"优酷", @"百词斩"]];
    titleView.slideTitleViewType = NNBackgroundColorType;
    titleView.buttonBackgroundColor = [UIColor cyanColor];
    titleView.buttonSelected = ^(NSInteger index) {
        NSLog(@"block: 你点击了第 %ld 个按钮", index+1);
    };
    [self.view addSubview:titleView];
}

/** 点击改变文字大小*/
- (void)textSizeTest {
    NNSlideTitleView *titleView = [[NNSlideTitleView alloc] initWithFrame:CGRectMake(0, 400, SCREEN_WIDTH, 35) titleArray:@[@"今日头条", @"优酷", @"百词斩"]];
    titleView.scale = 1.2;
    titleView.buttonSelected = ^(NSInteger index) {
        NSLog(@"block: 你点击了第 %ld 个按钮", index+1);
    };
    [self.view addSubview:titleView];
}

/** 自适应数组长度及文本长度*/
- (void)adaptiveArrayLength {
    NSArray *dataArray = @[@"今日头条", @"优酷", @"百词斩" , @"简书", @"网易云音乐", @"思维导图", @"keep", @"知乎", @"滴滴出行", @"喜马拉雅", @"268网校"];
    NNSlideTitleView *titleView = [[NNSlideTitleView alloc] initWithFrame:CGRectMake(0, 500, SCREEN_WIDTH, 35) titleArray:dataArray];
    titleView.scale = 1.1;
    titleView.buttonCustomWidth = NNCustomTextWidth;
    titleView.slideTitleViewType = NNBackgroundColorType;
    titleView.buttonBackgroundColor = [UIColor cyanColor];
    titleView.buttonSelected = ^(NSInteger index) {
        NSLog(@"block: 你点击了第 %ld 个按钮", index+1);
    };
    [self.view addSubview:titleView];
    
    NNSlideTitleView *titleView1 = [[NNSlideTitleView alloc] initWithFrame:CGRectMake(0, 600, SCREEN_WIDTH, 35) titleArray:dataArray];
    titleView1.buttonCustomWidth = NNCustomTextWidth;
    titleView1.selectedTag = 5;
    titleView1.buttonSelected = ^(NSInteger index) {
        NSLog(@"block: 你点击了第 %ld 个按钮", index+1);
    };
    [self.view addSubview:titleView1];
}

@end
