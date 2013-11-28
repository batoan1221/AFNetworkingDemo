//
//  ShopCategory+Additions.m
//  AFNetworkingJSON
//
//  Created by admin on 11/28/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import "ShopCategory+Additions.h"

@implementation ShopCategory (Additions)

- (ShopCategory *)initWithDictionary:(NSDictionary *)dictionary{
    self.name = [dictionary objectForKey:@"name"];
    self.categoryId = [dictionary objectForKey:@"term_id"];
    return self;
}

@end
