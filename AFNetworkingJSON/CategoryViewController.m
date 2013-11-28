//
//  CategoryViewController.m
//  AFNetworkingJSON
//
//  Created by Toan Slan on 11/27/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryCell.h"
#import "ProductViewController.h"
#import "MYIntroductionPanel.h"
#import "MYBlurIntroductionView.h"
#import "AMBlurView.h"
#import "NSMutableArray+Additions.h"

@interface CategoryViewController ()

<
UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate,
CategoryCellDelegate,
MYIntroductionDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (strong, nonatomic) NSMutableArray *categoryArray;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;

@end

@implementation CategoryViewController

- (NSMutableArray *)categoryArray{
    if (!_categoryArray) {
        _categoryArray = [NSMutableArray array];
    }
    return _categoryArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"]) {
        [self buildIntro];
    }
    NSURL *url = [[NSURL alloc] initWithString:@"http://jkshop-staging.ap01.aws.af.cm/?json=products/tk_get_list_categories"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id reponseObject){
        for (int i = 0; i < [reponseObject count]; i++) {
            [self.categoryArray addObject:[[ShopCategory alloc] initWithDictionary:[reponseObject objectForKey:[NSString stringWithFormat:@"%d",i]]]];
        }
        [self.spinner stopAnimating];
        [self.categoryTableView reloadData];
        
    }failure:nil];
    
    [operation start];
    [self setViewDidLoad];
}

- (void)setViewDidLoad{
    self.categoryArray = [self.categoryArray getCategoryArrayFromJSONWithTableViewToReload:self.categoryTableView];    
    [self.navigationItem setTitle:@"Category"];
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = CGPointMake(160, 240);
    self.spinner.hidesWhenStopped = YES;
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
    [self.categoryTableView registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellReuseIdentifier:@"CategoryCell"];
    
}

-(void)buildIntro{
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Automated Stock Panels" description:@"Need a quick-and-dirty solution for your app introduction? MYBlurIntroductionView comes with customizable stock panels that make writing an introduction a walk in the park. Stock panels come with optional blurring (iOS 7) and background image. A full panel is just one method away!" image:[UIImage imageNamed:@"jk.png"]];
    MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Automated Stock Panels" description:@"Need a quick-and-dirty solution for your app introduction? MYBlurIntroductionView comes with customizable stock panels that make writing an introduction a walk in the park. Stock panels come with optional blurring (iOS 7) and background image. A full panel is just one method away!" image:[UIImage imageNamed:@"jk.png"]];
    MYIntroductionPanel *panel4 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Automated Stock Panels" description:@"Need a quick-and-dirty solution for your app introduction? MYBlurIntroductionView comes with customizable stock panels that make writing an introduction a walk in the park. Stock panels come with optional blurring (iOS 7) and background image. A full panel is just one method away!" image:[UIImage imageNamed:@"jk.png"]];
    MYIntroductionPanel *panel5 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Automated Stock Panels" description:@"Need a quick-and-dirty solution for your app introduction? MYBlurIntroductionView comes with customizable stock panels that make writing an introduction a walk in the park. Stock panels come with optional blurring (iOS 7) and background image. A full panel is just one method away!" image:[UIImage imageNamed:@"jk.png"]];
    NSArray *panels = @[panel2,panel3,panel4,panel5];
    
    MYBlurIntroductionView *introductionView = [[MYBlurIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    introductionView.delegate = self;
    [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:0.65]];
    introductionView.BackgroundImageView.image = [UIImage imageNamed:@"moon.jpg"];
    [introductionView buildIntroductionWithPanels:panels];
    
    self.navigationController.navigationBar.layer.zPosition = -1;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:introductionView];
}

-(void)introduction:(MYBlurIntroductionView *)introductionView didChangeToPanel:(MYIntroductionPanel *)panel withIndex:(NSInteger)panelIndex{
    NSLog(@"Introduction did change to panel %d", panelIndex);

    if (panelIndex == 0) {
        [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:0.65]];
    }

    else if (panelIndex == 1){
        [introductionView setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:0.65]];
    }
    
}

-(void)introduction:(MYBlurIntroductionView *)introductionView didFinishWithType:(MYFinishType)finishType{
    self.navigationController.navigationBar.layer.zPosition = 1;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    NSUserDefaults * usedDefault = [NSUserDefaults standardUserDefaults];
    [usedDefault setBool:YES forKey:@"logged_in"];
    [usedDefault synchronize];
}

-(void)buildIntro{
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Automated Stock Panels" description:@"Need a quick-and-dirty solution for your app introduction? MYBlurIntroductionView comes with customizable stock panels that make writing an introduction a walk in the park. Stock panels come with optional blurring (iOS 7) and background image. A full panel is just one method away!" image:[UIImage imageNamed:@"jk.png"]];
    MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Automated Stock Panels" description:@"Need a quick-and-dirty solution for your app introduction? MYBlurIntroductionView comes with customizable stock panels that make writing an introduction a walk in the park. Stock panels come with optional blurring (iOS 7) and background image. A full panel is just one method away!" image:[UIImage imageNamed:@"jk.png"]];
    MYIntroductionPanel *panel4 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Automated Stock Panels" description:@"Need a quick-and-dirty solution for your app introduction? MYBlurIntroductionView comes with customizable stock panels that make writing an introduction a walk in the park. Stock panels come with optional blurring (iOS 7) and background image. A full panel is just one method away!" image:[UIImage imageNamed:@"jk.png"]];
    MYIntroductionPanel *panel5 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Automated Stock Panels" description:@"Need a quick-and-dirty solution for your app introduction? MYBlurIntroductionView comes with customizable stock panels that make writing an introduction a walk in the park. Stock panels come with optional blurring (iOS 7) and background image. A full panel is just one method away!" image:[UIImage imageNamed:@"jk.png"]];
    NSArray *panels = @[panel2,panel3,panel4,panel5];
    
    MYBlurIntroductionView *introductionView = [[MYBlurIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    introductionView.delegate = self;
    [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:0.65]];
    introductionView.BackgroundImageView.image = [UIImage imageNamed:@"moon.jpg"];
    [introductionView buildIntroductionWithPanels:panels];
    
    self.navigationController.navigationBar.layer.zPosition = -1;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:introductionView];
}

-(void)introduction:(MYBlurIntroductionView *)introductionView didChangeToPanel:(MYIntroductionPanel *)panel withIndex:(NSInteger)panelIndex{
    NSLog(@"Introduction did change to panel %d", panelIndex);
    
    if (panelIndex == 0) {
        [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:0.65]];
    }
    else if (panelIndex == 1){
        [introductionView setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:0.65]];
    }
    
}

-(void)introduction:(MYBlurIntroductionView *)introductionView didFinishWithType:(MYFinishType)finishType{
    self.navigationController.navigationBar.layer.zPosition = 1;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
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
