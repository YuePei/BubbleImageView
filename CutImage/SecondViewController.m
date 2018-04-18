//
//  SecondViewController.m
//  CutImage
//
//  Created by Peyton on 2018/4/18.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "SecondViewController.h"
#import "BubbltView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FLAnimatedImage.h"

@interface SecondViewController ()
//数量
@property (nonatomic, assign)NSInteger bubbleNumber;
//FLAnimatedView
@property (nonatomic, strong)FLAnimatedImageView *iV;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGPoint originPoint = CGPointMake(20, 280);
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://s4.sinaimg.cn/middle/a974c28a4c49f1a03eeb3&690"]];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
    if (!_iV) {
        _iV = [[FLAnimatedImageView alloc]initWithFrame:CGRectMake(originPoint.x, originPoint.y, 120, 120 * 25 / 42.0)];
    }
    self.iV.backgroundColor = [UIColor redColor];
    self.iV.animatedImage = image;
    [self.view addSubview:self.iV];
    
    UIBezierPath *path9 = [UIBezierPath bezierPath];
    [path9 moveToPoint:originPoint];
    [path9 addCurveToPoint:CGPointMake(220, 280) controlPoint1:CGPointMake(70, 100) controlPoint2:CGPointMake(170, 380)];
    [path9 stroke];
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrame.path = path9.CGPath;
    keyFrame.duration = 4;
    keyFrame.repeatCount = 100;
    keyFrame.removedOnCompletion = NO;
    keyFrame.fillMode = kCAFillModeForwards;
    [self.iV.layer addAnimation:keyFrame forKey:@"test"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.bubbleNumber <= 30) {
        
        BubbltView *bubbleImageView = [[BubbltView alloc]initWithMaxHeight:self.view.bounds.size.height / 2.5 maxWidth: self.view.bounds.size.width / 1.5 maxFrame:CGRectMake([self makeRandomNumberFromMin:0 toMax:self.view.bounds.size.width], self.view.center.y, 50, 50) andSuperView:self.view];
        self.bubbleNumber++;
    }
    
}
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
@end
