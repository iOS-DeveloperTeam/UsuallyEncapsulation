//
//  NNRunningLightView.h
//  NNRunningLightView
//
//  Created by 刘朋坤 on 2018/8/1.
//  Copyright © 2018年 刘朋坤. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^NNRunningLightBlock)(NSInteger index);

@interface NNRunningLightView : UIView

@property (nonatomic, copy) NSArray *marqueeTextArray;
@property (nonatomic, copy) NNRunningLightBlock runningLightBlock;

@end
