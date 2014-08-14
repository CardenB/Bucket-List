
//
//  LSListManager.m
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLAddItemTableViewCell.h"
#import "BLListTableViewController.h"
#import "BLListManager.h"
#import "BLUser.h"
#import "BLDesignFactory.h"
#import "BLProfileView.h"


@interface BLListManager ()

@property (nonatomic, strong) NSMutableArray *listsToBeSaved;
@property (nonatomic, weak) id<BLNavigationDelegate> navigator;
@property BOOL statusBarHidden;
@end

@implementation BLListManager

static NSString *cellID = @"List Manager Cell";
static NSString *addListCellID = @"Add List Cell";


- (id)initWithStyle:(UITableViewStyle)style delegate:(id<BLNavigationDelegate>)delegate
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _statusBarHidden = NO;
        
        // The className to query on
        self.parseClassName = @"BLList";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // The title for this table in the Navigation Controller.
        self.title = @"";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        // Default
        //self.objectsPerPage = ;
        
        self.navigator = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[BLAddItemTableViewCell class] forCellReuseIdentifier:addListCellID];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< Settings" style:UIBarButtonItemStyleBordered target:self.navigator action:@selector(navigateLeft)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Friends >" style:UIBarButtonItemStyleBordered target:self action:nil];
    
    
    // Send request to Facebook
    /*
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        if (!error) {
            // Parse the data received
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            
            NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:7];
            
            if (facebookID) {
                userProfile[@"facebookId"] = facebookID;
            }
            
            if (userData[@"name"]) {
                userProfile[@"name"] = userData[@"name"];
            }
            
            if (userData[@"location"][@"name"]) {
                userProfile[@"location"] = userData[@"location"][@"name"];
            }
            
            if (userData[@"gender"]) {
                userProfile[@"gender"] = userData[@"gender"];
            }
            
            if (userData[@"birthday"]) {
                userProfile[@"birthday"] = userData[@"birthday"];
            }
            
            if (userData[@"relationship_status"]) {
                userProfile[@"relationship"] = userData[@"relationship_status"];
            }
            
            if ([pictureURL absoluteString]) {
                userProfile[@"pictureURL"] = [pictureURL absoluteString];
            }
            
            [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
            [[PFUser currentUser] saveInBackground];
            
            [self updateProfile];
        } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                    isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
            //[self logoutButtonTouchHandler:nil];
        } else {
            NSLog(@"Some other error: %@", error);
        }
    }];
    */
    
}

// Set received values if they are not nil and reload the table
- (void)updateProfile {
    /*
    if ([[PFUser currentUser] objectForKey:@"profile"][@"location"]) {
        [self.rowDataArray replaceObjectAtIndex:0 withObject:[[PFUser currentUser] objectForKey:@"profile"][@"location"]];
    }
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"gender"]) {
        [self.rowDataArray replaceObjectAtIndex:1 withObject:[[PFUser currentUser] objectForKey:@"profile"][@"gender"]];
    }
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"birthday"]) {
        [self.rowDataArray replaceObjectAtIndex:2 withObject:[[PFUser currentUser] objectForKey:@"profile"][@"birthday"]];
    }
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"relationship"]) {
        [self.rowDataArray replaceObjectAtIndex:3 withObject:[[PFUser currentUser] objectForKey:@"profile"][@"relationship"]];
    }
    
    [self.tableView reloadData];
    
    // Set the name in the header view label
    if ([[PFUser currentUser] objectForKey:@"profile"][@"name"]) {
        self.headerNameLabel.text = [[PFUser currentUser] objectForKey:@"profile"][@"name"];
    }
    
    // Download the user's facebook profile picture
    self.imageData = [[NSMutableData alloc] init]; // the data will be loaded in here
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"pictureURL"]) {
        NSURL *pictureURL = [NSURL URLWithString:[[PFUser currentUser] objectForKey:@"profile"][@"pictureURL"]];
        
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:pictureURL
                                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:2.0f];
        // Run network request asynchronously
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        if (!urlConnection) {
            NSLog(@"Failed to download picture");
        }
    }
     */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self deselectRows];
}

