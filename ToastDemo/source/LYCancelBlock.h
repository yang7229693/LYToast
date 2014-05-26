//
//  LYCancelBlock.h
//
//  Created by Loki on 14-5-26.
//  Copyright (c) 2014年 Loki. All rights reserved.
//

#ifndef ToastDemo_CancelBlock_h
#define ToastDemo_CancelBlock_h

#import <Foundation/Foundation.h>

typedef void(^DelayedBlockHandle)(BOOL cancel);

static DelayedBlockHandle perform_block_after_delay(CGFloat seconds, dispatch_block_t block) {
	
	if (nil == block) {
		return nil;
	}
	
	__block dispatch_block_t blockToExecute = [block copy];
	__block DelayedBlockHandle delayHandleCopy = nil;
	
	DelayedBlockHandle delayHandle = ^(BOOL cancel){
		if (NO == cancel && nil != blockToExecute) {
			dispatch_async(dispatch_get_main_queue(), blockToExecute);
		}

#if !__has_feature(objc_arc)
		[blockToExecute release];
		[delayHandleCopy release];
#endif
		
		blockToExecute = nil;
		delayHandleCopy = nil;
	};
    
	delayHandleCopy = [delayHandle copy];
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		if (nil != delayHandleCopy) {
			delayHandleCopy(NO);
		}
	});
    
	return delayHandleCopy;
};

static void cancel_delayed_block(DelayedBlockHandle delayedHandle) {
	if (nil == delayedHandle) {
		return;
	}
	
	delayedHandle(YES);
}

#endif
