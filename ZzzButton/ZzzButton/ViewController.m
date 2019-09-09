//
//  ViewController.m
//  ZzzButton
//
//  Created by 周泽舟 on 2019/9/9.
//  Copyright © 2019 zhouzezhou. All rights reserved.
//

#import "ViewController.h"
#import "ZzzButton.h"

// 屏幕的宽度
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
// 屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
// 系统状态栏高度
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化按钮
    ZzzButton *btn = [[ZzzButton alloc] initWithFrame:CGRectMake(50, 100, kScreenWidth - 100, 50)];
    
    // 设置按钮文字
    [btn setTitle:@"Normal" forState:UIControlStateNormal];
    [btn setTitle:@"Highlighted" forState:UIControlStateHighlighted];
    [btn setTitle:@"Disabled" forState:UIControlStateDisabled];
    
    // 监听按钮事件
    [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 为了测试，你不用写
    [btn setTag:0];
    
    [self.view addSubview:btn];
}

#pragma mark - Button Respond

-(void) btnTouchUpInside:(ZzzButton *) btn {
    
    // test
    [btn setTag:++btn.tag];
    if (btn.tag >= 5) {
        [btn turnStatusDisabled];
        [btn setTag:0];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [btn turnStatusNormal];
        });
    }
}

@end
