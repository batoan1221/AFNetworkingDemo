//
//  ImageFullScreenViewController.h
//  AFNetworkingJSON
//
//  Created by Toan Slan on 11/27/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductViewController.h"

@interface ImageFullScreenViewController : UIViewController

@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *imageTitle;

- (void)centerScrollViewContents;
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;

@end
