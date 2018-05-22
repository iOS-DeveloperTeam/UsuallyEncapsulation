//
//  MCalendarView.m
//  Demo_268EDU
//
//  Created by yizhilu on 2017/9/25.
//  Copyright © 2017年 Magic. All rights reserved.
//

#import "MCalendarView.h"

static CGFloat const yearMonthHight = 30;   //年月高度
static CGFloat const weeksHeight = 30;       //周高度
#define ViewWidth self.frame.size.width     //当前视图宽度
#define ViewHeight self.frame.size.height    //当前视图高度

@interface MCalendarView ()
@property (nonatomic, strong) UILabel *yearMonthLabel; //年月label
@property (nonatomic, strong) UIScrollView *scrollView;//scrollview
@property (nonatomic, assign) CalendarType type;//选择类型
@property (nonatomic, strong) NSDate *currentDate;//当前月份
@property (nonatomic, strong) NSDate *selectDate;//选中日期
@property (nonatomic, strong) NSDate *tmpCurrentDate;//记录上下滑动日期
@property (nonatomic, assign)  BOOL isGotoNext;//是否可以跳转到下一周
@property (nonatomic, strong)  NSDate *mCurrentDate;//当天日期,不随视图滚动而改变
@property (nonatomic, strong) MMonthView *leftView;    //左侧日历
@property (nonatomic, strong) MMonthView *middleView;  //中间日历
@property (nonatomic, strong) MMonthView *rightView;   //右侧日历


@end

@implementation MCalendarView

-(instancetype)initWithFrame:(CGRect)frame Date:(NSDate *)date Type:(CalendarType)type calendarConfig:(MCalendarViewConfig *)config {
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        _currentDate = date;
        _selectDate = date;
        _mCurrentDate = date;
        _isGotoNext = NO;
        self.calendConfig = config;
        self.backgroundColor = [UIColor whiteColor];
        if (type == CalendarType_Week) {
            _tmpCurrentDate = date;
            _currentDate = [[MCalendarUtils manager] getLastdayOfTheWeek:date];
        }
        if (config.isAbleDown) {
            [self addSwipes];
        }
        [self settingViews];
    }
    return self;
}

//增加下拉上滑手势
- (void)addSwipes {
    UISwipeGestureRecognizer *swipUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideView:)];
    [swipUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self addGestureRecognizer:swipUp];
    
    UISwipeGestureRecognizer *swipDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideView:)];
    [swipDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self addGestureRecognizer:swipDown];
}

