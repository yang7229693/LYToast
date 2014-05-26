//
//  LYImageToast.m
//
//  Created by Loki on 14-5-14.
//  Copyright (c) 2014年 Loki. All rights reserved.
//

#import "LYImageToast.h"
#import "LYCancelBlock.h"

#define kImageToastViewTag       334455

@implementation LYImageToast

+ (void)toastWithImage:(NSString *)image
                inView:(UIView *)view
              duration:(CGFloat)duration
{
    [self toastWithImage:image
                   scale:1.0f
                  inView:view
                duration:duration];
}

+ (void)toastWithImage:(NSString *)image
                 scale:(CGFloat)scale
                inView:(UIView *)view
              duration:(CGFloat)duration
{
    if (!image || [image isEqualToString:@""] || scale <= 0) {
        return;
    }
    
    UIImage *showImage = [UIImage imageNamed:image];
    if (!showImage) {
        return;
    }
    
    CGSize size = showImage.size;
    size.width  *= scale;
    size.height *= scale;
    
    [self toastWithImage:image
                    size:size
                  inView:view
                duration:duration];
}

static DelayedBlockHandle delayedBlockHandle = nil;

+ (void)toastWithImage:(NSString *)image
                  size:(CGSize)size
                inView:(UIView *)view
              duration:(CGFloat)duration
{
    UIView *showedView = [view viewWithTag:kImageToastViewTag];
    if (showedView) {
        [self hideToastView:view];
    }
    
    if (!image || [image isEqualToString:@""] ||
        size.width == 0 || size.height == 0 ||
        !view || duration <= 0) {
        return;
    }
    
    UIImage *showImage = [UIImage imageNamed:image];
    if (!showImage) {
        return;
    }

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];

    CGRect frame = imageView.frame;
    frame.size = size;
    imageView.frame = frame;
    
    imageView.image  = showImage;
    imageView.tag    = kImageToastViewTag;
    imageView.center = view.center;

    dispatch_async(dispatch_get_main_queue(), ^{
        if (imageView) {
            [view addSubview:imageView];
        }
    });
    
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
        UIView *showedView = [view viewWithTag:kImageToastViewTag];
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
