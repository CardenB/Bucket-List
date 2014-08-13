//
//  LSListTableViewController.m
//  ListShare
//
//  Created by Carden Bagwell on 7/9/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLAddItemTableViewCell.h"
#import "BLListTableViewController.h"
#import "BLList.h"
#import "BLItem.h"
#import "BLUser.h"
#import "BLDesignFactory.h"
#import "BLParticipantManager.h"

@interface BLListItemCell : UITableViewCell

@property (nonatomic, strong) IBOutlet FUITextField *textField;
@property (nonatomic, strong) IBOutlet FUIButton *completedButton;
@property (nonatomic, strong) IBOutlet FUIButton *starButton;
@property (nonatomic, strong) BLItem *listItem;

@property (nonatomic, weak) id<UITextFieldDelegate> textFieldDelegate;

@property (nonatomic, strong) PFObject *list;

@end

@implementation BLListItemCell

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
    [super layoutSubviews];
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
static NSString *addListCellID = @"Add List Item Cell";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"BLItem";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = kItemName;
        
        // The title for this table in the Navigation Controller.
        self.title = self.list.name;
        self.navigationController.topViewController.title = self.list.name;
        NSLog(self.list.name);
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        //self.objectsPerPage = 5;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style object:(BLList *)list;
{
    self = [self initWithStyle:style];
    
    self.list = list;
    
    return self;
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.tableView registerClass:[BLAddItemTableViewCell class] forCellReuseIdentifier:addListCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [BLDesignFactory cellSeparatorColor];
    self.tableView.backgroundColor = [BLDesignFactory mainBackgroundColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Details" style:UIBarButtonItemStyleBordered target:self action:@selector(presentListDetails)];
    

}

- (void)presentListDetails
{
    UIViewController *participantManager = [[BLParticipantManager alloc] initWithList:self.list];
    [self.navigationController pushViewController:participantManager animated:YES];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
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

- (PFQuery *)queryForTable {
    PFQuery *query = [BLItem query];
    [query whereKey:kItemParentList equalTo:self.list];
    
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
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
        UITableViewCell *cell = [tableView
                                 dequeueReusableCellWithIdentifier:cellID
                                 forIndexPath:indexPath];
        cell.backgroundColor = [BLDesignFactory cellBackgroundColor];
        cell.backgroundColor = [BLDesignFactory cellBackgroundColor];
        
        //[cell.textLabel setFont:[UIFont flatFontOfSize:28]];
        //[cell.textLabel setTextColor:[BLDesignFactory textColor]];
        //cell.textLabel.text = [self objectAtIndexPath:indexPath][self.textKey];
        //cell.textLabel.text = [object objectForKey:self.textKey];
        [BLDesignFactory customizeListItemCell:cell];
        return cell;
    }
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

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        PFObject *object = [self objectAtIndexPath:indexPath];
#warning display activity indicator and create a background task
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            [self loadObjects];
        }];
    }
}

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

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

#warning display activity indicator and create a background task
    NSString *text = [textField.text
                      stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([text length] > 0) {
        BLItem *item = [BLItem object];
        item.name = text;
        item.completed = @NO;
        item.creator = [BLUser currentUser];
        item.starred = @NO;
        item.parentList = self.list;
        
        //PFObject *pfItem = [item returnAsPFObject];
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
