//
//  ImageFullScreenViewController.m
//  AFNetworkingJSON
//
//  Created by Toan Slan on 11/27/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import "ImageFullScreenViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ImageFullScreenViewController ()

<
UIScrollViewDelegate
>

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *productImageScrollView;

@end

@implementation ImageFullScreenViewController

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
    [self setViewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [self setViewWillAppear];
}

- (void)setViewDidLoad{
    
    [self.productImageView setImageWithURL:[NSURL URLWithString:self.imageURL]];
    self.productImageView.frame = (CGRect){.origin = CGPointMake(0.0f, 0.0f), .size=self.productImageView.image.size};
    [self.productImageScrollView addSubview:self.productImageView];
    self.productImageScrollView.contentSize = self.productImageView.image.size;
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.productImageScrollView addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.productImageScrollView addGestureRecognizer:twoFingerTapRecognizer];
}

- (void)setViewWillAppear{
    CGRect scrollViewFrame = self.productImageScrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.productImageScrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.productImageScrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.productImageScrollView.minimumZoomScale = minScale;
    self.productImageScrollView.maximumZoomScale = 1.0f;
    self.productImageScrollView.zoomScale = minScale;
    
    [self centerScrollViewContents];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationItem setTitle:self.imageTitle];
}

- (void)centerScrollViewContents{
    CGSize boundsSize = self.productImageScrollView.bounds.size;
    CGRect contentsFrame = self.productImageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.productImageView.frame = contentsFrame;
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer *)recognizer{
    CGPoint pointInView = [recognizer locationInView:self.productImageView];
    
    CGFloat newZoomScale = self.productImageScrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.productImageScrollView.maximumZoomScale);
    
    CGSize scrollViewSize = self.productImageScrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    [self.productImageScrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer *)recognizer{
    
    CGFloat newZoomScale = self.productImageScrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.productImageScrollView.minimumZoomScale);
    [self.productImageScrollView setZoomScale:newZoomScale animated:YES];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.productImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    [self centerScrollViewContents];
}

@end
