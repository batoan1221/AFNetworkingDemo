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
#import "AFNetworking.h"

@interface ProductViewController ()

<
UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate
>

@property (strong, nonatomic) NSMutableArray *productArray;
@property (weak, nonatomic) IBOutlet UITableView *productTableView;
@property (weak, nonatomic) UIView *productCellView;

@end

@implementation ProductViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableArray *)productArray{
    if (!_productArray)
        _productArray = [NSMutableArray array];
    
    return _productArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://jkshop-staging.ap01.aws.af.cm/?json=products/tk_get_products_by_category&category_id=%@",self.categoryId]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id reponseObject){
        NSArray *productsArray = reponseObject[@"products"];
        for (int i = 0; i < [productsArray count]; i++) {
            [self.productArray addObject:[[Product alloc] initWithDictionary:productsArray[i]]];
        }
        
        [self.productTableView reloadData];
        
    }failure:nil];
    
    [operation start];
    
    
    [self.productTableView registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationItem setTitle:self.categoryName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//    ProductCell *cell = (ProductCell *)[[[gestureRecognizer.view superview] superview] superview];
//    NSIndexPath *indexPath = [self.productTableView indexPathForCell:cell];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Product"
//                                                    message:[NSString stringWithFormat:@"You've selected %@",[[self.productArray objectAtIndex:indexPath.row] name]]
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil, nil];
//    [alert show];
    ProductCell *cell = (ProductCell *)[[[gestureRecognizer.view superview] superview] superview];
    NSIndexPath *indexPath = [self.productTableView indexPathForCell:cell];
    ImageFullScreenViewController *imageFullScreenViewController = [[ImageFullScreenViewController alloc] init];
    imageFullScreenViewController.imageURL = [[[[self.productArray objectAtIndex:indexPath.row] imageMutableArray] objectAtIndex:0] imageLarge];
    imageFullScreenViewController.imageTitle = [[self.productArray objectAtIndex:indexPath.row] name];
    [self.navigationController pushViewController:imageFullScreenViewController animated:YES];
}

@end