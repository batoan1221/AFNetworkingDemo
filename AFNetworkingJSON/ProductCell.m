//
//  ProductCell.m
//  AFNetworkingJSON
//
//  Created by Toan Slan on 11/27/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import "ProductCell.h"
#import "Product.h"
#import "ProductCellView.h"
#import "UIImageView+AFNetworking.h"

@interface ProductCell()

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockStatusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;


@end

@implementation ProductCell



- (void)configCellWithProduct:(Product *)product{
    self.productNameLabel.text = product.name;
    self.priceLabel.text = product.price;
    self.stockStatusLabel.text = product.stockStatus;
    [self.firstImageView setImageWithURL:[NSURL URLWithString:[[product.imageMutableArray firstObject] imageLarge]]];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
