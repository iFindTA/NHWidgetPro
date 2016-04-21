//
//  NHTodayKit.h
//  NHWidgetPro
//
//  Created by hu jiaju on 16/4/21.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^bbb)();


@interface NHTodayKit : NSObject

/**
 *  @brief single instance
 *
 *  @return the new instance
 */
+ (id)shared;

- (NSTimer *)getTimer:(NSTimeInterval)left withCallback:(void(^)(NSUInteger))back;

@end
