//
//  NNRunningLightView.m
//  NNRunningLightView
//
//  Created by 刘朋坤 on 2018/8/1.
//  Copyright © 2018年 刘朋坤. All rights reserved.
//

#import "NNRunningLightView.h"
@interface NNRunningLightView()

@property (nonatomic, strong) UILabel *runningLightLabel;

@property (nonatomic, strong) CADisplayLink *runninDisplayLink;

@property (nonatomic, assign) NSInteger count;

@end
@implementation NNRunningLightView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        [self stopMarquee];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    self.clipsToBounds = YES;
    [self addSubview:self.runningLightLabel];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(runningLightClick)];
    [self addGestureRecognizer:gecognizer];
}

- (void)setMarqueeTextArray:(NSArray *)marqueeTextArray {
    _marqueeTextArray = marqueeTextArray;
    if (_runninDisplayLink) {
        [self stopMarquee];
    }
    
    [self setMarqueeText:_marqueeTextArray.firstObject];
    
    CGRect frame = _runningLightLabel.frame;
    frame.origin.x = _runningLightLabel.superview.frame.size.width;
    _runningLightLabel.textAlignment = NSTextAlignmentLeft;
    _runningLightLabel.frame = frame;
    
    _count = 0;
    _runninDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshMarqueeLabelFrame)];
    [_runninDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)refreshMarqueeLabelFrame {
    CGRect frame = _runningLightLabel.frame;
    frame.origin.x -= 1;
    _runningLightLabel.frame = frame;
    if (_runningLightLabel.frame.origin.x + _runningLightLabel.frame.size.width <= 0) {
        _count++;
        CGRect frame = _runningLightLabel.frame;
        frame.origin.x = self.frame.size.width;
        _runningLightLabel.frame = frame;
        [self setMarqueeText:_marqueeTextArray[_count % self.marqueeTextArray.count]];
    }
}

- (void)runningLightClick {
    if (self.runningLightBlock) {
        self.runningLightBlock(_count % self.marqueeTextArray.count);
    }
}

- (void)stopMarquee {
    [self.runninDisplayLink invalidate];
    self.runninDisplayLink = nil;
}

/** 赋值 */
- (void)setMarqueeText:(NSString *)marqueeText {
    _runningLightLabel.text = marqueeText;
    [_runningLightLabel sizeToFit];
    CGFloat centerY = self.frame.size.height / 2.0;
    _runningLightLabel.center = CGPointMake(_runningLightLabel.center.x, centerY);
}

- (UILabel *)runningLightLabel {
    if (!_runningLightLabel) {
        _runningLightLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _runningLightLabel.font = [UIFont systemFontOfSize:14];
    }
    return _runningLightLabel;
}

@end
