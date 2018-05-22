//
//  MDayCell.m
//  Demo_268EDU
//
//  Created by yizhilu on 2017/9/27.
//Copyright © 2017年 Magic. All rights reserved.
//

#import "MDayCell.h"
#import "MCalendarUtils.h"
#import "MCalendarView.h"
@interface MDayCell ()
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;


@end
@implementation MDayCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _dayLabel.clipsToBounds = YES;
    _dayLabel.layer.cornerRadius = 15;
}

- (void)setCellDate:(NSDate *)cellDate {
    _cellDate = cellDate;
    if (_type == CalendarType_Week) {
        [self showDateFunction];
    } else {
        if ([[MCalendarUtils manager] checkSameMonth:_cellDate AnotherMonth:_currentDate]) {
            [self showDateFunction];
        } else {
            [self showSpaceFunction];
        }
    }
    
}

//MARK: - otherMethod

- (void)showSpaceFunction {
    self.userInteractionEnabled = NO;
    _dayLabel.text = @"";
    _dayLabel.backgroundColor = [UIColor clearColor];
    _dayLabel.layer.borderWidth = 0;
    _dayLabel.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)showDateFunction {
    
    self.userInteractionEnabled = YES;
    NSString *day = [[MCalendarUtils manager] getStrFromDateFormat:@"d" Date:_cellDate];
    
    _dayLabel.text = day;
    _dayLabel.textColor = self.calendarConfig.normalTextColor ? self.calendarConfig.normalTextColor : [UIColor whiteColor] ;
    
    if ([[MCalendarUtils manager] isSameDate:_cellDate AnotherDate:[NSDate date]]) {
        _dayLabel.layer.borderWidth = 1.5;
        _dayLabel.layer.borderColor = self.calendarConfig.selectTextLayerColor != nil ? self.calendarConfig.selectTextLayerColor.CGColor : [UIColor whiteColor].CGColor;
    } else {
        _dayLabel.layer.borderWidth = 0;
        _dayLabel.layer.borderColor = [UIColor clearColor].CGColor;
    }
    if (_selectDate) {
        
        if ([[MCalendarUtils manager] isSameDate:_cellDate AnotherDate:_selectDate]) {
            //选中
            _dayLabel.backgroundColor = self.calendarConfig.selectTextBackgroundClolr ? self.calendarConfig.selectTextBackgroundClolr : [UIColor whiteColor];
            _dayLabel.textColor = self.calendarConfig.selectTextColor ? self.calendarConfig.selectTextColor : NNRGBColor(62, 131, 229);
            if (self.calendarConfig.isCalendarEvent) {
                _dayLabel.text = @"今";
            }
        } else {
            //不选中
            _dayLabel.backgroundColor = [UIColor clearColor];
            _dayLabel.textColor = self.calendarConfig.normalTextColor ? self.calendarConfig.normalTextColor : [UIColor whiteColor];
        }
    }
    NSString *currentDate = [[MCalendarUtils manager] getStrFromDateFormat:@"d" Date:_cellDate];
    if (_eventArray.count) {
        for (NSString *strDate in _eventArray) {
            if ([strDate isEqualToString:currentDate]) {
                
                _dayLabel.text = @"";
                _dayLabel.attributedText = [self createAttribute];
                
                break;
            }
        }
    }
    
}

-(NSMutableAttributedString *)createAttribute{
    NSMutableAttributedString *attri =     [[NSMutableAttributedString alloc] initWithString:@""];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:@"登录_选中"];
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, 20, 20);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri appendAttributedString:string];
    return attri;
}

@end
