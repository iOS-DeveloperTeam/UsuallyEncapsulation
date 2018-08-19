//
//  ViewController.m
//  UsuallyEncapsulation
//
//  Created by yizhilu on 2018/5/21.
//  Copyright © 2018年 LiuPengKun. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
/** title 数组**/
@property (nonatomic,copy) NSArray *titleArray;
/** 控制器数组 */
@property (nonatomic, copy) NSArray *classNames;

@end

@implementation ViewController
static NSString *UITableViewCellID = @"UITableViewCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

#pragma mark - 代理区域
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.navigationItem.title = self.titleArray[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

#pragma mark - 懒加载区域
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = NNRGBColor(200, 200, 200);
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewCellID];
    }
    return _tableView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"星星视图", @"多页面控制器的头部视图", @"日历", @"圆形验证码", @"随机图片验证码", @"带占位文本且自动换行的TextView", @"监听键盘高度的评论框", @"跑马灯效果", @"选择器"];
    }
    return _titleArray;
}

- (NSArray *)classNames {
    if (!_classNames) {
        _classNames = @[@"StarViewTestController", @"SlideTitleViewTestController", @"CalendarViewTestController", @"ValidationCodeViewTestController", @"ValidationViewTestController", @"TextViewTestController", @"ReplyViewTestController", @"NNRunningLightController", @"NNPickerViewController"];
    }
    return _classNames;
}

@end
