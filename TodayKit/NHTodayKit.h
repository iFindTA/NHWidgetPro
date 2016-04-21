//
//  NHTodayKit.h
//  NHWidgetPro
//
//  Created by hu jiaju on 16/4/21.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NHTodayKit : NSObject

/**
 *  @brief single instance
 *
 *  @return the new instance
 */
+ (id)shared;

/**
 *  @brief generate timer by left interval
 *
 *  @param left left time interval
 *  @param back callback
 *
 *  @return the timer
 */
- (NSTimer *)getTimer:(NSTimeInterval)left withCallback:(void(^)(NSUInteger))back;

/**
 *  @brief get newest data
 *
 *  @param path   request path
 *  @param ps     params
 *  @param succes block
 *  @param failer block
 */
- (void)get:(NSString *)path params:(id)ps success:(void(^)(id))succes failer:(void(^)(NSError *))failer;

NS_ASSUME_NONNULL_END

@end
