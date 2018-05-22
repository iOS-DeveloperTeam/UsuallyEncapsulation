//
//  MCalendarView.h
//  Demo_268EDU
//
//  Created by yizhilu on 2017/9/25.
//  Copyright © 2017年 Magic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMonthView.h"
#import "MCalendarUtils.h"
@class MCalendarViewConfig;


/**
 刷新控件高度

 @param viewH 当前 view 的高度
 */
typedef void(^RefreshHight)(CGFloat viewH);

@interface MCalendarView : UIView

/**
 日历配置
 */
@property (nonatomic, strong)  MCalendarViewConfig *calendConfig;


@property (nonatomic, copy) SendSelectDate sendSelectDate;  //回传选择日期
/**
 滑动时更新控件高度
 */
@property (nonatomic, copy) RefreshHight refreshH;
/**
 背景图
 */
@property (nonatomic, strong)  UIImageView *backGroundView;
/**
 根据日期获取控件总高度
 
 @param date 日期
 @param type 类型
 @return return value description
 */
+ (CGFloat)getMonthTotalHeight:(NSDate *)date type:(CalendarType)type;

/**
 初始化日历方法

 @param frame 控件尺寸,高度可以调用该类计算方法计算
 @param date 日期
 @param type 类型
 @param config 日历配置信息
 @return 日历
 */
- (instancetype)initWithFrame:(CGRect)frame
                         Date:(NSDate *)date
                         Type:(CalendarType)type
               calendarConfig:(MCalendarViewConfig *)config;

- (void)reloadFromCalendarEvent:(NSArray *)data;

@end

@interface MCalendarViewConfig : NSObject

/**
 是否能下拉
 */
@property (nonatomic, assign) BOOL isAbleDown;
/**
 是否能左右滑动
 */
@property (nonatomic, assign) BOOL noLeftRightSlide;
/**
 是否有事件显示
 */
@property (nonatomic, assign) BOOL isCalendarEvent;

/**
 是否显示年月label
 */
@property (nonatomic, assign) BOOL isHidesYearMonth;
/**
 背景图片
 */
@property (nonatomic, strong) NSString *backgroundViewName;
/**
 年月日文字颜色
 */
@property (nonatomic, strong) UIColor *yeadMothTextColor;
/**
 周日-周六文字颜色
 */
@property (nonatomic, strong) UIColor *weakTextColor;

/**
 日历文字颜色
 */
@property (nonatomic, strong) UIColor *normalTextColor;
/**
 日历被选中文字颜色
 */
@property (nonatomic, strong) UIColor *selectTextColor;

/**
 日历文字选中背景颜色
 */
@property (nonatomic, strong) UIColor *selectTextBackgroundClolr;

/**
 日历选中边框颜色
 */
@property (nonatomic, strong) UIColor *selectTextLayerColor;

/**
 日历文字大小
 */
@property (nonatomic, assign) CGFloat textFontSize;
/**
 年月日文字大小
 */
@property (nonatomic, assign) CGFloat yeadMothTextFontSize;
/**
 周日-周六格式||日-六
 */
@property (nonatomic, strong) NSArray *weekdays;

@end
