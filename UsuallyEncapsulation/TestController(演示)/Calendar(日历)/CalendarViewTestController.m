//
//  CalendarViewTestController.m
//  UsuallyEncapsulation
//
//  Created by yizhilu on 2018/5/21.
//  Copyright © 2018年 LiuPengKun. All rights reserved.
//

#import "CalendarViewTestController.h"
#import "MCalendarView.h"

@interface CalendarViewTestController ()

/**
 年月日右侧按钮
 */
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation CalendarViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 带有下拉效果的日历
    [self ableDownCalendar];
    // 普通显示日历
    [self noAbleDownCalendar];
}

/** 带有下拉效果的日历*/
- (void)ableDownCalendar {
    MCalendarViewConfig *config = [[MCalendarViewConfig alloc] init];
    config.backgroundViewName = @"免费讲座_背景";
    config.isHidesYearMonth = YES;
    config.isAbleDown = YES;
    MCalendarView *calendar = [[MCalendarView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, 100) Date:[NSDate date] Type:CalendarType_Week calendarConfig:config];
    calendar.sendSelectDate = ^(NSDate *selDate) {
        NSLog(@"%@", selDate);
    };
    __weak typeof(calendar) weakCalendar = calendar;
    calendar.refreshH = ^(CGFloat viewH) {
        [UIView animateWithDuration:0.3 animations:^{
            weakCalendar.frame = CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, viewH);
        }];
    };
    [self.view addSubview:calendar];
    
    // 导航栏右侧显示年月
    _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    _rightLabel.textColor = [UIColor blueColor];
    _rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel.text = [[MCalendarUtils manager] getStrFromDateFormat:@"yyyy年MM月" Date:[NSDate date]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightLabel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yearMothTextChange:) name:@"yearMothTextChanged" object:nil];
}

/** 普通显示日历*/
- (void)noAbleDownCalendar {
    MCalendarViewConfig *config = [[MCalendarViewConfig alloc] init];
    config.normalTextColor = [UIColor purpleColor];
    config.weakTextColor = [UIColor redColor];
    config.yeadMothTextColor = [UIColor brownColor];
    config.weekdays = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    config.isCalendarEvent = YES;
    config.noLeftRightSlide = YES;
    MCalendarView *siginCalendar = [[MCalendarView alloc] initWithFrame:CGRectMake(0, 300+SafeAreaTopHeight, SCREEN_WIDTH, [MCalendarView getMonthTotalHeight:[NSDate date] type:CalendarType_Month]) Date:[NSDate date] Type:CalendarType_Month calendarConfig:config];
    [self.view addSubview:siginCalendar];
}

- (void)yearMothTextChange:(NSNotification *)sender{
    NSDictionary *dic = [sender userInfo];
    _rightLabel.text = [dic objectForKey:@"yearMothText"];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
