//
//  Product.h
//  AFNetworkingJSON
//
//  Created by Toan Slan on 11/27/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductImage.h"

@interface Product : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *stockStatus;
@property (strong, nonatomic) ProductImage *firstImage;
@property (strong, nonatomic) ProductImage *secondImage;
@property (strong, nonatomic) ProductImage *thirdImage;

- (Product *)initWithDictionary:(NSDictionary *)dictionary;

@end
