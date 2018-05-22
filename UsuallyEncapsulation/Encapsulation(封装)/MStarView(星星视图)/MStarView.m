//
//  MStarView.m
//  Demo_268EDU
//
//  Created by yizhilu on 2017/9/27.
//Copyright © 2017年 Magic. All rights reserved.
//

#import "MStarView.h"
@interface MStarView ()
/**
 存放星星数组
 */
@property (nonatomic, strong)  NSMutableArray<UIButton *> *starArray;

@end

@implementation MStarView

-(instancetype)initWithFrame:(CGRect)frame starNumber:(NSInteger)starNmber starSpace:(CGFloat)space starNormal:(NSString *)normal starSelect:(NSString *)select{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat startHeight = self.frame.size.height;
        CGFloat starSpace = space > 0 ? space : 0;
        for (int i = 0; i < starNmber; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.userInteractionEnabled = NO;
            [self addSubview:button];
            [button setBackgroundImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:select] forState:UIControlStateSelected];
            button.frame = CGRectMake(0 + (startHeight + starSpace) * i, 0, startHeight, startHeight);
            [self.starArray addObject:button];
        }
    }
    return self;
}


-(void)setStarNumber:(NSInteger)starNumber{
    if (starNumber > self.starArray.count) {
        starNumber = self.starArray.count;
    }
    _starNumber = starNumber;
    for (int i = 0; i < starNumber; i++) {
        UIButton *button = self.starArray[i];
        button.selected = YES;
    }
}

#pragma mark - 懒加载
-(NSMutableArray<UIButton *> *)starArray{
    if (!_starArray) {
        _starArray = [NSMutableArray new];
    }
    return _starArray;
}

@end
