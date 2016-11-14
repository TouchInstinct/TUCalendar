//
//  UITableView+CellRegistration.h
//  tutu
//
//  Created by Иван Смолин on 04/08/15.
//  Copyright (c) 2015 Touch Instinct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CellRegistration)

- (void)registerNibForCellClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

- (void)registerNibForCellClass:(Class)cellClass;

- (void)registerCellClass:(Class)cellClass;

@end
