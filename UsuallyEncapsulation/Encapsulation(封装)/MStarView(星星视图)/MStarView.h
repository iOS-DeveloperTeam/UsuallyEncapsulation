//
//  MStarView.h
//  Demo_268EDU
//
//  Created by yizhilu on 2017/9/27.
//Copyright © 2017年 Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MStarView : UIView

/**
 创建星星视图

 @param frame 视图 frame
 @param starNmber  星星个数
 @param space 星星间距
 @param normal 灰色星星图片
 @param select 亮色星星图片
 @return return value description
 */
-(instancetype)initWithFrame:(CGRect)frame
                  starNumber:(NSInteger)starNmber
                   starSpace:(CGFloat)space
                  starNormal:(NSString *)normal
                  starSelect:(NSString *)select;

/**
 当前视图几颗星
 */
@property (nonatomic, assign)  NSInteger starNumber;


@end
