//
//  CategoryCell.h
//  AFNetworkingJSON
//
//  Created by Toan Slan on 11/27/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCategory.h"

@protocol CategoryCellDelegate <NSObject>

- (void)detailButtonPressed:(UITableViewCell *)cell button:(id)sender;

@end

@interface CategoryCell : UITableViewCell

@property (strong, nonatomic) id <CategoryCellDelegate> delegate;

- (void)configWithShopCategory:(ShopCategory *)shopCategory;

@end
