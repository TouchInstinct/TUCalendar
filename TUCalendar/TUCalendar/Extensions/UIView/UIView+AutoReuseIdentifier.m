//
//  UIView+AutoReuseIdentifier.m
//  tutu
//
//  Created by Ivan Smolin on 23/08/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

#import "UIView+AutoReuseIdentifier.h"
#import "TUReuseIdentifierProtocol.h"

@implementation UIView (AutoReuseIdentifier)

+ (NSString *)autoReuseIdentifier {
    if ([self conformsToProtocol:@protocol(TUReuseIdentifierProtocol)]) {
        Class<TUReuseIdentifierProtocol> reuseIdentifierClass = self;

        return [reuseIdentifierClass reuseIdentifier];
    }

    return NSStringFromClass(self);
}

@end