- (void)updateNavigationBar
{
    [self.parentViewController.navigationItem
     setLeftBarButtonItem:[[UIBarButtonItem alloc]
                           initWithTitle:@"< Settings"
                           style:UIBarButtonItemStyleBordered
                           target:self.navigator
                           action:@selector(navigateLeft)]
     animated:YES];
    
    [self.parentViewController.navigationItem
     setRightBarButtonItem:[[UIBarButtonItem alloc]
                            initWithTitle:@"Add Friends >"
                            style:UIBarButtonItemStyleBordered
                            target:self.navigator
                            action:@selector(navigateRight)]
     animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)deselectRows
{
    for (NSIndexPath *path in self.tableView.indexPathsForSelectedRows) {
        [self.tableView deselectRowAtIndexPath:path animated:NO];
    }
}

#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [self.listsToBeSaved removeAllObjects];
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    PFQuery *listQuery = [BLList query];
    //TODO: find last user to update instead of creator
    [listQuery whereKey:kListParticipants equalTo:[BLUser currentUser]];
    
    
    //[query whereKey:@"participants" containsString:[PFUser currentUser].username];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        listQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [listQuery orderByDescending:@"updatedAt"];
    
    return listQuery;
}



// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(BLList *)listObject {
    

    if (indexPath.row == 0)
    {
        
        BLAddItemTableViewCell *cell = [tableView
                               dequeueReusableCellWithIdentifier:addListCellID
                               forIndexPath:indexPath];
        
        cell.backgroundColor = [BLDesignFactory cellBackgroundColor];
        cell.textField.delegate = self;
        return cell;
        
    }
    else
    {
        return [self tableView:tableView createListCellAtIndexPath:indexPath object:listObject];
    }
}

- (PFTableViewCell *)tableView:(UITableView *)tableView
         createListCellAtIndexPath:(NSIndexPath *)indexPath
                        object:(BLList *)listObject
{
    PFTableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.backgroundColor = [BLDesignFactory cellBackgroundColor];
    cell.backgroundColor = [BLDesignFactory cellBackgroundColor];
    
    [cell.textLabel setFont:[UIFont flatFontOfSize:24]];
    [cell.textLabel setTextColor:[BLDesignFactory textColor]];
    
    [cell.detailTextLabel setFont:[UIFont flatFontOfSize:8]];
    [cell.detailTextLabel setTextColor:[BLDesignFactory textColor]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *stringFromDateTime = [formatter stringFromDate:listObject.createdAt];
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = listObject.name;
    
    [listObject.creator fetchIfNeeded];
    cell.detailTextLabel.text = [NSString
                                 stringWithFormat:@"Created by %@, %@",
                                 ((BLUser *)listObject.creator).propercaseFullName,
                                 stringFromDateTime];
    
    return cell;
}



#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [((BLAddItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textField becomeFirstResponder];
    } else {
        BLListTableViewController *viewController = [[BLListTableViewController alloc]
                                                     initWithStyle:UITableViewStylePlain
                                                     object:[self objectAtIndexPath:indexPath]];
        
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [((BLAddItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textField resignFirstResponder];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count + 1;
}

- (PFObject *)objectAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return nil;
    }
    else {
        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:0];
        return [super objectAtIndexPath:path];
    }
}

- (PFObject *)filterObjectAtIndexPath:(BOOL)useSuper indexPath:(NSIndexPath *)indexPath
{
    if (useSuper) {
        return [super objectAtIndexPath:indexPath];
    } else {
        return [self objectAtIndexPath:indexPath];
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.row == 0) {
        return NO;
    } else
        return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        BLList *list = (BLList *)[self objectAtIndexPath:indexPath];
        [self removeParticipant:list];

    }
}

- (void)removeParticipant:(BLList *)list
{
    
    NSMutableArray *participantArray = [[NSMutableArray alloc] initWithCapacity:list.participants.count];
    [participantArray addObjectsFromArray:list.participants];
    
    #warning display activity indicator and create a background task
    for (BLUser *user in participantArray)
    {
        if ([user.objectId isEqualToString:[BLUser currentUser].objectId]) {
            [participantArray removeObject:user];
            if (participantArray.count == 0) {
                [list deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                }];
            } else {
                list.participants = participantArray;
                [list save];
                
            }

            break;
        }
    }
    [self loadObjects];
    
    
    
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
#warning display activity indicator and create a background task
    NSString *text = [textField.text
                      stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([text length] > 0) {
        BLList *list = [BLList object];
        list.name = text;
        list.creator = [BLUser currentUser];
        list.participants = [NSMutableArray arrayWithArray:@[[BLUser currentUser]]];
        

        [list saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (succeeded) {
                [self loadObjects];
                textField.text = @"";
                [textField resignFirstResponder];
            }
        }];

        return YES;
    }
    return NO;
}

@end
