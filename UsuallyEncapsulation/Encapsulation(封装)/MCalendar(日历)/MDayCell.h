//
//  MDayCell.h
//  Demo_268EDU
//
//  Created by yizhilu on 2017/9/27.
//Copyright © 2017年 Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const dayCellH = 40;//日期cell高度

/**
 日历类型:周,月
 
 - CalendarType_Week:  周类型
 - CalendarType_Month: 月类型
 */
typedef NS_ENUM(NSUInteger, CalendarType) {
    CalendarType_Week,
    CalendarType_Month,
};
@class MCalendarViewConfig;
@interface MDayCell : UICollectionViewCell

/**
 日历字体颜色背景设置
 */
@property (nonatomic, strong)  MCalendarViewConfig *calendarConfig;

@property (nonatomic, strong) NSDate *currentDate;  //当月或当周日期
@property (nonatomic, strong) NSDate *selectDate;   //选择日期
@property (nonatomic, strong) NSDate *cellDate;     //cell显示日期
@property (nonatomic, assign) CalendarType type;    //选择类型
@property (nonatomic, strong) NSArray *eventArray;  //事件数组

@end
