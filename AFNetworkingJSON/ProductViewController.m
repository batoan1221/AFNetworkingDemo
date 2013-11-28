//
//  ProductViewController.m
//  AFNetworkingJSON
//
//  Created by Toan Slan on 11/27/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import "ProductViewController.h"
#import "Product.h"
#import "ProductCell.h"
#import "ProductImage.h"
#import "ImageFullScreenViewController.h"
#import "ShopCategory+Additions.h"
#import "Product+Additions.h"
#import "NSMutableArray+Additions.h"

@interface ProductViewController ()

<
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) NSMutableArray *productArray;
@property (weak, nonatomic) IBOutlet UITableView *productTableView;

@end

@implementation ProductViewController

- (NSMutableArray *)productArray{
    if (!_productArray)
        _productArray = [NSMutableArray array];
    
    return _productArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setViewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [self setViewWillAppear];
}

- (void)setViewDidLoad{
    self.productArray = [self.productArray getProductArrayFromJSONByCategoryId:self.categoryId tableViewToReload:self.productTableView];
    [self.productTableView registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];
}

- (void)setViewWillAppear{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationItem setTitle:self.categoryName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductCell *cell = (ProductCell *)[tableView dequeueReusableCellWithIdentifier:@"ProductCell"];
    [cell configCellWithProduct:[self.productArray objectAtIndex:indexPath.row]];
    [cell.productCellView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(productCellViewTap:)];
    [tap setNumberOfTouchesRequired:1];
    [tap setNumberOfTapsRequired:1];
    [cell.productCellView addGestureRecognizer:tap];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.productArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 386;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)productCellViewTap:(UITapGestureRecognizer *)gestureRecognizer
{
    ProductCell *cell = (ProductCell *)[[[gestureRecognizer.view superview] superview] superview];
    NSIndexPath *indexPath = [self.productTableView indexPathForCell:cell];
    ImageFullScreenViewController *imageFullScreenViewController = [[ImageFullScreenViewController alloc] init];
    imageFullScreenViewController.imageURL = [[[[self.productArray objectAtIndex:indexPath.row] imageMutableArray] objectAtIndex:0] imageLarge];
    imageFullScreenViewController.imageTitle = [[self.productArray objectAtIndex:indexPath.row] name];
    [self.navigationController pushViewController:imageFullScreenViewController animated:YES];
}

@end