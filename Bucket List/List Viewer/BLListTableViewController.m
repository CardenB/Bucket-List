//
//  LSListTableViewController.m
//  ListShare
//
//  Created by Carden Bagwell on 7/9/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLListTableViewController.h"
#import "BLList.h"
#import "BLItem.h"
#import "BLDesignFactory.h"

@interface BLListItemCell : UITableViewCell

@property (nonatomic, strong) IBOutlet FUITextField *textField;
@property (nonatomic, strong) IBOutlet FUIButton *completedButton;
@property (nonatomic, strong) IBOutlet FUIButton *starButton;
@property (nonatomic, strong) BLItem *listItem;

@property (nonatomic, weak) id<UITextFieldDelegate> textFieldDelegate;

@end

@implementation BLListItemCell

#warning need to work out selection kinks, selecting text field doesn't select the cell, selecting the button makes the cell permanently selected, touching button doesn't set the textfield to first responder

#warning need to set background of load new page cell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              model:(BLItem *)listItem
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.textField = [[FUITextField alloc] init];
    self.completedButton = [[FUIButton alloc] init];
    self.starButton = [[FUIButton alloc] init];

    
    self.listItem = listItem;
    return self;
}

- (void)layoutSubviews
{
#warning replace completed and star buttons with icons
    //replace with imageview for completion icon
    self.completedButton.frame = CGRectMake(15, 0, 30, 44);
    [self.completedButton.titleLabel setFont:[UIFont lightFlatFontOfSize:30]];
    [self.completedButton setTitle:@"O" forState:UIControlStateNormal];
    [self.completedButton setTitleColor:[BLDesignFactory iconTintColor] forState:UIControlStateNormal];
    [self.completedButton addTarget:self action:@selector(completedButtonPressedEvent)
              forControlEvents:UIControlEventTouchDown];
    
    
    self.textField.placeholder = @"Add a new list!";
    [self.textField setTextColor:[BLDesignFactory textColor]];
    self.textField.returnKeyType = UIReturnKeyDone;
    //left side at 50 pixels to give room for 15 pixel margin and 30 pixel left icon
    //right side at 110 pixels to give room for 50 pixel left side, 30 pixel margin, and 30 pixel right icon
    self.textField.frame = CGRectMake(50, 12,
                                      CGRectGetMaxX(self.contentView.bounds) - 110,
                                      CGRectGetMaxY(self.contentView.bounds) - 18);
    
    self.starButton.frame = CGRectMake( CGRectGetMaxX(self.contentView.bounds) - 95,
                                  0, 30, 44);
    [self.starButton.titleLabel setFont:[UIFont lightFlatFontOfSize:30]];
    [self.starButton setTitle:@"*" forState:UIControlStateNormal];
    [self.starButton setTitleColor:[BLDesignFactory iconTintColor] forState:UIControlStateNormal];
    [self.starButton addTarget:self action:@selector(starButtonPressedEvent) forControlEvents:UIControlEventTouchDown];
    
    [self.contentView addSubview:self.completedButton];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.starButton];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}

- (void)completedButtonPressedEvent
{
    self.listItem.completed = [NSNumber numberWithBool:!self.listItem.completed];
    
    if (self.listItem.completed)
        [self.completedButton setTitle:@"X" forState:UIControlStateNormal];
    else
        [self.completedButton setTitle:@"O" forState:UIControlStateNormal];
}

- (void)starButtonPressedEvent
{
    self.listItem.starred = [NSNumber numberWithBool:!self.listItem.starred];
    
    if (self.listItem.starred)
        [self.starButton setTitle:@"**" forState:UIControlStateNormal];
}

@end




@interface BLListTableViewController ()

@property (nonatomic, strong) BLList *list;
@property (nonatomic, strong) NSMutableArray *itemArray;

@end

@implementation BLListTableViewController

static NSString *cellID = @"List Item Cell";

- (id)initWithStyle:(UITableViewStyle)style
{
#warning allow for multiple selection
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"LSList";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // The title for this table in the Navigation Controller.
        self.title = self.list.name;
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        //self.objectsPerPage = 5;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [super viewDidLoad];
    [self.tableView registerClass:[PFTableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.separatorColor = [BLDesignFactory cellSeparatorColor];
    self.tableView.backgroundColor = [BLDesignFactory mainBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.tableView registerClass:[BLListItemCell class] forCellReuseIdentifier:cellID];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
/*
- (PFQuery *)queryForTable {
    PFQuery *incompleteItemQuery = [PFQuery queryWithClassName:self.parseClassName];
    [incompleteItemQuery whereKey:@"completed" equalTo:@YES];
    
    PFQuery *completeItemQuery = [PFQuery queryWithClassName:self.parseClassName];
    [completeItemQuery whereKey:@"completed" equalTo:@NO];
    
    
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:@"priority"];
    
    return query;
}
 */



// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"text"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Priority: %@", [object objectForKey:@"priority"]];
    
    return cell;
}


/*
 // Override if you need to change the ordering of objects in the table.
 - (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
 return [objects objectAtIndex:indexPath.row];
 }
 */

/*
 // Override to customize the look of the cell that allows the user to load the next page of objects.
 // The default implementation is a UITableViewCellStyleDefault cell with simple labels.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"NextPage";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.textLabel.text = @"Load more...";
 
 return cell;
 }
 */

#pragma mark - Table view data source

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}


@end
