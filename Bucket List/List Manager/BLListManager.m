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
#import "BLList.h"
#import "BLDesignFactory.h"

@interface BLListManager ()

@property (nonatomic, strong) NSMutableArray *listsToBeSaved;
@property (nonatomic, weak) id<BLPresenterDelegate> delegate;
@end

@implementation BLListManager

static NSString *cellID = @"List Manager Cell";
static NSString *addListCellID = @"Add List Cell";

- (id)initWithStyle:(UITableViewStyle)style delegate:(id<BLPresenterDelegate>)delegate
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        // The className to query on
        self.parseClassName = @"BLList";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // The title for this table in the Navigation Controller.
#warning Does not work
        self.title = @"Lists";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        // Default
        //self.objectsPerPage = ;
        
        self.delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[PFTableViewCell class] forCellReuseIdentifier:cellID];
    [self.tableView registerClass:[BLAddItemTableViewCell class] forCellReuseIdentifier:addListCellID];
    self.tableView.separatorColor = [BLDesignFactory cellSeparatorColor];
    self.tableView.backgroundColor = [BLDesignFactory mainBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self deselectRows];
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
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query whereKey:@"creatorName" equalTo:[PFUser currentUser].username];
    //[query whereKey:@"participants" containsString:[PFUser currentUser].username];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"dateCreated"];
    
    return query;
}



// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    

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
        PFTableViewCell *cell = [tableView
                                 dequeueReusableCellWithIdentifier:cellID
                                 forIndexPath:indexPath];
        cell.backgroundColor = [BLDesignFactory cellBackgroundColor];
        cell.backgroundColor = [BLDesignFactory cellBackgroundColor];
        
        [cell.textLabel setFont:[UIFont flatFontOfSize:28]];
        [cell.textLabel setTextColor:[BLDesignFactory textColor]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [object objectForKey:self.textKey];
        return cell;
    }
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
    NSLog(@"rows in section called");
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

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.row == 0) {
        return NO;
    } else
        return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
#warning Will need to handle the case where a list with multiple owners is deleted
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        PFObject *object = [self objectAtIndexPath:indexPath];
#warning display activity indicator and create a background task
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            [self loadObjects];
        }];
    }
}



#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
#warning display activity indicator and create a background task
    NSString *text = [textField.text
                      stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([text length] > 0) {
        BLList *listItem = [[BLList alloc] init];
        listItem.name = text;
        listItem.dateLastUpdated = [NSDate date];
        listItem.dateCreated = [NSDate date];
        listItem.creatorUserName = [PFUser currentUser].username;
        listItem.participants = [NSMutableArray arrayWithArray:@[[PFUser currentUser].username]];
        
        PFObject *item = listItem.returnAsPFObject;
        [item saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
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
