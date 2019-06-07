//
//  YDCircleProgressView.m
//  RingCharts
//
//  Created by xiaoxh on 2019/6/7.
//  Copyright © 2019 肖祥宏. All rights reserved.
//

#import "YDCircleProgressView.h"

@interface YDCircleProgressView()

{
    /** 原点 */
    CGPoint _origin;
    /** 半径 */
    CGFloat _radius;
    /** 起始 */
    CGFloat _startAngle;
    /** 结束 */
    CGFloat _endAngle;
}

@end

@implementation YDCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame progress:(CGFloat)progress {
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

#pragma mark - 初始化页面
- (void)setUI {
    [self addSubview:self.topTipLabel];
    [self addSubview:self.bottomTipLabel];
    _origin = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    _radius = self.bounds.size.width / 2;
}
- (void)progress:(NSArray *)resArray colrrArr:(NSArray<UIColor *>*)colorArr
{
    _origin = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    _radius = self.bounds.size.width / 2;
    _startAngle = M_PI*3/2;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (DataListModel *model in resArray) {
        [array addObject:model.percent];
    }
    
    double mun = 0.0;
    for (NSInteger i = 0; i<array.count; i++) {
        _endAngle = _startAngle + [array[i] doubleValue] * M_PI * 2;
        UIColor *col;
        if (colorArr.count>i) {
            col = colorArr[i];
        }
        CAShapeLayer *topLayer = [CAShapeLayer layer];
        topLayer.fillColor = [UIColor clearColor].CGColor;
        topLayer.strokeColor = col.CGColor;;
        
        UIBezierPath *topPath = [UIBezierPath bezierPathWithArcCenter:_origin radius:_radius startAngle:_startAngle endAngle:_endAngle clockwise:YES];
        topLayer.path = topPath.CGPath;
        topLayer.lineWidth = self.progressWidth;
        [self.layer addSublayer:topLayer];
        //设置路径画布
        CAShapeLayer *topLineLayer = [CAShapeLayer layer];
        topLineLayer.lineWidth = 2.0;
        topLineLayer.strokeColor = col.CGColor; //   边线颜色
        topLineLayer.fillColor  = nil;
        if ([array[i] doubleValue]) {
            double du = M_PI*2*[array[i] doubleValue]/2;
            mun = mun + du;
            topLineLayer.path = [self getEndPointFrameWithProgress:mun percentage:[array[i] doubleValue] percentageLbColor:col].CGPath;
            [self.layer addSublayer:topLineLayer];
            mun = mun + du;
        }
        _startAngle = _endAngle;
    }
}
-(UIBezierPath*)getEndPointFrameWithProgress:(float)angle percentage:(CGFloat)percentage percentageLbColor:(UIColor*)percentageLbColor
{
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    float radius = _radius;//半径
    int index = (angle)/M_PI_2;//用户区分在第几象限内
    float needAngle = angle - index*M_PI_2;//用于计算正弦/余弦的角度
    float x = 0,y = 0;//用于保存_dotView的frame
    switch (index) {
            case 0:
            //NSLog(@"第一象限");
            x = radius + sinf(needAngle)*(radius+self.progressWidth/2);
            y = radius - cosf(needAngle)*(radius+self.progressWidth/2);
            break;
            case 1:
            //NSLog(@"第二象限");
            x = radius + cosf(needAngle)*(radius+self.progressWidth/2);
            y = radius + sinf(needAngle)*(radius+self.progressWidth/2);
            break;
            case 2:
            //NSLog(@"第三象限");
            x = radius - sinf(needAngle)*(radius+self.progressWidth/2);
            y = radius + cosf(needAngle)*(radius+self.progressWidth/2);
            break;
            case 3:
            //NSLog(@"第四象限");
            x = radius - cosf(needAngle)*(radius+self.progressWidth/2);
            y = radius - sinf(needAngle)*(radius+self.progressWidth/2);
            break;
        default:
            break;
    }
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.textColor = percentageLbColor;
    numLabel.font = [UIFont systemFontOfSize:12];
    if (percentage>0) {
        numLabel.text = [NSString stringWithFormat:@"%.2f%%",percentage*100];
        [self addSubview:numLabel];
    }
    CGPoint startPoint = CGPointMake(x, y);
    [linePath moveToPoint:startPoint];
    if (index == 0) {
        [linePath addLineToPoint:(CGPoint){startPoint.x+10,startPoint.y-10}];
        [linePath addLineToPoint:(CGPoint){startPoint.x+50,startPoint.y-10}];
        numLabel.frame = CGRectMake(startPoint.x+20, startPoint.y-15-10, 80, 10);
    }else if (index == 1){
        [linePath addLineToPoint:(CGPoint){startPoint.x+10,startPoint.y+10}];
        [linePath addLineToPoint:(CGPoint){startPoint.x+50,startPoint.y+10}];
        numLabel.frame = CGRectMake(startPoint.x+10, startPoint.y+15, 80, 10);
    }else if (index == 2){
        [linePath addLineToPoint:(CGPoint){startPoint.x-10,startPoint.y+10}];
        [linePath addLineToPoint:(CGPoint){startPoint.x-50,startPoint.y+10}];
        numLabel.frame = CGRectMake(startPoint.x-50, startPoint.y+15, 80, 10);
    }else{
        [linePath addLineToPoint:(CGPoint){startPoint.x-10,startPoint.y-10}];
        [linePath addLineToPoint:(CGPoint){startPoint.x-50,startPoint.y-10}];
        numLabel.frame = CGRectMake(startPoint.x-50, startPoint.y-15-10, 80, 10);
    }
    return  linePath;
}

#pragma mark - setMethod

- (void)setProgressWidth:(CGFloat)progressWidth {
    _progressWidth = progressWidth;
}

#pragma mark - 懒加载
- (UILabel *)topTipLabel {
    if (!_topTipLabel) {
        _topTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 17)];
        _topTipLabel.center = CGPointMake(self.bounds.size.width / 2 , self.bounds.size.height / 2 -12);
        _topTipLabel.textAlignment = NSTextAlignmentCenter;
        _topTipLabel.font = [UIFont systemFontOfSize:17];
        _topTipLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _topTipLabel;
}

- (UILabel *)bottomTipLabel {
    if (!_bottomTipLabel) {
        _bottomTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 17)];
        _bottomTipLabel.center = CGPointMake(self.bounds.size.width / 2 , self.bounds.size.height / 2 + 12);
        _bottomTipLabel.textAlignment = NSTextAlignmentCenter;
        _bottomTipLabel.font = [UIFont systemFontOfSize:17];
    }
    return _bottomTipLabel;
}


@end
