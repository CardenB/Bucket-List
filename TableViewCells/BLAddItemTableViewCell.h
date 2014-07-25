//
//  BLAddItemTableViewCell.h
//  Bucket List
//
//  Created by Carden Bagwell on 7/25/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlatUIKit.h"

@interface BLAddItemTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet FUITextField *textField;

@property (nonatomic, weak) id<UITextFieldDelegate> textFieldDelegate;

@end
