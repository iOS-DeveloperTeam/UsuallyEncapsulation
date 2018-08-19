//
//  NNPickerView.h
//  UsuallyEncapsulation
//
//  Created by 刘朋坤 on 2018/8/19.
//  Copyright © 2018年 LiuPengKun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^NNSelectBlock)(NSString *string, NSInteger index);

@interface NNPickerView : UIView

- (instancetype)initWithDataArr:(NSArray *)arr;

@property (nonatomic, copy) NNSelectBlock selectBlock ;
/** 选择的元素字符串 */
@property (nonatomic, copy) NSString *selectString;
/** 选择元素的角标 */
@property (nonatomic, assign) NSInteger index;
/** 默认那个角标 */
- (void)setSelectIndex:(NSInteger)index;

@end
