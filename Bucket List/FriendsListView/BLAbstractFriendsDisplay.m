//
//  BLAbstractFriendsDisplay.m
//  Bucket List
//
//  Created by Carden Bagwell on 8/10/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLAbstractFriendsDisplay.h"

@interface BLAbstractFriendsDisplay ()

@end

@implementation BLAbstractFriendsDisplay

static NSString *cellID = @"Friends Cell ID";

@synthesize friendCollection;
@synthesize friendObjectIdArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.searchData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISearchBar *searchBar = [[UISearchBar alloc]
                              initWithFrame:self.tableView.tableHeaderView.frame];
    
    [BLDesignFactory customizeSearchBar:searchBar];
    
    self.searchController = [[UISearchDisplayController alloc]
                             initWithSearchBar:searchBar
                             contentsController:self];
    [self.searchDisplayController setSearchResultsDataSource:self];
    [self.searchDisplayController setSearchResultsDelegate:self];
    [self.searchDisplayController setDelegate:self];
    [self.searchDisplayController.searchBar setBarTintColor:[BLDesignFactory loginBackgroundColor]];
    
    
    self.tableView.tableHeaderView = self.searchDisplayController.searchBar;
    [self.tableView setBackgroundColor:[BLDesignFactory mainBackgroundColor]];
    [self.tableView setSeparatorColor:[BLDesignFactory loginBackgroundColor]];
    
    [self.searchDisplayController.searchResultsTableView setBackgroundColor:[BLDesignFactory mainBackgroundColor]];
    [self.searchDisplayController.searchResultsTableView setSeparatorColor:[BLDesignFactory loginBackgroundColor]];
    
    [self.tableView registerClass:[BLUserTableViewCell class] forCellReuseIdentifier:cellID];
    [self.searchDisplayController.searchResultsTableView registerClass:[BLUserTableViewCell class] forCellReuseIdentifier:cellID];
    
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLUserTableViewCell *cell = (BLUserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    BLUser *friend;
    
    if (tableView == self.searchDisplayController.searchResultsTableView ) {
        friend = [self.searchData objectAtIndex:indexPath.row];
    } else {
        friend = self.displayCollection[indexPath.row];
    }
    
    [friend fetchIfNeeded];
    
    cell.delegate = self;
    cell.user = friend;
    [BLDesignFactory customizeUserCell:cell user:friend];
    
    if ([self.friendObjectIdArray containsObject:friend.objectId]) {
        [cell.addUserButton setSelected:YES];
    } else {
        [cell.addUserButton setSelected:NO];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[BLDesignFactory mainBackgroundColor]];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

#pragma mark - Search Bar

- (void)filterForSearchText:(NSString *)text
                      scope:(NSString *)scope
{
    //OVERRIDE IN SUBCLASS
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterForSearchText:searchString scope:[[[[self searchDisplayController]
                                                    searchBar] scopeButtonTitles]
                                                  objectAtIndex:[[[self searchDisplayController]
                                                                  searchBar]
                                                                 selectedScopeButtonIndex]]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterForSearchText:self.searchDisplayController.searchBar.text
                        scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                               objectAtIndex:searchOption]];
    return YES;
}



#pragma mark - Table View Data Source

//used to customize the way items are grouped into sections
//can be used for alphabetical distinction
//can be ignored by just returning 1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//used to specify number of items in each section
//usually will just be the number of items
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == [[self searchDisplayController] searchResultsTableView])
    {
        return self.searchData.count;
    }
    else
    {
        return self.displayCollection.count;
    }
}

#pragma mark - Friend management data source


- (void)addFriend:(BLUser *)user cell:(UITableViewCell *)cell
{
    if (!self.friendCollection) {
        self.friendCollection = @[user];
    } else {
        self.friendCollection = [self.friendCollection arrayByAddingObject:user];
    }
    [self.remoteObject save];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.friendCollection indexOfObject:user] inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
- (void)removeFriend:(BLUser *)user cell:(UITableViewCell *)cell
{
    
    NSMutableArray *friendsArray = [[NSMutableArray alloc] initWithCapacity:self.friendCollection.count];
    [friendsArray addObjectsFromArray:self.friendCollection];
    
    for (BLUser *friend in friendsArray)
    {
        if ([friend.objectId isEqualToString:user.objectId]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.friendCollection indexOfObject:friend] inSection:0];
            [friendsArray removeObject:friend];
            self.friendCollection = friendsArray;
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
    [self.remoteObject save];
    
    
}

@end
