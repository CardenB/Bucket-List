//
//  BLUserTableViewCell.h
//  Bucket List
//
//  Created by Carden Bagwell on 8/8/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLUser.h"
#import "BLFriendManagerDelegate.h"
#import "UIImageView+Letters.h"
#import "UIImage+FlatUI.h"
#import "BLDesignFactory.h"
#import "MKToggleButton.h"

@interface BLUserTableViewCell : UITableViewCell

@property (strong) BLUser *user;
@property IBOutlet MKToggleButton *addUserButton;
@property id<BLFriendManagerDelegate> delegate;

@end
