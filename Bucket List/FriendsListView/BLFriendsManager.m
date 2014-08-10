//
//  BLFriendsManager.m
//  Bucket List
//
//  Created by Carden Bagwell on 8/6/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLFriendsManager.h"
#import "BLNavigationDelegate.h"

@interface BLFriendsManager ()

@property id<BLNavigationDelegate> navigator;


@end

@implementation BLFriendsManager

static NSString *cellID = @"Friends Cell ID";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.displayCollection = [BLUser currentUser].friends;
        self.displayObjectIdArray = [[BLUser currentUser] friendObjectIdArray];
        self.friendCollection = [BLUser currentUser].friends;
        self.friendObjectIdArray = [[BLUser currentUser] friendObjectIdArray];
        self.remoteObject = [BLUser currentUser];
    }
    return self;
}
- (id)initWithNavigationDelegate:(id<BLNavigationDelegate>)delegate
{
    self = [self initWithStyle:UITableViewStylePlain];
    if (self) {
        self.navigator = delegate;
    }
    return self;
}
#pragma mark - childViewController Delegate

- (void)updateNavigationBar
{
    [self.parentViewController.navigationItem
     setLeftBarButtonItem:[[UIBarButtonItem alloc]
                           initWithTitle:@"< Lists"
                           style:UIBarButtonItemStyleBordered
                           target:self.navigator
                           action:@selector(navigateLeft)]
     animated:YES];
    
    [self.parentViewController.navigationItem
     setRightBarButtonItem:nil
     animated:YES];
}

#pragma mark - Search Bar

- (void)filterForSearchText:(NSString *)text
                      scope:(NSString *)scope
{
    
    //self.searchData = [[NSMutableArray alloc] init];
    
    PFQuery *emailQuery = [BLUser query];
    [emailQuery whereKey:@"username" hasPrefix:text];
    PFQuery *firstNameQuery = [BLUser query];
    PFQuery *lastNameQuery = [BLUser query];
    PFQuery *fullNameQuery = [BLUser query];
    [firstNameQuery whereKey:@"lowercaseFirstName" hasPrefix:text.lowercaseString];
    [lastNameQuery whereKey:@"lowercaseLastName" hasPrefix:text.lowercaseString];
    [fullNameQuery whereKey:@"lowercaseFullName" hasPrefix:text.lowercaseString];
    
    PFQuery *compoundQuery = [PFQuery orQueryWithSubqueries:@[emailQuery, firstNameQuery, lastNameQuery, fullNameQuery]];
    [compoundQuery whereKey:@"objectId" notEqualTo:[BLUser currentUser].objectId];
    
    [compoundQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            [self.searchData removeAllObjects];
            [self.searchData addObjectsFromArray:objects];
            [self.searchDisplayController.searchResultsTableView reloadData];
        }
    }];
    
}

@end
