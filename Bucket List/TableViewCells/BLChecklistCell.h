//
//  BLChecklistCell.h
//  Bucket List
//
//  Created by Carden Bagwell on 8/13/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLItem.h"

@interface BLChecklistCell : UITableViewCell< UITextFieldDelegate >

@property IBOutlet UITextField *itemNameField;
@property IBOutlet UIButton *completeButton;
@property BLItem *item;

@end
