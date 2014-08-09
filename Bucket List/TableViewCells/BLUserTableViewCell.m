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
#import "BLDesignFactory.h"
#import "MKToggleButton.h"

@interface BLUserTableViewCell()

@property BLUser *user;
@property IBOutlet MKToggleButton *addUserButton;

@end

@implementation BLUserTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
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

- (void)setFriend:(BLUser *)user
{
    [user fetchIfNeeded];
    self.user = user;
    
    self.detailTextLabel.text = user.username;
    self.textLabel.text = user.propercaseFullName;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.imageView.layer.cornerRadius = img.frame.size.height/2;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = 0;
    [img setImageWithString:@"Carden Bagwell"];
    [self.imageView setImage:img.image];
    
    MKToggleButton *button = [[MKToggleButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 100, self.frame.size.height/2 - 12, 80, 24)];
    button.showsBorder = YES;
    button.showsTouchWhenHighlighted = YES;
    [button setTitle:@"Add" forState:UIControlStateNormal];
    [button setTitleColor:[BLDesignFactory loginBackgroundColor] forState:UIControlStateNormal];
    [button setTitle:@"Added" forState:UIControlStateSelected];
    [button setTitleColor:[BLDesignFactory mainBackgroundColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(selected) forControlEvents:UIControlEventValueChanged];
    self.addUserButton = button;
    if ([[BLUser currentUser].friends containsObject:self.user]) {
        [button setSelected:YES];
    }
    [self addSubview:self.addUserButton];
}

- (void)selected
{
    if (self.addUserButton.selected) {
        if (![[BLUser currentUser].friends containsObject:self.user])
        {
            [BLUser addFriend:self.user];
        }
    } else {
        if ([[BLUser currentUser].friends containsObject:self.user])
        {
            [BLUser removeFriend:self.user];
        }
    }

}

@end
