//
//  NNSlideTitleView.m
//  NNSlideTitleView
//
//  Created by yizhilu on 2018/5/12.
//  Copyright © 2018年 LiuPengKun. All rights reserved.
//

#import "NNSlideTitleView.h"
#import <Masonry.h>

#define NNWeakSelf __weak typeof(self) weakSelf = self;

@interface NNSlideTitleView()

/** 标签栏底部的指示器*/
@property (nonatomic, strong) UIView *sliderLineView;

/** 按钮文本数组*/
@property (nonatomic, copy) NSArray *titleArray;

/** 按钮数组*/
@property (nonatomic, copy) NSMutableArray *buttonArray;

/** 把所有视图放在 UIScrollView 中*/
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation NNSlideTitleView

#pragma mark - 初始化区域
/** 初始化*/
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.slideTitleViewType = NNLineType;
        self.sliderWidthType = NNButtonWidth;
        self.buttonCustomWidth = NNAverageWidth;
        self.titleArray = titleArray;
        self.normalColor = [UIColor blackColor];
        self.selectColor = [UIColor blueColor];
        self.buttonFont = 15;
        self.scrollEnabled = NO;
        self.scale = 1.0;
        self.selectedTag = 0;
        self.buttonBackgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    NNWeakSelf
    __block CGFloat buttonW = self.scrollView.frame.size.width / _titleArray.count;
    __block CGFloat buttonX = 10;
    [_titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NNButton *titleButton = [self creatButtonWithTitle:weakSelf.titleArray[idx]];
        titleButton.tag = idx;
        [weakSelf.scrollView addSubview:titleButton];
        [weakSelf.buttonArray addObject:titleButton];
        if (weakSelf.buttonCustomWidth == NNCustomTextWidth) {
            buttonW = [self boundingRectWithContentString:self.titleArray[idx] size:CGSizeMake(MAXFLOAT, weakSelf.scrollView.frame.size.height)].width;
            if (idx > 0) {
                CGFloat lastWidth = [self boundingRectWithContentString:self.titleArray[idx-1] size:CGSizeMake(MAXFLOAT, weakSelf.scrollView.frame.size.height)].width;
                buttonX = buttonX + lastWidth + 30;
            }
            titleButton.frame = CGRectMake(buttonX, 5, buttonW + 15, self.scrollView.frame.size.height-10);
        } else {
            titleButton.frame = CGRectMake(buttonX + (buttonW-5) * idx, 5, buttonW-15, self.scrollView.frame.size.height-10);
        }
        if (self.slideTitleViewType == NNBackgroundColorType) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:titleButton.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:titleButton.bounds.size];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            // 设置大小
            maskLayer.frame = titleButton.bounds;
            // 设置图形样子
            maskLayer.path = maskPath.CGPath;
            titleButton.layer.mask = maskLayer;
            titleButton.backgroundColor = idx == self.selectedTag ? self.buttonBackgroundColor : [UIColor whiteColor];
        }
        
        if (idx == self.selectedTag) {
            titleButton.scale = self.scale;
            titleButton.selected = YES;
        } else {
            titleButton.selected = NO;
        }
    }];
    NNButton *lastButton = self.buttonArray[self.buttonArray.count-1];
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastButton.frame)+15, self.scrollView.frame.size.height);
    if (self.slideTitleViewType == NNLineType) {
        [self createSliderLineView:buttonW];
    }
    if (CGRectGetMaxX(lastButton.frame) > SCREEN_WIDTH) {
        self.scrollEnabled = YES;
    }
    
    if (self.selectedTag < self.buttonArray.count) {
        if (self.scrollEnabled) {
            // 第一次进入时, 如果显示位置不居中, 强制居中
            [self slidingViewWithSelectedTag:self.selectedTag];
        }
    } else {
        NSLog(@"索引超过数组长度");
    }
}

/** 标签栏底部的指示器*/
- (void)createSliderLineView:(CGFloat)buttonW {
    if (self.buttonArray.count<=0) {
        NSLog(@"数组为空");
        return;
    }
    
    if (self.sliderWidthType == NNTextWidth || self.buttonCustomWidth == NNCustomTextWidth) {
        buttonW = [self boundingRectWithContentString:self.titleArray[self.selectedTag] size:CGSizeMake(MAXFLOAT, self.scrollView.frame.size.height)].width;
    }
    
    NNButton *selectedButton = self.buttonArray[self.selectedTag];
    [self.scrollView addSubview:self.sliderLineView];
    [self.sliderLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(buttonW);
        make.height.mas_equalTo(2);
        make.centerX.equalTo(selectedButton);
        make.bottom.equalTo(self).offset(-1);
    }];
}

