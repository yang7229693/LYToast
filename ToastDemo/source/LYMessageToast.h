//
//  LYMessageToast.h
//
//  Created by Loki on 14-4-3.
//  Copyright (c) 2014年 Loki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYMessageToast : NSObject

/**
 *  显示弹出消息,使用换行符可居中显示多行信息
 *
 *  @param text            显示信息
 *  @param backgroundColor 背景颜色
 *  @param font            字体
 *  @param fontColor       字体颜色
 *  @param duration        显示时间
 *  @param view            被显示到的视图
 */
+ (void)toastWithText:(NSString *)text
          backgroundColor:(UIColor *)backgroundColor
                     font:(UIFont *)font
                fontColor:(UIColor *)fontColor
                 duration:(CGFloat)duration
                   inView:(UIView *)view;

@end
