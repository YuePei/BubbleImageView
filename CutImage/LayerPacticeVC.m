
//
//  LayerPacticeVC.m
//  CutImage
//
//  Created by Peyton on 2018/4/18.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "LayerPacticeVC.h"

@interface LayerPacticeVC ()
//layer
@property (nonatomic, strong)CALayer *layer;
//layer
@property (nonatomic, strong)CALayer *calayer;
@end

@implementation LayerPacticeVC

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    if (_layer == nil) {
//        self.layer=[CALayer layer];
//    }
//
//    self.layer.bounds = CGRectMake(0, 0, 200, 200);
//    self.layer.position = CGPointMake(160, 250);
//    self.layer.backgroundColor = [UIColor redColor].CGColor;
//    self.layer.borderColor = [UIColor blackColor].CGColor;
//    self.layer.opacity = 1.0f;
//    [self.view.layer addSublayer:self.layer];
//    [super viewDidLoad];
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //设置变化动画过程是否显示，默认为YES不显示
    [CATransaction setDisableActions:NO];
    //设置圆角
    self.layer.cornerRadius = (self.layer.cornerRadius == 0.0f) ? 100.0f : 0.0f;
    //设置透明度
    self.layer.opacity = (self.layer.opacity == 1.0f) ? 0.5f : 1.0f;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(100, 100, 100, 50) ;
    btn.tag=1;
    [btn setTitle:@"隐式事务按钮" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTintColor:[UIColor blackColor]];
    [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 =[UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame=CGRectMake(200, 100, 100, 50) ;
    btn1.tag=2;
    [btn1 setTitle:@"显式事务按钮" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 setTintColor:[UIColor blackColor]];
    [btn1 addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    //    CATransaction 事务类,可以对多个layer的属性同时进行修改.它分隐式事务,和显式事务.
    //    区分隐式动画和隐式事务：隐式动画通过隐式事务实现动画 。修改Calayer的属性属于隐式事务
    //    区分显式动画和显式事务：显式动画有多种实现方式，显式事务是一种实现显式动画的方式。
    //隐式事务
    self.calayer=[CALayer layer];
    self.calayer.bounds=CGRectMake(150, 150, 100, 100);
    self.calayer.position=CGPointMake(100, 200);
    self.calayer.backgroundColor=[UIColor redColor].CGColor;
    self.calayer.borderColor = [UIColor blackColor].CGColor;
    self.calayer.opacity = 1.0f;
    [self.view.layer addSublayer:self.calayer];
    [super viewDidLoad];
    
}
-(void)btnclick:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if (btn.tag==1) {
        [CATransaction setDisableActions:YES];
        self.calayer.cornerRadius = (self.calayer.cornerRadius == 0.0f) ? 30.0f : 0.0f;
        self.calayer.opacity = (self.calayer.opacity == 1.0f) ? 0.5f : 1.0f;
    }
    else
    {
        //事务嵌套
        [CATransaction begin];
        [CATransaction begin];
        [CATransaction setValue:[NSNumber numberWithFloat:4.0f] forKey:kCATransactionAnimationDuration];
        self.calayer.opacity = (self.calayer.opacity == 1.0f) ? 0.5f : 1.0f;
        [CATransaction commit];
        //上面的动画并不会立即执行，需要等最外层的commit
//        [NSThread sleepForTimeInterval:3];
        //显式事务默认开启动画效果,kCFBooleanTrue关闭
//        [CATransaction setValue:(id)kCFBooleanFalse
//                         forKey:kCATransactionDisableActions];
        [CATransaction setDisableActions:NO];
        //动画执行时间
        [CATransaction setValue:[NSNumber numberWithFloat:4.0f] forKey:kCATransactionAnimationDuration];
        //[CATransaction setAnimationDuration:[NSNumber numberWithFloat:5.0f]];
        self.calayer.cornerRadius = (self.calayer.cornerRadius == 0.0f) ? 30.0f : 0.0f;
        [CATransaction commit];
        
    }
    
}
@end
