//
//  BLEditFieldTableViewCell.m
//  Bucket List
//
//  Created by Carden Bagwell on 8/14/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLEditFieldTableViewCell.h"

@implementation BLEditFieldTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
