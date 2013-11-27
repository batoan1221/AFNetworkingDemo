//
//  CategoryCell.m
//  AFNetworkingJSON
//
//  Created by Toan Slan on 11/27/13.
//  Copyright (c) 2013 Toan Slan. All rights reserved.
//

#import "CategoryCell.h"
#import "ShopCategory.h"

@interface CategoryCell()

@property (weak, nonatomic) IBOutlet UILabel *CategoryName;

@end

@implementation CategoryCell

- (IBAction)detailButtonPressed:(id)sender {
    if([self.delegate respondsToSelector:@selector(detailButtonPressed:button:)]){
        [self.delegate detailButtonPressed:self button:sender];
    }
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

- (void)configWithShopCategory:(ShopCategory *)shopCategory{
    self.CategoryName.text = shopCategory.name;
}

@end
