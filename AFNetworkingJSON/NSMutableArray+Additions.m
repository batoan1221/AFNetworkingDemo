//
//  NSMutableArray+Additions.m
//  AFNetworkingJSON
//
//  Created by admin on 11/28/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import "NSMutableArray+Additions.h"
#import "AFNetworking.h"
#import "Product+Additions.h"
#import "ShopCategory+Additions.h"

@implementation NSMutableArray (Additions)

- (NSMutableArray *)getProductArrayFromJSONByCategoryId:(NSString *)categoryId tableViewToReload:(UITableView *)tableView{
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://jkshop-staging.ap01.aws.af.cm/?json=products/tk_get_products_by_category&category_id=%@",categoryId]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id reponseObject){
        NSArray *productsArray = reponseObject[@"products"];
        for (int i = 0; i < [productsArray count]; i++) {
            [self addObject:[[Product alloc] initWithDictionary:productsArray[i]]];
        }
        
        [tableView reloadData];
        
    }failure:nil];
    
    [operation start];
    return self;
}

- (NSMutableArray *)getCategoryArrayFromJSONWithTableViewToReload:(UITableView *)tableView{
    NSURL *url = [[NSURL alloc] initWithString:@"http://jkshop-staging.ap01.aws.af.cm/?json=products/tk_get_list_categories"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id reponseObject){
        for (int i = 0; i < [reponseObject count]; i++) {
            [self addObject:[[ShopCategory alloc] initWithDictionary:[reponseObject objectForKey:[NSString stringWithFormat:@"%d",i]]]];
        }
        [tableView reloadData];
        
    }failure:nil];
    
    [operation start];
    return self;
    
}

@end
