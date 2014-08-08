//
//  BLUserTableViewCell.m
//  Bucket List
//
//  Created by Carden Bagwell on 8/8/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLUserTableViewCell.h"
#import "UIImageView+Letters.h"
#import "UIImage+FlatUI.h"

@implementation BLUserTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (id)initWithUser:(BLUser *)user reuseIdentifier:(NSString *)identifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    if (self) {
        self.detailTextLabel.text = user.username;
        self.textLabel.text = user.propercaseFullName;

        UIImage *image = [UIImage imageWithColor:[UIColor brownColor] cornerRadius:0.0f];
        [self.imageView setImage:image];
        
        //[self.contentView addSubview:img];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFriend:(BLUser *)user
{
    self.detailTextLabel.text = user.username;
    self.textLabel.text = user.propercaseFullName;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [img setImageWithString:@"Carden Bagwell"];
    [self.imageView setImage:img.image];
}
@end
