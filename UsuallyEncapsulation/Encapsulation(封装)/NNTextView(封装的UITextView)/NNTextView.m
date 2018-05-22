//
//  NNTextView.m
//  NNTextView
//
//  Created by 刘朋坤 on 17/3/23.
//  Copyright © 2017年 刘朋坤. All rights reserved.
//

#import "NNTextView.h"
@interface NNTextView()

@property (nonatomic, weak) UITextView *placeholderView;
// 文字高度
@property (nonatomic, assign) CGFloat currentTextHeight;
// 文字最大高度
@property (nonatomic, assign) CGFloat maxTextHeight;
// 文字原始高度
@property (nonatomic, assign) CGFloat originTextHeight;

@end

@implementation NNTextView

- (UITextView *)placeholderView {
    if (!_placeholderView ) {
        UITextView *placeholderView = [[UITextView alloc] initWithFrame:self.bounds];
        _placeholderView = placeholderView;
        _originTextHeight = self.bounds.size.height;
        _placeholderView.userInteractionEnabled = NO;
        _placeholderView.font = self.font;
        _placeholderView.textColor = [UIColor lightGrayColor];
        _placeholderView.backgroundColor = [UIColor clearColor];
        [self addSubview:placeholderView];
    }
    return _placeholderView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.scrollEnabled = NO;
        self.scrollsToTop = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (instancetype)initWithTextView:(UITextView *)textView {
    if (self) {
        self = (NNTextView *)textView;
        self.scrollEnabled = NO;
        self.scrollsToTop = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textValueDidChange {
    _placeholderView.hidden = self.text.length > 0 ? YES : NO;
    CGFloat tempHeight = ceil([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    if (self.currentTextHeight != tempHeight && tempHeight > self.originTextHeight) {
        self.scrollEnabled = (tempHeight > self.maxTextHeight && self.maxTextHeight > 0) ? YES : NO;
        self.currentTextHeight = tempHeight;
        if (_textChangedBlock && self.scrollEnabled == NO) {
            _textChangedBlock(tempHeight);
        }
    }
}

- (void)textValueDidChanged:(NNTextHeightChangedBlock)textChangedBlock{
    _textChangedBlock = textChangedBlock;
}

- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines {
    _maxNumberOfLines = maxNumberOfLines;
    if (!self.font.lineHeight) {
        self.font = [UIFont systemFontOfSize:17];
    }
    self.maxTextHeight = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
}

- (void)setCornerRadius:(NSUInteger)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setPlaceholderText:(NSString *)placeholderText {
    self.placeholderView.text = placeholderText;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    self.placeholderView.textColor = placeholderColor;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
