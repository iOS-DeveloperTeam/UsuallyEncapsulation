//
//  NNSlideTitleView.h
//  NNSlideTitleView
//
//  Created by yizhilu on 2018/5/12.
//  Copyright © 2018年 LiuPengKun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, NNSlideTitleViewType) {
    NNLineType = 0,            // 底部指示器
    NNBackgroundColorType,     // 变化背景色
};

typedef NS_ENUM (NSUInteger, NNSliderViewWidth) {
    NNButtonWidth = 0,         // 和按钮同宽
    NNTextWidth,               // 和按钮上的文本同宽
};

typedef NS_ENUM (NSUInteger, NNButtonCustomWidth) {
    NNAverageWidth = 0,        // 按钮平分 View 宽度
    NNCustomTextWidth,         // 按钮自适应文本
};

@protocol NNSlideTitleViewDelegate<NSObject>;
@optional
- (void)buttonSelectedWithIndex:(NSInteger)index;
@end

@interface NNSlideTitleView : UIView

/** 初始化*/
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

/** 按钮点击事件(传出按钮索引)*/
@property (nonatomic, copy) void (^buttonSelected)(NSInteger index);

/** 标签栏底部线条的长度(默认和按钮同宽)*/
@property (nonatomic, assign) NNSliderViewWidth sliderWidthType;

/** 标签类型(默认带下划线类型)*/
@property (nonatomic, assign) NNSlideTitleViewType slideTitleViewType;

/** 按钮宽度(默认是平分总宽度)*/
@property (nonatomic, assign) NNButtonCustomWidth buttonCustomWidth;

/** 未选中时按钮颜色(默认黑色)*/
@property (nonatomic, strong) UIColor *normalColor;

/** 选中时按钮颜色(默认红色)*/
@property (nonatomic, strong) UIColor *selectColor;

/** 点击变大的比例(默认1.0为正常大小)*/
@property (nonatomic, assign) CGFloat scale;

/** 按钮大小(默认15)*/
@property (nonatomic, assign) CGFloat buttonFont;

/** 选中第几个按钮*/
@property (nonatomic, assign) NSUInteger selectedTag;

/** 是否开启滑动效果(默认不开启)*/
@property (nonatomic, assign) BOOL scrollEnabled;

/**  按钮的背景色(默认白色) */
@property (nonatomic, strong) UIColor *buttonBackgroundColor;

/** 代理 */
@property (nonatomic, weak) id<NNSlideTitleViewDelegate> titleViewDelegate;

@end

@interface NNButton : UIButton

/** 点击变大*/
@property (nonatomic, assign) CGFloat scale;

@end
