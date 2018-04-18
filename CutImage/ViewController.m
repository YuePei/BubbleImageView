//
//  ViewController.m
//  CutImage
//
//  Created by Peyton on 2018/4/16.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#import "BubbltView.h"
#import "SecondViewController.h"


@interface ViewController ()
//数量
@property (nonatomic, assign)NSInteger bubbleNumber;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImage *ima = [self cutImageWithImage:[UIImage imageNamed:@"pic"] targetSize:CGSizeMake(300, 100)];
//    self.iv.image = ima;
    CustomView *customView = [[CustomView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    customView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:customView];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view insertSubview:button aboveSubview:customView];
    [button setTitle:@"jumpToSecond" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(150, 500, 100, 50)];
    [button addTarget:self action:@selector(pushSecondVC) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)pushSecondVC {
    SecondViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"second"];
    [self.navigationController pushViewController:vc animated:YES];
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
- (UIImage *)cutImageWithImage:(UIImage *)image targetSize:(CGSize )targetSize {
    
    UIImage *image1 = image;
    //原图片尺寸
    CGFloat imageWidth = image1.size.width;
    CGFloat imageHeight = image1.size.height;
    //目标尺寸
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    //最终比例
    CGFloat scaleFactor = 0;
    CGPoint startPoint = CGPointMake(0, 0);
    
    //如果图片是竖着的，即图片高度大于宽度
    if (imageWidth < imageHeight) {
        CGFloat tempW = targetWidth;
        CGFloat tempH = targetHeight;
        
        targetWidth = tempH;
        targetHeight = tempW;
    }
    //如果图片大小 < 目标图片大小, 那就返回该图片,不做切割
    if (targetWidth > imageWidth && targetHeight > imageHeight) {
        return image1;
    }
    if (CGSizeEqualToSize(CGSizeMake(imageWidth, imageHeight), CGSizeMake(targetWidth, targetHeight)) == NO) {
        //如果两个尺寸不同则可以开始切割
        CGFloat widthFactor = targetWidth / imageWidth;
        CGFloat heightFactor = targetHeight / imageHeight;
        if (widthFactor < 1 && heightFactor < 1) {
            //源图片尺寸宽高都比目标尺寸的宽高都大
            //判断哪个比例更小, 按照更小的比例
            if (widthFactor < heightFactor) {
                scaleFactor = widthFactor;
            }else {
                scaleFactor = heightFactor;
            }
        }else if (widthFactor > 1 && heightFactor < 1) {
            //
            scaleFactor = widthFactor;
        }else if(widthFactor < 1 && heightFactor > 1) {
            //
            scaleFactor = heightFactor;
        }else {
            //目标尺寸的宽高都大于原始图片的尺寸的宽高, 建议不要做放大处理, 图片易失真
        }
    }
    targetHeight = scaleFactor * imageHeight;
    targetWidth = scaleFactor * imageWidth;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin= startPoint;
    thumbnailRect.size.width = targetWidth;
    thumbnailRect.size.height = targetHeight;
    [image1 drawInRect:thumbnailRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
    
}


@end
