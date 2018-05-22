//
//  ReplyViewTestController.m
//  UsuallyEncapsulation
//
//  Created by yizhilu on 2018/5/21.
//  Copyright © 2018年 LiuPengKun. All rights reserved.
//

#import "ReplyViewTestController.h"
#import "MReplyCommentView.h"

@interface ReplyViewTestController ()
/**评论键盘*/
@property (nonatomic, strong) MReplyCommentView *replyView;

@end

@implementation ReplyViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"评论" style:UIBarButtonItemStylePlain target:self action:@selector(replyViewAppear)];
}

- (void)replyViewAppear {
    if (self.replyView.isShow) {
        return;
    }
    [self.replyView showKeyboardType:0 content:@"评论" Block:^(NSString *contentStr) {
        NSLog(@"%@", contentStr);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_replyView) {
        [self.replyView close];
        self.replyView = nil;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.replyView endEditing:YES];
    [self.view endEditing:YES];
}

#pragma mark - 懒加载
- (MReplyCommentView *)replyView {
    if (!_replyView) {
        _replyView = [MReplyCommentView shareMKeyboard];
    }
    return _replyView;
}

@end
