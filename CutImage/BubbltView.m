//
//  BubbltView.m
//  CutImage
//
//  Created by Peyton on 2018/4/17.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "BubbltView.h"
@interface BubbltView ()
//贝塞尔曲线的最大高度
@property (nonatomic, assign)CGFloat maxHeight;
//贝塞尔曲线的最大宽度
@property (nonatomic, assign)CGFloat maxWidth;
//frame
@property (nonatomic, assign)CGRect originFrame;
//泡泡的初始位置
@property (nonatomic, assign)CGPoint originPoint;
//泡泡从左侧开始还是从右侧开始往上冒
@property (nonatomic, assign)BubbleKeypathType pathType;
//每一次动画执行的最大高度和最大宽度
@property (nonatomic, assign)CGFloat nowMaxHeight;

@property (nonatomic, assign)CGFloat nowMaxWidth;

@end


@implementation BubbltView

- (instancetype)initWithMaxHeight:(CGFloat)maxHeight maxWidth:(CGFloat)maxWidth maxFrame:(CGRect)frame andSuperView:(UIView *)superView {
    self = [[BubbltView alloc]initWithImage:[UIImage imageNamed:@"bubble"]];
    
    self.originFrame = frame;
    self.frame = [self getRandomFrameWithFrame:frame];
    self.originPoint = frame.origin;
    //为什么????????????????
    [superView addSubview:self];
    //设置上升路径的最大高度和最大宽度
    self.maxWidth = maxWidth;
    self.maxHeight = maxHeight;
    self.alpha = [self makeRandomNumberFromMin:0.5 toMax:1];
    //随机选择上升方式
    [self getRandomBubbltKeypathType];
    //每一次动画执行的最大高度和最大宽度
    [self getRandomPathWidthAndHeight];
    [self setUpBezierPath];
    return self;
}
//绘制贝塞尔曲线方法
- (void)setUpBezierPath
{
    //开始绘制泡泡的贝塞尔曲线
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:self.originPoint];
    [[UIColor brownColor] set];
    [bezierPath fill];
    
    if (self.pathType == BubbltKeypathLeft) {
        CGPoint leftControllPoint = CGPointMake(self.originPoint.x - self.nowMaxWidth / 2, self.originPoint.y - self.nowMaxHeight / 4);
        CGPoint rightControllPoint = CGPointMake(self.originPoint.x + self.nowMaxWidth / 2, self.originPoint.y - self.nowMaxHeight *3 / 4);
        CGPoint termalPoint = CGPointMake(self.originPoint.x, self.originPoint.y - self.nowMaxHeight);
        
        [bezierPath addCurveToPoint:termalPoint controlPoint1:leftControllPoint controlPoint2:rightControllPoint];
    }else{
        CGPoint leftControllPoint = CGPointMake(self.originPoint.x - self.nowMaxWidth / 2, self.originPoint.y - self.nowMaxHeight * 3 / 4);
        CGPoint rightControllPoint = CGPointMake(self.originPoint.x + self.nowMaxWidth / 2, self.originPoint.y - self.nowMaxHeight / 4);
        CGPoint termalPoint = CGPointMake(self.originPoint.x, self.originPoint.y - self.nowMaxHeight);
        
        
        [bezierPath addCurveToPoint:termalPoint controlPoint1:rightControllPoint controlPoint2:leftControllPoint];
        
    }
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = bezierPath.CGPath;
//    [keyFrameAnimation setDuration:2.0];
//    keyFrameAnimation.fillMode = kCAFillModeForwards;
//    keyFrameAnimation.removedOnCompletion = NO;
//    keyFrameAnimation.delegate = weakSelf;
//    [self.layer addAnimation:keyFrameAnimation forKey:@"movingAnimation"];
    
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basic.fromValue = [NSNumber numberWithFloat:1.0];
    basic.toValue = [NSNumber numberWithFloat:1.6];

    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:basic,keyFrameAnimation, nil];
    animationGroup.duration = 2;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    animationGroup.delegate = self;
    [self.layer addAnimation:animationGroup forKey:@"group"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        // transform the image to be 1.3 sizes larger to
        // give the impression that it is popping
        [UIView transitionWithView:self
                          duration:0.1f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.transform = CGAffineTransformMakeScale(1.3, 1.3);
                        } completion:^(BOOL finished) {
                            if (finished == YES) {
                                [self.layer removeAllAnimations];
                                BubbltView *bubbleImageView = [[BubbltView alloc]initWithMaxHeight:self.maxHeight maxWidth:self.maxWidth maxFrame:self.originFrame andSuperView:self.superview];
                                [self removeFromSuperview];
                            }
                            
                            
                        }];
    }];
    [CATransaction commit];
}
#pragma mark toolMethods
- (void)getRandomPathWidthAndHeight {
    self.nowMaxHeight = [self makeRandomNumberFromMin:self.maxHeight / 2 toMax:self.maxHeight];
    self.nowMaxWidth = [self makeRandomNumberFromMin:0 toMax:self.maxWidth];
}

//让泡泡随机选择上升的方式(从左侧上升还是从右侧上升)
- (void)getRandomBubbltKeypathType {
    if ((arc4random() % 2) == 1) {
        self.pathType = BubbltKeypathLeft;
    }else {
        self.pathType = BubbltKeypathRight;
    }
}

//获取随机的frame
- (CGRect)getRandomFrameWithFrame: (CGRect)frame
{
    CGFloat width = [self makeRandomNumberFromMin:15 toMax:self.originFrame.size.width];
    CGRect randomFrame = CGRectMake(frame.origin.x, frame.origin.y, width , width);
    return randomFrame;
}
//取min和max之间的随机数, 为了精确, 保留两位小数
- (CGFloat)makeRandomNumberFromMin:(CGFloat)min toMax: (CGFloat)max
{
    NSInteger precision = 100;
    
    CGFloat subtraction = ABS(max - min);
    
    subtraction *= precision;
    
    CGFloat randomNumber = arc4random() % ((int)subtraction+1);
    
    randomNumber /= precision;
    
    randomNumber += min;
    
    //返回结果
    return randomNumber;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
