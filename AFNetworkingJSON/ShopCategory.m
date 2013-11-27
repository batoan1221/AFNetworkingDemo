//
//  Category.m
//  AFNetworkingJSON
//
//  Created by Toan Slan on 11/27/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import "ShopCategory.h"

@implementation ShopCategory

- (ShopCategory *)initWithDictionary:(NSDictionary *)dictionary{
    ShopCategory *resultCategory = [[ShopCategory alloc] init];
    resultCategory.name = [dictionary objectForKey:@"name"];
    resultCategory.categoryId = [dictionary objectForKey:@"term_id"];
    return resultCategory;
}

@end
