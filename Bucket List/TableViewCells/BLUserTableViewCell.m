//
//  BLUserTableViewCell.m
//  Bucket List
//
//  Created by Carden Bagwell on 8/8/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLUserTableViewCell.h"



@interface BLUserTableViewCell()

@end

@implementation BLUserTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        
        MKToggleButton *button = [[MKToggleButton alloc]
                                  initWithFrame:
                                  CGRectMake(self.frame.size.width - 100, self.frame.size.height/2 - 12, 80, 24)];
        button.showsBorder = YES;
        button.showsTouchWhenHighlighted = YES;
        self.addUserButton = button;
        [self.contentView addSubview:self.addUserButton];

        
        CGRect frame = CGRectMake(0, 0, 40, 40);
        self.imageView.layer.cornerRadius = frame.size.height/2;
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.borderWidth = 0;
        
        [self.contentView addSubview:self.imageView];
        
    }
    return self;
}

- (void)layoutSubviews
{

    [super layoutSubviews];

    [self.addUserButton setTintColor:[BLDesignFactory loginBackgroundColor]];
    
    [self.addUserButton setTitle:@"Add" forState:UIControlStateNormal];
    [self.addUserButton setTitleColor:[BLDesignFactory loginBackgroundColor] forState:UIControlStateNormal];
    
    [self.addUserButton setTitle:@"Added" forState:UIControlStateSelected];
    [self.addUserButton setTitleColor:[BLDesignFactory mainBackgroundColor] forState:UIControlStateSelected];
    
    [self.addUserButton addTarget:self action:@selector(selected) forControlEvents:UIControlEventValueChanged];
    

}


- (void)selected
{
    if (self.addUserButton.selected) {
        if (![[self.delegate friendObjectIdArray] containsObject:self.user.objectId])
        {
            [self.delegate addFriend:self.user cell:self];
        }
    } else {
        if ([[self.delegate friendObjectIdArray] containsObject:self.user.objectId])
        {
            [self.delegate removeFriend:self.user cell:self];
        }
    }

}

@end
