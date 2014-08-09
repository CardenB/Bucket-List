//
//  BLFriendsManager.m
//  Bucket List
//
//  Created by Carden Bagwell on 8/6/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLFriendsManager.h"
#import "BLNavigationDelegate.h"
#import "BLDesignFactory.h"
#import "BLUser.h"
#import "Parse/Parse.h"
#import "BLUserTableViewCell.h"


@interface BLFriendsManager ()

@property id<BLNavigationDelegate> navigator;

@property NSArray *originalData;
@property NSMutableArray *searchData;

@property UISearchBar *searchBar;
@property UISearchDisplayController *searchController;

@end

@implementation BLFriendsManager

static NSString *cellID = @"Friends Cell ID";

- (id)initWithNavigationDelegate:(id<BLNavigationDelegate>)delegate
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.navigator = delegate;
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
    
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLUserTableViewCell *cell = (BLUserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];

    BLUser *friend;
    
    if (tableView == self.searchDisplayController.searchResultsTableView ) {
        friend = [self.searchData objectAtIndex:indexPath.row];
    } else {
        friend = [BLUser currentUser].friends[indexPath.row];
    }
    
    [friend fetchIfNeeded];
    
    cell.delegate = self;
    cell.user = friend;
    
    cell.textLabel.text = friend.propercaseFullName;
    cell.detailTextLabel.text = friend.username;
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [img setImageWithString:friend.propercaseFullName];
    
    [cell.imageView setImage:img.image];
    
    if ([[[BLUser currentUser] friendObjectIdArray] containsObject:friend.objectId]) {
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
        return [BLUser currentUser].friends.count;
    }
}

#pragma mark - Friend management data source


- (void)addFriend:(BLUser *)user cell:(UITableViewCell *)cell
{
    if (![BLUser currentUser].friends) {
        [BLUser currentUser].friends = @[user];
    } else {
        [BLUser currentUser].friends = [[BLUser currentUser].friends arrayByAddingObject:user];
    }
    [[BLUser currentUser] save];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[BLUser currentUser].friends indexOfObject:user] inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

}
- (void)removeFriend:(BLUser *)user cell:(UITableViewCell *)cell
{

    NSMutableArray *friendsArray = [[NSMutableArray alloc] initWithCapacity:[BLUser currentUser].friends.count];
    [friendsArray addObjectsFromArray:[BLUser currentUser].friends];

    for (BLUser *friend in friendsArray)
    {
        if ([friend.objectId isEqualToString:user.objectId]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[BLUser currentUser].friends indexOfObject:friend] inSection:0];
            [friendsArray removeObject:friend];
            [BLUser currentUser].friends = friendsArray;
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
    [[BLUser currentUser] save];


}

@end
