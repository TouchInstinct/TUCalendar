//
//  UITableViewCell+DequeueFromTableView.h
//  tutu
//
//  Created by Иван Смолин on 02/11/15.
//  Copyright © 2015 Touch Instinct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (DequeueFromTableView)

+ (instancetype)dequeueReusableCellFromTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;

@end
