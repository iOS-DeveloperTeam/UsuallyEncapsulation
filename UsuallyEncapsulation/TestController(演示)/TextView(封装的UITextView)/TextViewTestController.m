//
//  TextViewTestController.m
//  UsuallyEncapsulation
//
//  Created by yizhilu on 2018/5/21.
//  Copyright © 2018年 LiuPengKun. All rights reserved.
//

#import "TextViewTestController.h"
#import "NNTextView.h"

@interface TextViewTestController ()
@property (nonatomic,strong) NNTextView *textView;

@end

@implementation TextViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView = [[NNTextView alloc] initWithFrame:CGRectMake(10, SafeAreaTopHeight+10, SCREEN_WIDTH - 20, 80)];
    [self.view addSubview:_textView];
    _textView.cornerRadius = 5;
    _textView.font = [UIFont systemFontOfSize:15];
    // 注意: maxNumberOfLines需在设置字体大小之后, 否则默认会根据字号17来换行
    _textView.maxNumberOfLines = 10;
    _textView.placeholderText = @"这是占位文本, 自动换行到第10行时便不再换行, 你可以自定义设置";
    [_textView textValueDidChanged:^(CGFloat textViewHeight) {
        CGRect frame = _textView.frame;
        frame.size.height = textViewHeight;
        _textView.frame = frame;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
