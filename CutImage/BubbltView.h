//
//  BubbltView.h
//  CutImage
//
//  Created by Peyton on 2018/4/17.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BubbleKeypathType) {
    BubbltKeypathLeft = 0,
    BubbltKeypathRight,
};

@interface BubbltView : UIImageView

- (instancetype)initWithMaxHeight:(CGFloat) maxHeight maxWidth: (CGFloat)maxWidth maxFrame:(CGRect)frame andSuperView: (UIView *)superView;

@end
