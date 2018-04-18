//
//  CustomView.m
//  CutImage
//
//  Created by Peyton on 2018/4/17.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "CustomView.h"
@interface CustomView()

@end
@implementation CustomView


- (void)drawRect:(CGRect)rect {
    
    //三条直线构成三角形
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    //设置初始位置
    [path1 moveToPoint:CGPointMake(10, 10)];
    //添加线段的三个两个转折点和终点
    [path1 addLineToPoint:CGPointMake(100, 110)];
    [path1 addLineToPoint:CGPointMake(10, 110)];
    [path1 addLineToPoint:CGPointMake(10, 10)];
    //线宽
    path1.lineWidth = 3;
    path1.lineCapStyle = kCGLineCapRound;
    path1.lineJoinStyle = kCGLineJoinRound;
    //设置线的颜色
    [[UIColor brownColor] set];
    //设置填充色
    [[UIColor blackColor] setFill];
    [path1 fill];

    [path1 stroke];

    //矩形/圆形
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(120, 10, 100, 100) cornerRadius:20];
    path2.lineWidth = 2;
    [[UIColor blackColor] set];
    [path2 stroke];

    //圆弧
    CGPoint center = CGPointMake(50, 170);
    UIBezierPath *path3 = [UIBezierPath bezierPathWithArcCenter:center radius:50 startAngle:0 endAngle:M_PI / 2.0 clockwise:YES];
    path3.lineWidth = 3;
    [path3 stroke];
    //矩形
    UIBezierPath *path4 = [UIBezierPath bezierPathWithRect:CGRectMake(120, 120, 100, 100)];
    path4.lineWidth = 2;
    path4.lineJoinStyle = kCGLineJoinMiter;
    [[UIColor whiteColor] set];
    [[UIColor brownColor] setFill];
    [path4 fill];
    [path4 stroke];
    //标准圆形
    UIBezierPath *path5 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(120, 120, 100, 100)];
    path5.lineWidth = 2;
    [path5 stroke];
    //左上角是圆角
    UIBezierPath *path6 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(230, 10, 100, 100) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(30, 30)];
    [[UIColor whiteColor] set];
    path6.lineWidth = 3;
    [path6 stroke];

    // 创建椭圆形路径对象
    UIBezierPath * path7 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(230, 145, 100, 50)];
    [[UIColor redColor] set];
    path7.lineWidth = 5.f;
    [path7 stroke];
    
//    UIView *controlView = [[UIView alloc]initWithFrame:CGRectMake(149, 49, 2, 2)];
//    controlView.backgroundColor = [UIColor redColor];
//    [self addSubview:controlView];
//    UIBezierPath *path8 = [UIBezierPath bezierPath];
//    [path8 moveToPoint:CGPointMake(100, 100)];
//    [path8 addQuadCurveToPoint:CGPointMake(200, 100) controlPoint:CGPointMake(150, 50)];
//    [[UIColor whiteColor] setFill];
//    [path8 stroke];
    
    UIBezierPath *path9 = [UIBezierPath bezierPath];
    [path9 moveToPoint:CGPointMake(20, 280)];
    [path9 addCurveToPoint:CGPointMake(220, 280) controlPoint1:CGPointMake(70, 200) controlPoint2:CGPointMake(170, 360)];
    [[UIColor whiteColor] set];
    [path9 stroke];
}


@end
