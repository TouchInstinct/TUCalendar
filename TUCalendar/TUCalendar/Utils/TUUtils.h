//
//  TUUtils.h
//  tutu
//
//  Created by Иван Смолин on 06/08/15.
//  Copyright (c) 2015 Touch Instinct. All rights reserved.
//

@import UIKit;

#define SafeCallVoidBlk(blk, ...) if((blk)) { blk(__VA_ARGS__); }
#define SafeCallVoidBlkNoArgs(blk) if((blk)) { blk(); }

#define AssignIfNotNil(ref, val) (ref ? *ref = val : nil)

#define TU_MIN(A, B) ((A) > (B) ? (B) : (A))

#define TU_MAX(A, B) ((A) < (B) ? (B) : (A))

#define NumberInRange(number, minValue, maxValue) ((number >= minValue) && (number <= maxValue))

#define NumberInRangeExcludeRight(number, minValue, maxValue) ((number >= minValue) && (number < maxValue))

NS_INLINE void PerformInMainThread(void (^performBlock)()) {
    if (!performBlock) {
        return;
    }
    
    if ([NSThread isMainThread]) {
        performBlock();
    } else {
        dispatch_async(dispatch_get_main_queue(), performBlock);
    }
}

NS_INLINE BOOL IsEqual(NSObject *obj1, NSObject *obj2) {
    return (!obj1 && !obj2) || [obj1 isEqual:obj2];
}
