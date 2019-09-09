//
//  ZzzButton.h
//  ZzzButton
//
//  Created by 周泽舟 on 2019/9/9.
//  Copyright © 2019 zhouzezhou. All rights reserved.
//  继承自UIButton的按钮类
//  实现了动态的改变背景颜色（渐变色）和按钮的外发光（shadow）效果

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZzzButton : UIButton

/**
 按钮状态改变成*正常*状态
 改变了：渐变背影、按钮投影、按钮Enable ==> YES
 */
-(void) turnStatusNormal;

/**
 按钮状态改变成*不可用*状态
 改变了：渐变背影、按钮投影、按钮Enable ==> NO
 */
-(void) turnStatusDisabled;

@end

NS_ASSUME_NONNULL_END
