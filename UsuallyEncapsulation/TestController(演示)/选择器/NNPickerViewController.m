//
//  NNPickerViewController.m
//  UsuallyEncapsulation
//
//  Created by 刘朋坤 on 2018/8/19.
//  Copyright © 2018年 LiuPengKun. All rights reserved.
//

#import "NNPickerViewController.h"
#import "NNPickerView.h"

@interface NNPickerViewController ()

/** 选择器 */
@property (nonatomic, strong) NNPickerView *pickerView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation NNPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"请点击屏幕";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.pickerView = [[NNPickerView alloc] initWithDataArr:self.dataSource];
    [self.pickerView setSelectIndex:10];
    self.pickerView.selectBlock = ^(NSString *string, NSInteger index) {
        NSLog(@"string = %@ ,index = %ld", string,  index);
    };
}

#pragma mark - 懒加载区域
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (int i = 0; i < 30; i++) {
            NSString *string = [NSString stringWithFormat:@"元素 %d",i];
            [_dataSource addObject:string];
        }
    }
    return _dataSource;
}

@end
