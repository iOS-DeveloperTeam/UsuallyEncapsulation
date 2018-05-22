//
//  NNTextView.h
//  NNTextView
//
//  Created by 刘朋坤 on 17/3/23.
//  Copyright © 2017年 刘朋坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NNTextHeightChangedBlock)(CGFloat textViewHeight);

@interface NNTextView : UITextView

// 占位文字
@property (nonatomic, strong) NSString *placeholderText;
// 占位文字颜色
@property (nonatomic, strong) UIColor *placeholderColor;
// 最大行数
@property (nonatomic, assign) NSUInteger maxNumberOfLines;
// 设置圆角
@property (nonatomic, assign) NSUInteger cornerRadius;

@property (nonatomic, copy) NNTextHeightChangedBlock textChangedBlock;


- (void)textValueDidChanged:(NNTextHeightChangedBlock)textChangedBlock;

- (instancetype)initWithTextView:(UITextView *)textView;

@end