- (void)slideView:(UISwipeGestureRecognizer *)sender {
    
    if (sender.direction == UISwipeGestureRecognizerDirectionUp) {
        _tmpCurrentDate = _currentDate.copy;
        //上滑
        if (_type == CalendarType_Week) {
            return;
        }
        if (_selectDate && [[MCalendarUtils manager] checkSameMonth:_selectDate AnotherMonth:_currentDate]) {
            _currentDate = [[MCalendarUtils manager] getLastdayOfTheWeek:_selectDate];
            _middleView.currentDate = _currentDate;
            _leftView.currentDate = [[MCalendarUtils manager]getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
            _rightView.currentDate = [[MCalendarUtils manager]getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
        } else {
            //默认第一周
            _currentDate = [[MCalendarUtils manager] getLastdayOfTheWeek:[[MCalendarUtils manager] GetFirstDayOfMonth:_currentDate]];
            _middleView.currentDate = _currentDate;
            _leftView.currentDate = [[MCalendarUtils manager]getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
            _rightView.currentDate = [[MCalendarUtils manager]getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
        }
        self.type = CalendarType_Week;
    } else if (sender.direction == UISwipeGestureRecognizerDirectionDown) {
        //下滑
        if (_type == CalendarType_Month) {
            return;
        }
        //选中最后一行再上滑需要这个判断
        if (![[MCalendarUtils manager] checkSameMonth:_tmpCurrentDate AnotherMonth:_currentDate]) {
            _currentDate = _tmpCurrentDate.copy;
        }
        _type = CalendarType_Month;
        [self setData];
        [self scrollToCenter];
    }
}

- (void)settingViews {
    [self settingBackgroundView];
    [self settingHeadLabel];
    [self settingScrollView];
    [self addObserver];
}

-(void)settingBackgroundView{
    if (self.calendConfig.backgroundViewName) {
        _backGroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_backGroundView];
        _backGroundView.image = [UIImage imageNamed:self.calendConfig.backgroundViewName];
    }
}

- (void)settingHeadLabel {
    _yearMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, yearMonthHight)];
    _yearMonthLabel.text = [[MCalendarUtils manager] getStrFromDateFormat:@"yyyy年MM月" Date:_currentDate];
    _yearMonthLabel.textAlignment = NSTextAlignmentCenter;
    _yearMonthLabel.textColor = self.calendConfig.yeadMothTextColor ? self.calendConfig.yeadMothTextColor : [UIColor whiteColor];
    _yearMonthLabel.font = [UIFont systemFontOfSize:self.calendConfig.yeadMothTextFontSize ? self.calendConfig.yeadMothTextFontSize : 17];
    if (!self.calendConfig.isHidesYearMonth) {
        [self addSubview:_yearMonthLabel];
    }
    NSArray *weekdays = nil;
    if (self.calendConfig.weekdays) {
        weekdays = self.calendConfig.weekdays;
    }else{
        weekdays = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    }
 
    CGFloat weekdayW = ViewWidth / 7;
    for (int i = 0; i < 7; i++) {
        UILabel *weekL = [[UILabel alloc] initWithFrame:CGRectMake(i*weekdayW,self.calendConfig.isHidesYearMonth ? 10 : 40, weekdayW, weeksHeight)];
        weekL.textColor = self.calendConfig.weakTextColor ? self.calendConfig.weakTextColor : [UIColor whiteColor];
        weekL.textAlignment = NSTextAlignmentCenter;
        weekL.font = [UIFont systemFontOfSize:15];
        weekL.text = weekdays[i];
        [self addSubview:weekL];
    }
}

- (void)settingScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  self.calendConfig.isHidesYearMonth ? 50 : 80, ViewWidth, ViewHeight - yearMonthHight - weeksHeight)];
    _scrollView.contentSize = CGSizeMake(ViewWidth * 3, 0);
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    if (self.calendConfig.noLeftRightSlide) {
        _scrollView.scrollEnabled = NO;
    }
    [self addSubview:_scrollView];
    
    __weak typeof(self) weakSelf = self;
    CGFloat height = 6 * dayCellH;
    _leftView = [[MMonthView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, height) Date:
    _type == CalendarType_Month ? [[MCalendarUtils manager] getPreviousMonth:_currentDate] :[[MCalendarUtils manager]getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2]];
    _leftView.type = _type;
    _leftView.calendarConfig = self.calendConfig;
    _leftView.selectDate = _selectDate;
    
    _middleView = [[MMonthView alloc] initWithFrame:CGRectMake(ViewWidth, 0, ViewWidth, height) Date:_currentDate];
    _middleView.type = _type;
    _middleView.calendarConfig = self.calendConfig;
    _middleView.selectDate = _selectDate;
    _middleView.sendSelectDate = ^(NSDate *selDate) {
        weakSelf.selectDate = selDate;
        if (weakSelf.sendSelectDate) {
            weakSelf.sendSelectDate(selDate);
        }
        [weakSelf setData];
    };
    
    _rightView = [[MMonthView alloc] initWithFrame:CGRectMake(ViewWidth * 2, 0, ViewWidth, height) Date:
    _type == CalendarType_Month ? [[MCalendarUtils manager] getNextMonth:_currentDate] : [[MCalendarUtils manager]getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2]];
    _rightView.type = _type;
    _rightView.calendarConfig = self.calendConfig;
    _rightView.selectDate = _selectDate;
    
    [_scrollView addSubview:_leftView];
    [_scrollView addSubview:_middleView];
    [_scrollView addSubview:_rightView];
    
    [self scrollToCenter];
}

