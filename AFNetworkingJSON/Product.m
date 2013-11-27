//
//  Product.m
//  AFNetworkingJSON
//
//  Created by Toan Slan on 11/27/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import "Product.h"
#import "ProductImage.h"

@interface Product()

@end

@implementation Product

- (Product *)initWithDictionary:(NSDictionary *)dictionary{
    
    Product *product = [[Product alloc] init];
    
    product.name = [dictionary objectForKey:@"name"];
    product.price = [dictionary objectForKey:@"price"];
    product.stockStatus = [dictionary objectForKey:@"stock_status"];
    
    NSArray *imageArray = [dictionary objectForKey:@"images"];
    product.firstImage = [[ProductImage alloc] initWithArray:[imageArray objectAtIndex:0]];
    product.secondImage = [[ProductImage alloc] initWithArray:[imageArray objectAtIndex:1]];
    product.thirdImage = [[ProductImage alloc] initWithArray:[imageArray objectAtIndex:2]];
    
    return product;
}

@end
