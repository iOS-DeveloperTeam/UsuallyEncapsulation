//
//  NNPickerView.m
//  UsuallyEncapsulation
//
//  Created by 刘朋坤 on 2018/8/19.
//  Copyright © 2018年 LiuPengKun. All rights reserved.
//

#import "NNPickerView.h"

static CGFloat bgViewHeith = 240;
static CGFloat cityPickViewHeigh = 200;
static CGFloat toolsViewHeith = 40;
static CGFloat animationTime = 0.25;

#define kFont(size) [UIFont systemFontOfSize:size]

@interface NNPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>

/** 选择器 */
@property (nonatomic, strong) UIPickerView *PickerView;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *sureButton;
/** 取消按钮 */
@property (nonatomic, strong) UIButton *canselButton;
/** 自定义标签栏 */
@property (nonatomic, strong) UIView *toolsView;
/** 背景view */
@property (nonatomic, strong) UIView *bgView;
/** 选择的Label */
@property (nonatomic, strong) UILabel *selectLalel;

@property (nonatomic,strong)NSArray *dataArr ;

@end

@implementation NNPickerView

- (NSArray *)titileArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr ;
}

- (instancetype)initWithDataArr:(NSArray *)arr{
    if (self = [super init]) {
        self.dataArr = arr ;
        [self initSubViews];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickView];
    }
}

#pragma mark - 布局区域
- (void)initSubViews {
    UIWindow *windowView = [UIApplication sharedApplication].delegate.window;
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    [windowView addSubview:self];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.toolsView];
    [self.toolsView addSubview:self.canselButton];
    [self.toolsView addSubview:self.sureButton];
    [self.toolsView addSubview:self.selectLalel];
    [self.bgView addSubview:self.PickerView];
    [self.PickerView selectRow:0 inComponent:0 animated:NO];
    self.selectString   = self.dataArr[0];
    self.selectLalel.text = self.selectString ;
    self.index   =   0 ;
    [self showPickView];
}

- (void)setSelectIndex:(NSInteger)index {
    [self.PickerView selectRow:index inComponent:0 animated:NO];
    self.selectLalel.text = self.dataArr[index] ;
    self.selectString = self.dataArr[index] ;
    self.index = index;
}

#pragma mark - 代理区域
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _dataArr.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    [label sizeToFit ];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.text =  self.dataArr[row];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.dataArr.count == 0) {
        return;
    }
    self.selectString = self.dataArr[row];
    self.selectLalel.text = self.selectString ;
    self.index = row ;
}

#pragma mark private methods  私有方法
/** 显示 */
- (void)showPickView {
    [UIView animateWithDuration:animationTime animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height - bgViewHeith, self.frame.size.width, bgViewHeith);
    } completion:^(BOOL finished) {
        
    }];
}

/** 隐藏 */
- (void)hidePickView {
    [UIView animateWithDuration:animationTime animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, bgViewHeith);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/** 取消 */
- (void)canselButtonClick {
    [self hidePickView];
}

/** 确定 */
- (void)sureButtonClick {
    if (self.selectString.length == 0) {
        return;
    }
    [self hidePickView];
    if (self.selectBlock) {
        self.selectBlock(self.selectString, _index);
    }
}

#pragma mark - 懒加载区域
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, bgViewHeith)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIPickerView *)PickerView {
    if (!_PickerView) {
        _PickerView = ({
            UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, toolsViewHeith, self.frame.size.width, cityPickViewHeigh)];
            pickerView.backgroundColor = [UIColor whiteColor];
            pickerView.delegate = self;
            pickerView.dataSource = self;
            pickerView;
        });
    }
    return _PickerView;
}

- (UIView *)toolsView {
    if (!_toolsView) {
        _toolsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, toolsViewHeith)];
        _toolsView.layer.borderWidth = 0.5;
        _toolsView.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _toolsView;
}

- (UIButton *)canselButton {
    if (!_canselButton) {
        _canselButton = ({
            UIButton *canselButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 50, toolsViewHeith)];
            [canselButton setTitle:@"取消" forState:UIControlStateNormal];
            [canselButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [canselButton addTarget:self action:@selector(canselButtonClick) forControlEvents:UIControlEventTouchUpInside];
            canselButton;
        });
    }
    return _canselButton;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = ({
            UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 20 - 50, 0, 50, toolsViewHeith)];
            [sureButton setTitle:@"确定" forState:UIControlStateNormal];
            [sureButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
            sureButton;
        });
    }
    return _sureButton;
}

- (UILabel *)selectLalel {
    if (!_selectLalel) {
        _selectLalel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width-100) / 2, 0, 100, toolsViewHeith)];
        _selectLalel.text = @"请选择";
        _selectLalel.font = kFont(14);
        _selectLalel.textAlignment = NSTextAlignmentCenter ;
    }
    return _selectLalel;
}

@end
