//
//  LYImageToast.h
//
//  Created by Loki on 14-5-14.
//  Copyright (c) 2014年 Loki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYImageToast : NSObject

/**
 *  Toast Image With Origin Size In View Center
 *
 *  @param image    Toast Image File Name
 *  @param view     Display View
 *  @param duration Toast Duration
 */
+ (void)toastWithImage:(NSString *)image
                inView:(UIView *)view
              duration:(CGFloat)duration;

/**
 *  Toast Image With Scale Ratio In View Center
 *
 *  @param image    Toast Image File Name
 *  @param scale    Image Scale Ratio
 *  @param view     Display View
 *  @param duration Toast Duration
 */
+ (void)toastWithImage:(NSString *)image
                 scale:(CGFloat)scale
                inView:(UIView *)view
              duration:(CGFloat)duration;

/**
 *  Toast Image With Given Size In View Center
 *
 *  @param image    Toast Image File Name
 *  @param size     Image Size
 *  @param view     Display View
 *  @param duration Toast Duration
 */
+ (void)toastWithImage:(NSString *)image
                  size:(CGSize)size
                inView:(UIView *)view
              duration:(CGFloat)duration;

/**
 *  Dismiss Toast Image View
 *
 *  @param view Display View
 */
+ (void)hideToastView:(UIView *)view;

@end
