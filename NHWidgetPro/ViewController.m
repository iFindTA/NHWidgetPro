//
//  ViewController.m
//  NHWidgetPro
//
//  Created by hu jiaju on 16/4/21.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "ViewController.h"
#import "TodayKit.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSTimer         *_timer;
    UILabel         *_label;
    NSUInteger      _NUM_IDX;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _NUM_IDX = 60;
    [self.view addSubview:[self lable]];
    _timer = [[NHTodayKit shared] getTimer:_NUM_IDX withCallback:^(NSUInteger idx) {
        _NUM_IDX = idx;
        _label.text = [self info];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willAsginActive) name:UIApplicationWillResignActiveNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willAsginActive {
    
    if (_timer == nil) {
        [self clear];
    }else {
        if (_timer.isValid) {
            [self save];
        }else{
            [self clear];
        }
    }
}

- (void)save {
    if (_NUM_IDX == 0) {
        return;
    }
    
    NSUInteger left = _NUM_IDX;
    NSLog(@"left-----:%zd",left);
    NSTimeInterval inter = [[NSDate date] timeIntervalSince1970];
    NSUserDefaults *userDs = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.nanhu.today"];
    [userDs setInteger:left forKey:@"lefttime"];
    [userDs setInteger:inter forKey:@"quittime"];
    [userDs synchronize];
}

- (void)clear {
    NSUserDefaults *userDs = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.nanhu.today"];
    [userDs removeObjectForKey:@"lefttime"];
    [userDs removeObjectForKey:@"quittime"];
    [userDs synchronize];
}

- (NSString *)info {
    return [NSString stringWithFormat:@"%zd",_NUM_IDX];
}

#pragma mark -- create methods --
- (UILabel *)lable {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 300, 30)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:20];
        _label.textColor = [UIColor blueColor];
        _label.text = self.info;
    }
    return _label;
}

@end
