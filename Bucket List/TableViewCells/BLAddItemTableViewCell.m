//
//  BLAddItemTableViewCell.m
//  Bucket List
//
//  Created by Carden Bagwell on 7/25/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLAddItemTableViewCell.h"
#import "BLDesignFactory.h"


@implementation BLAddItemTableViewCell

#warning need to set background of load new page cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    FUITextField *textField = [[FUITextField alloc]
                               initWithFrame:CGRectMake(50, 12,
                                                        CGRectGetMaxX(self.contentView.bounds) - 80,
                                                        CGRectGetMaxY(self.contentView.bounds) - 18)];
    self.textField = textField;
    return self;
}

- (void)layoutSubviews
{
    FUIButton *addButton = [[FUIButton alloc] init];
    addButton.frame = CGRectMake(15, 0, 30, 44);
    [addButton.titleLabel setFont:[UIFont lightFlatFontOfSize:30]];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setTitleColor:[BLDesignFactory iconTintColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(buttonPressedEvent) forControlEvents:UIControlEventTouchDown];
    
    
    self.textField.placeholder = @"Add a new list!";
    [self.textField setTextColor:[BLDesignFactory textColor]];
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.frame = CGRectMake(50, 12,
                                      CGRectGetMaxX(self.contentView.bounds) - 80,
                                      CGRectGetMaxY(self.contentView.bounds) - 18);
    
    [self.contentView addSubview:addButton];
    [self.contentView addSubview:self.textField];
    //self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}

- (void)buttonPressedEvent
{
    [self setSelected:YES];
    [self.textField becomeFirstResponder];
}

@end