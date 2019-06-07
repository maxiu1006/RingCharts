//
//  YDCircleProgressView.h
//  RingCharts
//
//  Created by xiaoxh on 2019/6/7.
//  Copyright © 2019 肖祥宏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RingModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YDCircleProgressView : UIView
@property (nonatomic, strong) UILabel *topTipLabel;
@property (nonatomic, strong) UILabel *bottomTipLabel;
/** 宽度 */
@property (nonatomic, assign) CGFloat progressWidth;
/** 是否顺时针 true 是 false否*/
@property (nonatomic, assign) BOOL isCricleWise;

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame progress:(CGFloat)progress;
- (void)progress:(NSArray*)resArray colrrArr:(NSArray<UIColor *>*)colorArr;
@end

NS_ASSUME_NONNULL_END
