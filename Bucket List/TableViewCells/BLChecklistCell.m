//
//  BLChecklistCell.m
//  Bucket List
//
//  Created by Carden Bagwell on 8/13/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLChecklistCell.h"
#import "BLDesignFactory.h"

@implementation BLChecklistCell

@synthesize item = _item;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(12, 6, 31, 31)];
        self.completeButton = button;
        
        UITextField *itemNameField = [[UITextField alloc] initWithFrame:CGRectMake(self.contentView.frame.origin.x + 52, 0, self.contentView.frame.size.width-52, self.contentView.frame.size.height)];
        
        self.itemNameField = itemNameField;
        [self.itemNameField setBackgroundColor:[UIColor clearColor]];
        //[self.itemNameField sizeThatFits:CGSizeMake(self.contentView.frame.size.width - 52, self.contentView.frame.size.height)];
        
        CGFloat cornerRad = self.completeButton.bounds.size.width/2.0;
        
        [self.completeButton setBackgroundImage:[UIImage imageWithColor:[BLDesignFactory incompleteItemColor] cornerRadius:cornerRad] forState:UIControlStateNormal];
        [self.completeButton setBackgroundImage:[UIImage imageWithColor:[BLDesignFactory completedItemColor] cornerRadius:cornerRad] forState:UIControlStateSelected];
        
        [self.contentView addSubview:self.completeButton];
        [self.contentView addSubview:self.itemNameField];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [BLDesignFactory cellBackgroundColor];
    self.backgroundColor = [BLDesignFactory cellBackgroundColor];
    
    [self.itemNameField setFont:[UIFont flatFontOfSize:28]];
    [self.itemNameField setTextColor:[BLDesignFactory textColor]];
}

- (BLItem *)item
{
    return _item;
}
- (void)setItem:(BLItem *)item
{
    self.selected = item.completed;
    [self.itemNameField setText:item.name];
    [self.completeButton addTarget:self action:@selector(completeItem:) forControlEvents:UIControlEventTouchUpInside];

    _item = item;
}

- (void)completeItem:(id)sender
{
    [self.completeButton setSelected:!(self.completeButton.selected)];
     if (self.item.completed) {
         self.item.completed = @NO;
     } else {
         self.item.completed = @YES;
     }
     [self.item saveInBackground];
}


@end