#pragma mark - 事件区域
/** 按钮点击事件 */
- (void)titleButtonClicked:(NNButton *)sender {
    [self.buttonArray enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NNButton *button = self.buttonArray[idx];
        if (idx == sender.tag) {
            button.scale = self.scale;
            button.selected = YES;
            button.backgroundColor = self.slideTitleViewType == NNBackgroundColorType ? self.buttonBackgroundColor : [UIColor whiteColor];
        } else {
            button.scale = 1.0;
            button.selected = NO;
            button.backgroundColor = [UIColor whiteColor];
        }
    }];
    
    // block
    if (self.buttonSelected) {
        self.buttonSelected(sender.tag);
    }
    
    // 代理
    if (self.titleViewDelegate && [self.titleViewDelegate respondsToSelector:@selector(buttonSelectedWithIndex:)]) {
        [self.titleViewDelegate buttonSelectedWithIndex:sender.tag];
    }
    
    if (self.scrollEnabled) {
        // 滚动标题栏
        [self slidingViewWithSelectedTag:sender.tag];
    }
    
    if (self.slideTitleViewType == NNLineType) {
        CGFloat width;
        if (self.sliderWidthType == NNTextWidth  || self.buttonCustomWidth == NNCustomTextWidth) {
            width = [self boundingRectWithContentString:self.titleArray[sender.tag] size:CGSizeMake(MAXFLOAT, sender.frame.size.height)].width;
        } else {
            width = self.scrollView.frame.size.width / _titleArray.count;
        }
        
        [self.sliderLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(2);
            make.centerX.equalTo(sender);
            make.bottom.equalTo(self).offset(-1);
        }];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}

/** 滚动标题栏*/
- (void)slidingViewWithSelectedTag:(NSInteger)selectedTag {
    NNButton *selectedButton = self.buttonArray[selectedTag];
    CGFloat offsetx = selectedButton.center.x - self.scrollView.frame.size.width * 0.5;
    CGFloat offsetMax = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    CGPoint offset = CGPointMake(offsetx, self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)setSelectedTag:(NSUInteger)selectedTag {
    _selectedTag = selectedTag;
    if (self.buttonArray && self.self.buttonArray.count > selectedTag) {
        NNButton *button = self.buttonArray[selectedTag];
        [self titleButtonClicked:button];
    }
}

#pragma mark - 封装的一些私有方法
/** 创建按钮 */
- (NNButton *)creatButtonWithTitle:(NSString *)title {
    NNButton* titleButton       = [[NNButton alloc] init];
    [titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:_buttonFont];
    [titleButton setTitleColor:_normalColor forState:UIControlStateNormal];
    [titleButton setTitleColor:_selectColor forState:UIControlStateSelected];
    [titleButton setAdjustsImageWhenHighlighted:NO];
    [titleButton setTitle:title forState:UIControlStateNormal];
    return titleButton;
}

/** 计算文本尺寸*/
- (CGSize)boundingRectWithContentString:(NSString *)contentString size:(CGSize)size {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:_buttonFont]};
    CGSize retSize = [contentString boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return retSize;
}


#pragma mark - 懒加载区域
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.scrollEnabled = self.scrollEnabled;
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _scrollView;
}

/** 按钮下边的横线*/
- (UIView *)sliderLineView {
    if (!_sliderLineView) {
        UIView *sliderLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 1)];
        sliderLineView.backgroundColor = _selectColor;
        sliderLineView.layer.cornerRadius = 2;
        sliderLineView.clipsToBounds = YES;
        _sliderLineView = sliderLineView;
    }
    return _sliderLineView;
}

/** 装载按钮的容器*/
- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

@end


@implementation NNButton

/** 设置按钮字体变大*/
- (void)setScale:(CGFloat)scale {
    _scale = scale;
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(scale, scale);
    }];
}

/** 重写此方法, 禁止按钮长按高亮*/
- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
