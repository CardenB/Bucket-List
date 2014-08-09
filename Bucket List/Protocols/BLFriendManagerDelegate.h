//
//  BLFriendManagerDelegate.h
//  Bucket List
//
//  Created by Carden Bagwell on 8/9/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLUser.h"

@protocol BLFriendManagerDelegate <NSObject>

- (void)addFriend:(BLUser *)user cell:(UITableViewCell *)cell;

- (void)removeFriend:(BLUser *)user cell:(UITableViewCell *)cell;

@end
