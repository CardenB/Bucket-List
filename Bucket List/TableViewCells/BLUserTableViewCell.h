//
//  BLUserTableViewCell.h
//  Bucket List
//
//  Created by Carden Bagwell on 8/8/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLUser.h"

@interface BLUserTableViewCell : UITableViewCell

- (id)initWithUser:(BLUser *)user reuseIdentifier:(NSString *)identifier;

- (void)setFriend:(BLUser *)user;

@end
