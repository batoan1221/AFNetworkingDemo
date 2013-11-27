//
//  ProductImage.m
//  AFNetworkingJSON
//
//  Created by Toan Slan on 11/27/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import "ProductImage.h"

@interface ProductImage()

@end

@implementation ProductImage

- (ProductImage *)initWithArray:(NSArray *)sizeURLArray{
    ProductImage *productImage = [[ProductImage alloc] init];
    productImage.imageSmall = [sizeURLArray objectAtIndex:0];
    productImage.imageMedium = [sizeURLArray objectAtIndex:1];
    productImage.imageLarge = [sizeURLArray objectAtIndex:2];
    return productImage;
}

@end
