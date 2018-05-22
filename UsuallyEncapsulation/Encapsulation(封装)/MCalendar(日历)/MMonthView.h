//
//  MMonthView.h
//  Demo_268EDU
//
//  Created by yizhilu on 2017/9/27.
//Copyright © 2017年 Magic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDayCell.h"
@class MCalendarViewConfig;
typedef void(^SendSelectDate)(NSDate *selDate);

@interface MMonthView : UIView

@property (nonatomic, strong) NSDate *currentDate;          //当前月份
@property (nonatomic, strong) NSDate *selectDate;           //选中日期
@property (nonatomic, copy) SendSelectDate sendSelectDate;  //回传选中日期
@property (nonatomic, assign) CalendarType type;            //日历模式
@property (nonatomic, strong) NSArray *eventArray;          //事件数组
/**
 日历字体样式设置
 */
@property (nonatomic, strong) MCalendarViewConfig *calendarConfig;


- (instancetype)initWithFrame:(CGRect)frame
                         Date:(NSDate *)date;

@end
