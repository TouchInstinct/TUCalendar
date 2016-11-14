//
//  UITableViewCell+DequeueFromTableView.m
//  tutu
//
//  Created by Иван Смолин on 02/11/15.
//  Copyright © 2015 Touch Instinct. All rights reserved.
//

#import "UITableViewCell+DequeueFromTableView.h"
#import "UIView+AutoReuseIdentifier.h"

@implementation UITableViewCell (DequeueFromTableView)

+ (instancetype)dequeueReusableCellFromTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:[self autoReuseIdentifier] forIndexPath:indexPath];
}

@end
