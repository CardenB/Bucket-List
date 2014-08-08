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

@interface BLFriendsManager ()

@property id<BLNavigationDelegate> navigator;

@property NSArray *originalData;
@property NSMutableArray *searchData;

@property UISearchBar *searchBar;

@end

@implementation BLFriendsManager

static NSString *cellID = @"Friends Cell ID";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNavigationDelegate:(id<BLNavigationDelegate>)delegate
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.navigator = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setBackgroundColor:[BLDesignFactory mainBackgroundColor]];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 70, 320, 44)];
    [self.searchBar setBarTintColor:[BLDesignFactory loginBackgroundColor]];
    [self setSearchBar:self.searchBar];
    self.tableView.tableHeaderView = self.searchBar;
    self.searchBar.delegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    // Configure the cell...
    BLUser *friend = [BLUser currentUser].friends[indexPath.row];
    cell.textLabel.text = friend.name;
    
    return cell;
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


#pragma mark - UISearchBar Delegate

#pragma mark - UISearchDisplayController DataSource

#pragma mark - UISearchDisplayController Delegate

#pragma mark - Search Bar

- (void)filterForSearchText:(NSString *)text
                      scope:(NSString *)scope
{
    
    /**stack overflow code**/
    
    PFQuery *userQuery = [BLUser query];
    
    NSArray *userArray = [userQuery findObjects];
    
    //create filter for searching info collection
    NSPredicate *filterPredicate = [NSPredicate
                                    predicateWithFormat:@"%@ like self.username OR %@ like self.name",
                                    text];
    //retrieve search results
    self.searchData = [NSMutableArray
                       arrayWithArray:[userArray
                                       filteredArrayUsingPredicate:filterPredicate]];
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


/*
//used to load each individual cell
//override if sections are presented in a different way
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    NSMutableArray *cellDataCollection;
    
    CTManagerCell *mCell;
    if (tableView == [[self searchDisplayController] searchResultsTableView])
    {
        cellDataCollection = self.filteredCollection;
        
        mCell = [[[self searchDisplayController]
                  searchResultsTableView] dequeueReusableCellWithIdentifier:self.CellID
                 forIndexPath:indexPath];
    }
    else
    {
        cellDataCollection = self.infoCollection;
        //override the getter for CellID to create with the proper identifier
        mCell = [tableView
                 dequeueReusableCellWithIdentifier:self.CellID
                 forIndexPath:indexPath];
    }
    
    
    //override the getter for name in the object model to create the proper title
    mCell.TitleLabel.text = ((NSObject<CTModelProtocol> *)[cellDataCollection objectAtIndex:indexPath.row]).labelName;
    cell = mCell;
    return cell;
}
*/

/*
//used to push detail view
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == [[self searchDisplayController] searchResultsTableView])
    {
        [self.delegate presentViewAsDetail:[self initializeDetailView:[self.filteredCollection objectAtIndex:indexPath.row]]];
    }
    else
    {
        [self.delegate presentViewAsDetail:[self initializeDetailView:[self.infoCollection objectAtIndex:indexPath.row]]];
    }
    
}
*/
@end
