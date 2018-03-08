//
//  DraftWeakProxy.h
//  DraftSwift-MacOS
//
//  Created by modao on 2018/3/6.
//  Copyright © 2018年 MockingBot. All rights reserved.
//

// 参考：http://blog.sunnyxx.com/2014/08/24/objc-duck/
#import <Foundation/Foundation.h>

@interface DraftWeakProxy : NSProxy
/**
 The proxy target.
 */
@property (nullable, nonatomic, weak, readonly) id target;

/**
 Creates a new weak proxy for target.

 @param target Target object.

 @return A new proxy object.
 */
- (instancetype)initWithTarget:(id)target;

/**
 Creates a new weak proxy for target.

 @param target Target object.

 @return A new proxy object.
 */
+ (instancetype)proxyWithTarget:(id)target;

@end
