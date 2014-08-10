//
//  BLAbstractFriendsDisplay.h
//  Bucket List
//
//  Created by Carden Bagwell on 8/10/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLFriendManagerDelegate.h"
#import "Parse/Parse.h"
#import "BLDesignFactory.h"
#import "BLUser.h"
#import "BLUserTableViewCell.h"

@interface BLAbstractFriendsDisplay : UITableViewController< UISearchBarDelegate, UISearchDisplayDelegate, BLFriendManagerDelegate >

@property PFObject *remoteObject;

@property NSMutableArray *searchData;

@property UISearchBar *searchBar;
@property UISearchDisplayController *searchController;

@property NSArray *displayCollection;
@property NSArray *displayObjectIdArray;

@end
