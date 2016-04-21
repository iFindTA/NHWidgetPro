//
//  TodayViewController.m
//  NHTodayWidget
//
//  Created by hu jiaju on 16/4/21.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "TodayKit.h"

//NSExtensionMainStoryboard
//NSExtensionPrincipalClass
@interface TodayViewController () <NCWidgetProviding>

@end

/**
 *  @attention: 扩展需要iOS8.0+支持
 */
@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.preferredContentSize = CGSizeMake(0, 100);
    
    NSUserDefaults *userDs = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.nanhu.today"];
    
    //printf("nslog can not output !");
    NSUInteger left = [userDs integerForKey:@"lefttime"];
    NSTimeInterval inter = [userDs integerForKey:@"quittime"];
    NSLog(@"left :%zd---inter:%f",left,inter);
    NSTimeInterval passed = [[NSDate date] timeIntervalSinceDate:[NSDate dateWithTimeIntervalSince1970:inter]];
    left = left - passed;
    NSLog(@"passed:%zd--left:%zd",passed,left);
    [[NHTodayKit shared] getTimer:left withCallback:^(NSUInteger idx) {
        NSLog(@"ticker:%zd",idx);
        NSString *info = [NSString stringWithFormat:@"剩余时间:%zd",idx];
        self.info.text = info;
        
        if (idx == 0) {
            [self showJump];
        }
    }];
}

- (void)showJump {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 20, 100, 50);
    [btn setTitle:@"open" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(openHostApp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)openHostApp {
    [self.extensionContext openURL:[NSURL URLWithString:@"NHToday://action:open"] completionHandler:^(BOOL success) {
        
    }];
}

- (BOOL)isPortait {
    BOOL screenPortrait = false;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize nativeSize = [UIScreen mainScreen].currentMode.size;
    CGSize sizeInPoints = [UIScreen mainScreen].bounds.size;
    if (scale*sizeInPoints.width == nativeSize.width) {
        screenPortrait = true;
    }
    return screenPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}
//布局
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

@end
