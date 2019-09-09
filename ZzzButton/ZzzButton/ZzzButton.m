//
//  ZzzButton.m
//  ZzzButton
//
//  Created by 周泽舟 on 2019/9/9.
//  Copyright © 2019 zhouzezhou. All rights reserved.
//

#import "ZzzButton.h"

@implementation ZzzButton

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(btnTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(btnTouchDown:) forControlEvents:UIControlEventTouchDown];
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor magentaColor] forState:UIControlStateDisabled];
        
        [self turnStatusNormal];
    }
    return self;
}

#pragma mark - Private mothed

- (void) setNewLayerShadowColor:(UIColor *) shadow
              gradientColorLeft:(UIColor *) leftGrad
             gradientColorRight:(UIColor *) rightGrad {
    //////////// 阴影 ////////////
    // 设置按钮阴影
    CALayer *shadowLayer = [[CALayer alloc] init];
    shadowLayer.frame = self.bounds;
    shadowLayer.shadowColor = shadow.CGColor;
    // 不透明度
    shadowLayer.shadowOpacity = 1;
    // 偏移位置
    shadowLayer.shadowOffset = CGSizeMake(0, self.bounds.size.height * 0.125);
    // 阴影半径
    // 此值很小的时候，可以看到清晰的阴影边界，且阴影边界为矩形（不受设置的cornerRadius影响）
    // 此值很大的时候颜色会非常淡，适中的值观感最好
    shadowLayer.shadowRadius = 20;
    
    // 阴影的超出Button区域的大小
    // 为0时，贴着Button开始有阴影
    // 为正值时，相当于把Button的区域放大了，然后再开始出现阴影
    CGFloat shadowSizeExtra = self.bounds.size.height * 0.375;
    CGRect shadowSpreadRect = CGRectMake(shadowSizeExtra,
                                         shadowSizeExtra,
                                         self.bounds.size.width - shadowSizeExtra * 2,
                                         self.bounds.size.height - shadowSizeExtra * 2);
    CGFloat shadowSpreadRadius =  (self.layer.cornerRadius == 0) ? 0 : self.layer.cornerRadius+shadowSizeExtra;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:shadowSpreadRect
                                                          cornerRadius:shadowSpreadRadius];
    shadowLayer.shadowPath = shadowPath.CGPath;
    
    
    //////////// 渐变色 ////////////
    // 背景的渐变色
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.cornerRadius = (self.bounds.size.height / 2);
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[(id)leftGrad.CGColor,
                             (id)rightGrad.CGColor];
    gradientLayer.locations = @[@0, @1];
    // 从左到右
    [gradientLayer setStartPoint:CGPointMake(0, 1)];
    [gradientLayer setEndPoint:CGPointMake(1, 1)];
    
    
    
    // sublayer直接Add到sublayers会导致Button上的文本看不见（被加入的Layer遮住了）,所以把Layer放在最里层
    NSArray *sublayers = [self.layer sublayers];
    if (sublayers.count < 3) {
        [self.layer insertSublayer:gradientLayer atIndex:0];
        [self.layer insertSublayer:shadowLayer atIndex:0];
    } else {
        [self.layer replaceSublayer:sublayers.firstObject with:shadowLayer];
        [self.layer replaceSublayer:sublayers[1] with:gradientLayer];
    }
}

#pragma mark - Public Mothed

-(void) turnStatusNormal {
    [self setEnabled:YES];
    
    [self setNewLayerShadowColor:[UIColor redColor]
               gradientColorLeft:[UIColor purpleColor]
              gradientColorRight:[UIColor blackColor]];
}

-(void) turnStatusHighlighted {
    [self setEnabled:YES];
    
    [self setNewLayerShadowColor:[UIColor grayColor]
               gradientColorLeft:[UIColor brownColor]
              gradientColorRight:[UIColor orangeColor]];
}

-(void) turnStatusDisabled {
    [self setEnabled:NO];
    
    [self setNewLayerShadowColor:[UIColor grayColor]
               gradientColorLeft:[UIColor lightGrayColor]
              gradientColorRight:[UIColor darkGrayColor]];
}

#pragma mark - Button Respond


-(void) btnTouchUpInside:(UIButton *) btn {
    [self turnStatusNormal];
}

-(void) btnTouchUpOutside:(UIButton *) btn {
    [self turnStatusNormal];
}

-(void) btnTouchDown:(UIButton *) btn {
    [self turnStatusHighlighted];
}


@end
