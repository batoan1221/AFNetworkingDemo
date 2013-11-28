//
//  Product+Additions.m
//  AFNetworkingJSON
//
//  Created by admin on 11/28/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import "Product+Additions.h"
#import "ProductImage+Additions.h"

@implementation Product (Additions)

- (Product *)initWithDictionary:(NSDictionary *)dictionary{
    self.name = [dictionary objectForKey:@"name"];
    self.price = [dictionary objectForKey:@"price"];
    self.stockStatus = [dictionary objectForKey:@"stock_status"];
    NSArray *imageArray = [dictionary objectForKey:@"images"];
    self.imageMutableArray = [[NSMutableArray alloc] init];
    for(int i = 0;i < [imageArray count];i++){
        [self.imageMutableArray addObject:[[ProductImage alloc] initWithArray:[imageArray objectAtIndex:i]]];
    }
    
    return self;
}

@end
