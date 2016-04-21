//
//  NHTodayKit.m
//  NHWidgetPro
//
//  Created by hu jiaju on 16/4/21.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "NHTodayKit.h"
#import "TodayKit.h"

#pragma mark -- 

extern NSDateFormatter * getDateFormatter () {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (formatter == nil) {
            formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        }
    });
    return formatter;
}

static NHTodayKit *instance = nil;

@implementation NHTodayKit{
    NSUInteger              _NUM_IDX;
    NSTimer                 *_timer;
    void (^_updateTickCallback)(NSUInteger);
}

+ (id)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

- (NSTimer *)getTimer:(NSTimeInterval)left withCallback:(void (^)(NSUInteger))back {
    if (left <= 0) {
        return nil;
    }
    _NUM_IDX = left;
    if (_timer != nil) {
        if ([_timer isValid]) {
            [_timer invalidate];
        }
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:true];
    _updateTickCallback = [back copy];
    
    return _timer;
}

- (void)timerAction {
    if (_NUM_IDX == 0) {
        [self endDesc];
        return;
    }
    _NUM_IDX--;
    _NUM_IDX = (_NUM_IDX <=0)?0:_NUM_IDX;
    
    if (_updateTickCallback) {
        _updateTickCallback(_NUM_IDX);
    }
}

- (void)endDesc {
    
    if (_timer != nil) {
        if ([_timer isValid]) {
            [_timer invalidate];
        }
        _timer = nil;
    }
}

- (void)get:(NSString *)path params:(id)ps success:(void (^)(id _Nonnull))succes failer:(void (^)(NSError * _Nonnull))failer {
    
}

@end