- (void)setData {
    if (_type == CalendarType_Month) {
        _middleView.currentDate = _currentDate;
        _middleView.selectDate = _selectDate;
        _leftView.currentDate = [[MCalendarUtils manager] getPreviousMonth:_currentDate];
        _leftView.selectDate = _selectDate;
        _rightView.currentDate = [[MCalendarUtils manager] getNextMonth:_currentDate];
        _rightView.selectDate = _selectDate;
    } else {
        _middleView.currentDate = _currentDate;
        _middleView.selectDate = _selectDate;
        _leftView.currentDate = [[MCalendarUtils manager] getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
        _leftView.selectDate = _selectDate;
        _rightView.currentDate = [[MCalendarUtils manager] getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
        _rightView.selectDate = _selectDate;
    }
    self.type = _type;
}

//MARK: - kvo
- (void)addObserver {
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self monitorScroll];
    }
}

- (void)monitorScroll {
    if (_scrollView.contentOffset.x > 2 * ViewWidth -1) {
        
        if (_type == CalendarType_Month) {
            //左滑,下个月
            if (_isGotoNext) {
                
                //现在计算当前时间是不是已经在中间视图了
                BOOL month = [[MCalendarUtils manager]checkSameMonth:[[MCalendarUtils manager] getNextMonth:_currentDate] AnotherMonth:_mCurrentDate];
                if (month) {
                    _isGotoNext = NO;
                }else{
                    _isGotoNext = YES;
                }
                _middleView.currentDate = [[MCalendarUtils manager] getNextMonth:_currentDate];
                _middleView.selectDate = _selectDate;
                _leftView.currentDate = _currentDate;
                _leftView.selectDate = _selectDate;
                _currentDate = [[MCalendarUtils manager] getNextMonth:_currentDate];
                _rightView.currentDate = [[MCalendarUtils manager] getNextMonth:_currentDate];
                _rightView.selectDate = _selectDate;
                _yearMonthLabel.text = [[MCalendarUtils manager] getStrFromDateFormat:@"yyyy年MM月" Date:_currentDate];
                
                [self scrollToCenter];
            }else{
                [_scrollView setContentOffset:CGPointMake(ViewWidth, 0) animated:YES];
            }
            
        } else {
            //下周
            if (_isGotoNext) {
                _middleView.currentDate = [[MCalendarUtils manager] getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
                _middleView.selectDate = _selectDate;
                _leftView.currentDate = _currentDate;
                _leftView.selectDate = _selectDate;
                _currentDate = [[MCalendarUtils manager] getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
                _tmpCurrentDate = _currentDate.copy;
                _rightView.currentDate = [[MCalendarUtils manager] getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
                _rightView.selectDate = _selectDate;
                _yearMonthLabel.text = [[MCalendarUtils manager] getStrFromDateFormat:@"yyyy年MM月" Date:_currentDate];
                [self scrollToCenter];
                //现在计算当前时间是不是已经在中间视图了
                BOOL isWeak = [[MCalendarUtils manager]isSameDate:_currentDate AnotherDate:[[MCalendarUtils manager] getLastdayOfTheWeek:_mCurrentDate]];
                if (isWeak) {
                    _isGotoNext = NO;
                }else{
                    _isGotoNext = YES;
                }
                
            }else{
                [_scrollView setContentOffset:CGPointMake(ViewWidth, 0) animated:YES];
            }
            
        }
        
        self.type = _type;
        
    } else if (_scrollView.contentOffset.x < 1) {
        
        if (_type == CalendarType_Month) {
            //右滑,上个月
            _isGotoNext = YES;
            _middleView.currentDate = [[MCalendarUtils manager] getPreviousMonth:_currentDate];
            _middleView.selectDate = _selectDate;
            _rightView.currentDate = _currentDate;
            _rightView.selectDate = _selectDate;
            _currentDate = [[MCalendarUtils manager] getPreviousMonth:_currentDate];
            _leftView.currentDate = [[MCalendarUtils manager] getPreviousMonth:_currentDate];
            _leftView.selectDate = _selectDate;
            _yearMonthLabel.text = [[MCalendarUtils manager] getStrFromDateFormat:@"yyyy年MM月" Date:_currentDate];
        } else {
            //上周
            _isGotoNext = YES;
            _middleView.currentDate = [[MCalendarUtils manager] getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
            _middleView.selectDate = _selectDate;
            _rightView.currentDate = _currentDate;
            _rightView.selectDate = _selectDate;
            _currentDate = [[MCalendarUtils manager] getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
            _tmpCurrentDate = _currentDate.copy;
            _leftView.currentDate = [[MCalendarUtils manager] getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
            _leftView.selectDate = _selectDate;
            _yearMonthLabel.text = [[MCalendarUtils manager] getStrFromDateFormat:@"yyyy年MM月" Date:_currentDate];
        }
        
        [self scrollToCenter];
        self.type = _type;
        
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[[MCalendarUtils manager] getStrFromDateFormat:@"yyyy年MM月" Date:_currentDate] forKey:@"yearMothText"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"yearMothTextChanged" object:nil userInfo:dic];
}

//MARK: - scrollViewMethod
- (void)scrollToCenter {
    _scrollView.contentOffset = CGPointMake(ViewWidth, 0);
}

-(void)reloadFromCalendarEvent:(NSArray *)data{
    if (self.calendConfig.isCalendarEvent) {
        _middleView.eventArray = data.mutableCopy;
    }
}

- (void)dealloc{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

-(void)setCalendConfig:(MCalendarViewConfig *)calendConfig{
    _calendConfig = calendConfig;
}

-(void)setType:(CalendarType)type {
    _type = type;
    _middleView.type = type;
    _leftView.type = type;
    _rightView.type = type;
    
    if (type == CalendarType_Week) {
        //周
        if (_refreshH) {
            if (ViewHeight == dayCellH + yearMonthHight + weeksHeight) {
                return;
            }
            _refreshH(dayCellH + yearMonthHight + weeksHeight);
            __weak typeof(_scrollView) weakScroll = _scrollView;
            [UIView animateWithDuration:0.3 animations:^{
                weakScroll.frame = CGRectMake(0, yearMonthHight + weeksHeight, ViewWidth, dayCellH);
                self.backGroundView.frame = CGRectMake(0, 0, SCREEN_WIDTH, dayCellH + yearMonthHight + weeksHeight);
            }];
        }
    } else {
        //月
        if (_refreshH) {
            CGFloat viewH = [MCalendarView getMonthTotalHeight:_currentDate type:CalendarType_Month];
            if (viewH == ViewHeight) {
                return;
            }
            
            _refreshH(viewH);
            __weak typeof(_scrollView) weakScroll = _scrollView;
            [UIView animateWithDuration:0.3 animations:^{
                weakScroll.frame = CGRectMake(0, yearMonthHight + weeksHeight, ViewWidth, viewH - yearMonthHight - weeksHeight);
                self.backGroundView.frame = CGRectMake(0, 0, SCREEN_WIDTH, viewH);
            }];
        }
    }
    
}

+ (CGFloat)getMonthTotalHeight:(NSDate *)date type:(CalendarType)type {
    if (type == CalendarType_Week) {
        return yearMonthHight + weeksHeight + dayCellH;
    } else {
        NSInteger rows = [[MCalendarUtils manager] getRows:date];
        return yearMonthHight + weeksHeight + rows * dayCellH;
    }
}

@end

@implementation MCalendarViewConfig

@end
