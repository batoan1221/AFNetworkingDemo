//
//  ProductImage+Additions.m
//  AFNetworkingJSON
//
//  Created by admin on 11/28/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import "ProductImage+Additions.h"

@implementation ProductImage (Additions)

- (ProductImage *)initWithArray:(NSArray *)sizeURLArray{
    self.imageSmall = [sizeURLArray objectAtIndex:0];
    self.imageMedium = [sizeURLArray objectAtIndex:1];
    self.imageLarge = [sizeURLArray objectAtIndex:2];
    return self;
}

@end
