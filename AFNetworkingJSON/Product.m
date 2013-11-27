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
    product.imageMutableArray = [[NSMutableArray alloc] init];
    for(int i = 0;i < [imageArray count];i++){
        [product.imageMutableArray addObject:[[ProductImage alloc] initWithArray:[imageArray objectAtIndex:i]]];
    }
    
    return product;
}

@end
