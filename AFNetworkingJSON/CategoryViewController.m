//
//  CategoryViewController.m
//  AFNetworkingJSON
//
//  Created by Toan Slan on 11/27/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryCell.h"
#import "ShopCategory.h"
#import "ProductViewController.h"
#import "AFNetworking.h"

@interface CategoryViewController ()

<
UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate,
CategoryCellDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (strong, nonatomic) NSMutableArray *categoryArray;

@end

@implementation CategoryViewController

- (NSMutableArray *)categoryArray{
    if (!_categoryArray) {
        _categoryArray = [NSMutableArray array];
    }
    return _categoryArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURL *url = [[NSURL alloc] initWithString:@"http://jkshop-staging.ap01.aws.af.cm/?json=products/tk_get_list_categories"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id reponseObject){
        for (int i = 0; i < [reponseObject count]; i++) {
            [self.categoryArray addObject:[[ShopCategory alloc] initWithDictionary:[reponseObject objectForKey:[NSString stringWithFormat:@"%d",i]]]];
        }
        [self.categoryTableView reloadData];
        
    }failure:nil];
    
    [operation start];
    
    [self.navigationItem setTitle:@"Category"];
    [self.categoryTableView registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellReuseIdentifier:@"CategoryCell"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    [cell configWithShopCategory:self.categoryArray[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.categoryArray count]-1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductViewController *productViewController = [[ProductViewController alloc] initWithNibName:@"ProductViewController" bundle:nil];
    productViewController.categoryId = [[self.categoryArray objectAtIndex:indexPath.row] categoryId];
    productViewController.categoryName = [[self.categoryArray objectAtIndex:indexPath.row] name];
    [self.navigationController pushViewController:productViewController animated:YES];
}

- (void)detailButtonPressed:(UITableViewCell *)cell button:(id)sender{
    NSIndexPath *indexPath = [self.categoryTableView indexPathForCell:cell];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Detail"
                                                    message:[NSString stringWithFormat:@"Category %@",[self.categoryArray[indexPath.row] name]]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
