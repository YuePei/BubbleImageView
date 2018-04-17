//
//  CustomView.m
//  CutImage
//
//  Created by Peyton on 2018/4/17.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView


- (void)drawRect:(CGRect)rect {
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(10, 10)];
    [path1 addLineToPoint:CGPointMake(100, 100)];
    [path1 addLineToPoint:CGPointMake(10, 100)];
    [path1 addLineToPoint:CGPointMake(10, 10)];
    path1.lineWidth = 3;
    path1.lineCapStyle = kCGLineCapRound;
    [[UIColor brownColor] set];
    [path1 stroke];
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(120, 10, 90, 90) cornerRadius:0];
    path2.lineWidth = 3;
    [[UIColor redColor] set];
    [path2 stroke];
    
    CGPoint center = CGPointMake(10, 120);
    UIBezierPath *path3 = [UIBezierPath bezierPathWithArcCenter:center radius:50 startAngle:0 endAngle:M_PI / 2.0 clockwise:YES];
    path3.lineWidth = 3;
    [path3 addLineToPoint:center];
    [path3 fill];
    [path3 stroke];
    
    
    
    UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(120, 10, 20, 20)];
    [self addSubview:blackView];
    blackView.backgroundColor = [UIColor blackColor];
    
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyframeAnimation.path = path2.CGPath;
    keyframeAnimation.duration = 2;
    keyframeAnimation.repeatCount = 1;
    keyframeAnimation.fillMode = kCAFillModeForwards;
    keyframeAnimation.removedOnCompletion = NO;
    [blackView.layer addAnimation:keyframeAnimation forKey:@"animation"];
    
}


@end
