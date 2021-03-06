//
//  ProductCell.h
//  AFNetworkingJSON
//
//  Created by Toan Slan on 11/27/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *productCellView;

- (void)configCellWithProduct:(Product *)product;

@end
