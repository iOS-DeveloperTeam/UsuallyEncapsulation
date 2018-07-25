# 这里存放一些封装的常用组件, 便于 iOS 组内部使用;

### 星星视图

- 简单示例代码:

```
    MStarView *starView1 = [[MStarView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-47.5, 250, 15, 15) starNumber:5 starSpace:5 starNormal:@"课程反馈_灰色星星" starSelect:@"课程反馈_星星"];
    starView1.starNumber = 4;
    [self.view addSubview:starView1];
```

- 星星视图效果图

![星星视图](https://github.com/iOS-DeveloperTeam/UsuallyEncapsulation/blob/master/演示图/01星星视图.png)



### 多页面控制器的头部视图

- 简单示例代码:

```
    NNSlideTitleView *titleView = [[NNSlideTitleView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 35) titleArray:@[@"今日头条", @"优酷", @"百词斩"]];
    titleView.buttonSelected = ^(NSInteger index) {
        NSLog(@"block: 你点击了第 %ld 个按钮", index+1);
    };
    [self.view addSubview:titleView];
```

- 多页面控制器的头部视图效果图

![多页面控制器的头部视图](https://github.com/iOS-DeveloperTeam/UsuallyEncapsulation/blob/master/演示图/02多页面控制器的头部视图.gif)


### 日历

- 简单示例代码:

```

    MCalendarViewConfig *config = [[MCalendarViewConfig alloc] init];
    config.normalTextColor = [UIColor purpleColor];
    config.weakTextColor = [UIColor redColor];
    config.yeadMothTextColor = [UIColor brownColor];
    config.weekdays = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    config.isCalendarEvent = YES;
    config.noLeftRightSlide = YES;
    MCalendarView *siginCalendar = [[MCalendarView alloc] initWithFrame:CGRectMake(0, 300+SafeAreaTopHeight, SCREEN_WIDTH, [MCalendarView getMonthTotalHeight:[NSDate date] type:CalendarType_Month]) Date:[NSDate date] Type:CalendarType_Month calendarConfig:config];
    [self.view addSubview:siginCalendar];
```

- 日历效果图

![日历](https://github.com/iOS-DeveloperTeam/UsuallyEncapsulation/blob/master/演示图/03日历.gif)




### 圆形验证码

- 简单示例代码:

```
    NNValidationCodeView *view = [[NNValidationCodeView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-265)/2, SafeAreaTopHeight+100, 265, 40) andLabelCount:6 andLabelDistance:5];
    [self.view addSubview:view];
    view.changedColor = [UIColor blueColor];
    view.codeBlock = ^(NSString *codeString) {
        NSLog(@"验证码:%@", codeString);
    };
```

- 圆形验证码效果图

![圆形验证码](https://github.com/iOS-DeveloperTeam/UsuallyEncapsulation/blob/master/演示图/04圆形验证码.gif)


### 随机图片验证码

- 简单示例代码:

```
    _testView = [[NNValidationView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) / 2, 200, 100, 40) andCharCount:4 andLineCount:4];
    [self.view addSubview:self.testView];
    NNWeakSelf
    // 返回验证码数字
    self.testView.changeValidationCodeBlock = ^(void){
        NSLog(@"验证码被点击了：%@", weakSelf.testView.charString);
    };
```

- 随机图片验证码效果图

![随机图片验证码](https://github.com/iOS-DeveloperTeam/UsuallyEncapsulation/blob/master/演示图/05随机图片验证码.gif)


### 带占位文本且自动换行的TextView

- 简单示例代码:

```
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
```

- 带占位文本且自动换行的 TextView 效果图

![带占位文本且自动换行的TextView](https://github.com/iOS-DeveloperTeam/UsuallyEncapsulation/blob/master/演示图/06带占位文本且自动换行的TextView.gif)


### 监听键盘高度的评论框

- 核心代码:
```
- (void)replyViewAppear {
    if (self.replyView.isShow) {
        return;
    }
    [self.replyView showKeyboardType:0 content:@"评论" Block:^(NSString *contentStr) {
        NSLog(@"%@", contentStr);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_replyView) {
        [self.replyView close];
        self.replyView = nil;
    }
}
```

- 监听键盘高度的评论框效果图

![监听键盘高度的评论框](https://github.com/iOS-DeveloperTeam/UsuallyEncapsulation/blob/master/演示图/07监听键盘高度的评论框.gif)




# License

This repositorie is released under the under [MIT License](https://github.com/iOS-DeveloperTeam/UsuallyEncapsulation/blob/master/LICENSE)
