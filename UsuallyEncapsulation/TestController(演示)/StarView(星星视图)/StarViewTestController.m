//
//  StarViewTestController.m
//  UsuallyEncapsulation
//
//  Created by yizhilu on 2018/5/21.
//  Copyright © 2018年 LiuPengKun. All rights reserved.
//

#import "StarViewTestController.h"
#import "MStarView.h"

@interface StarViewTestController ()

@end

@implementation StarViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    MStarView *starView = [[MStarView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-47.5, 150, 15, 15) starNumber:5 starSpace:5 starNormal:@"课程反馈_灰色星星" starSelect:@"课程反馈_星星"];
    starView.starNumber = 2;
    [self.view addSubview:starView];
    
    
    MStarView *starView1 = [[MStarView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-47.5, 250, 15, 15) starNumber:5 starSpace:5 starNormal:@"课程反馈_灰色星星" starSelect:@"课程反馈_星星"];
    starView1.starNumber = 4;
    [self.view addSubview:starView1];
    
    
    MStarView *starView2 = [[MStarView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-95, 350, 15, 15) starNumber:10 starSpace:5 starNormal:@"课程反馈_灰色星星" starSelect:@"课程反馈_星星"];
    starView2.starNumber = 8;
    [self.view addSubview:starView2];
    
    
    MStarView *starView3 = [[MStarView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-95, 450, 15, 15) starNumber:6 starSpace:20 starNormal:@"课程反馈_灰色星星" starSelect:@"课程反馈_星星"];
    starView3.starNumber = 4;
    [self.view addSubview:starView3];
}

@end
