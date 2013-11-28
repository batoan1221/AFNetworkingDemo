//
//  NSMutableArray+Additions.h
//  AFNetworkingJSON
//
//  Created by admin on 11/28/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Additions)

- (NSMutableArray *)getProductArrayFromJSONByCategoryId:(NSString *)URLString tableViewToReload:(UITableView *)tableView;
- (NSMutableArray *)getCategoryArrayFromJSONWithTableViewToReload:(UITableView *)tableView;


@end
