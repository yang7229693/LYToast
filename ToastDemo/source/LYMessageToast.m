//
//  LYMessageToast.m
//
//  Created by Loki on 14-4-3.
//  Copyright (c) 2014年 Loki. All rights reserved.
//

#import "LYMessageToast.h"
#import <QuartzCore/QuartzCore.h>
#import "LYCancelBlock.h"

#define kPaddingSpace            10.0f
#define kTextToastViewTag        2046

@implementation LYMessageToast

static DelayedBlockHandle delayedBlockHandle = nil;

+ (void)toastWithText:(NSString *)text
      backgroundColor:(UIColor *)backgroundColor
                 font:(UIFont *)font
            fontColor:(UIColor *)fontColor
             duration:(CGFloat)duration
               inView:(UIView *)view
{
    if (!view || !text || text.length < 1 || 0 >= duration) {
        return;
    }
    
    //如果已经有弹框了，则不弹出
    UIView *toastView = [view viewWithTag:kTextToastViewTag];
    if (toastView) {
        [self hideToastView:view];
    }
    
    if (!backgroundColor) {
        backgroundColor = [UIColor blackColor];
    }
    
    if (!font) {
        font = [UIFont systemFontOfSize:14.0f];
    }
    
    if (!fontColor) {
        fontColor = [UIColor whiteColor];
    }
    
    UILabel *label              = [[UILabel alloc] init];
    label.backgroundColor       = backgroundColor;
    label.font                  = font;
    label.textColor             = fontColor;
    label.layer.cornerRadius    = 4.0f;
    label.text                  = text;
    label.numberOfLines         = 0;
    label.textAlignment         = NSTextAlignmentCenter;
    label.tag                   = kTextToastViewTag;
    
    //计算并设置frame
    NSArray *subStringArray = [text componentsSeparatedByString:@"\n"];
    CGSize textSize         = CGSizeZero;
    CGRect frame            = CGRectZero;
    
    //根据是否包含换行符进行设置
    if (subStringArray && subStringArray.count > 0) {
        //取最大宽度，换行符隔开的每段文字默认占一行
        CGFloat maxWidth = 0;
        for (NSString *subString in subStringArray) {
            textSize = [subString sizeWithFont:font];
            if (textSize.width >= maxWidth) {
                maxWidth = textSize.width;
            }
        }
        
        //总高度取每行高度乘以行数
        CGFloat height = textSize.height * subStringArray.count;
        
        //长宽加上两边留空白区域
        height   += (2 * kPaddingSpace);
        maxWidth += (2 * kPaddingSpace);
        frame    = CGRectMake(0, 0, maxWidth, height);
    } else {
        textSize        = [text sizeWithFont:font];
        textSize.height += (2 * kPaddingSpace);
        textSize.width  += (2 * kPaddingSpace);
        frame           = CGRectMake(0, 0, textSize.width, textSize.height);
    }
    
    //设置显示位置
    label.frame  = frame;
    label.center = view.center;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [view addSubview:label];
    });
    
#if !__has_feature(objc_arc)
    [label release];
#endif
    
    [self cancelBlock];
    DelayedBlockHandle handle = perform_block_after_delay(duration, ^{
        [self hideToastView:view];
        
#if !__has_feature(objc_arc)
        [delayedBlockHandle release];
#endif
        delayedBlockHandle = nil;
    });
    
#if !__has_feature(objc_arc)
    delayedBlockHandle = [handle retain];
#endif
}

+ (void)cancelBlock
{
    if (!delayedBlockHandle) {
        return;
    }
    
    delayedBlockHandle(YES);
    
#if !__has_feature(objc_arc)
    [delayedBlockHandle release];
#endif
    delayedBlockHandle = nil;
}

+ (void)hideToastView:(UIView *)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *showedView = [view viewWithTag:kTextToastViewTag];
        if (showedView) {
            [showedView removeFromSuperview];
            
#if !__has_feature(objc_arc)
            [showedView release];
#endif
            showedView = nil;
        }
    });
}

@end
