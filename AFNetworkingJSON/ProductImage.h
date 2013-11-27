//
//  ProductImage.h
//  AFNetworkingJSON
//
//  Created by Toan Slan on 11/27/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductImage : NSObject

@property (strong, nonatomic) NSString *imageSmall;
@property (strong, nonatomic) NSString *imageMedium;
@property (strong, nonatomic) NSString *imageLarge;

- (ProductImage *)initWithArray:(NSArray *)sizeURLArray;

@end
