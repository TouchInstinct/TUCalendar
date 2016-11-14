//
//  UITableView+CellRegistration.m
//  tutu
//
//  Created by Иван Смолин on 04/08/15.
//  Copyright (c) 2015 Touch Instinct. All rights reserved.
//

#import "UITableView+CellRegistration.h"
#import "TUViewStaticNibNameProtocol.h"
#import "TUReuseIdentifierProtocol.h"

@implementation UITableView (CellRegistration)

- (void)registerNibForCellClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    if ([cellClass conformsToProtocol:@protocol(TUViewStaticNibNameProtocol)]) {
        Class<TUViewStaticNibNameProtocol> nibNameClass = cellClass;

        [self registerNib:[UINib nibWithNibName:[nibNameClass nibName] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
    } else {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
    }
}

- (void)registerNibForCellClass:(Class)cellClass {
    if ([cellClass conformsToProtocol:@protocol(TUReuseIdentifierProtocol)]) {
        Class<TUReuseIdentifierProtocol> reuseIdentifierClass = cellClass;

        [self registerNibForCellClass:cellClass forCellReuseIdentifier:[reuseIdentifierClass reuseIdentifier]];
    } else {
        [self registerNibForCellClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
    }
}

- (void)registerCellClass:(Class)cellClass {
    if ([cellClass conformsToProtocol:@protocol(TUReuseIdentifierProtocol)]) {
        Class<TUReuseIdentifierProtocol> reuseIdentifierClass = cellClass;

        [self registerClass:cellClass forCellReuseIdentifier:[reuseIdentifierClass reuseIdentifier]];
    } else {
        [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
    }
}

@end
