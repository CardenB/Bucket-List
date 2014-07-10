//
//  LSListManager.m
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "LSListManager.h"
#import "LSList.h"
#import "LSDesignFactory.h"

@interface LSAddListCell : UITableViewCell

@property (nonatomic, strong) IBOutlet FUITextField *textField;

@property (nonatomic, weak) id<UITextFieldDelegate> textFieldDelegate;

@end

@implementation LSAddListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    FUITextField *textField = [[FUITextField alloc]
                               initWithFrame:CGRectMake(50, 12,
                                                        CGRectGetMaxX(self.contentView.bounds) - 80,
                                                        CGRectGetMaxY(self.contentView.bounds) - 18)];
    self.textField = textField;
    return self;
}

- (void)layoutSubviews
{
    FUIButton *addButton = [[FUIButton alloc] init];
    addButton.frame = CGRectMake(15, 0, 30, 44);
    [addButton.titleLabel setFont:[UIFont lightFlatFontOfSize:30]];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setTitleColor:[LSDesignFactory iconTintColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(buttonPressedEvent) forControlEvents:UIControlEventTouchDown];
    

    self.textField.placeholder = @"Add a new list!";
    [self.textField setTextColor:[LSDesignFactory textColor]];
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.frame = CGRectMake(50, 12,
                                     CGRectGetMaxX(self.contentView.bounds) - 80,
                                      CGRectGetMaxY(self.contentView.bounds) - 18);
    
    [self.contentView addSubview:addButton];
    [self.contentView addSubview:self.textField];
    //self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}

- (void)buttonPressedEvent
{
    [self setSelected:YES];
    [self.textField becomeFirstResponder];
}

@end

@interface LSListManager ()

@property (nonatomic, strong) NSMutableArray *listsToBeSaved;
@end

@implementation LSListManager

static NSString *cellID = @"List Manager Cell";
static NSString *addListCellID = @"Add List Cell";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        // The className to query on
        self.parseClassName = @"LSList";
        
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
        
        self.listsToBeSaved = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[PFTableViewCell class] forCellReuseIdentifier:cellID];
    [self.tableView registerClass:[LSAddListCell class] forCellReuseIdentifier:addListCellID];
    self.tableView.separatorColor = [LSDesignFactory cellSeparatorColor];
    self.tableView.backgroundColor = [LSDesignFactory mainBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.lists = [[NSMutableArray alloc] init];
    self.contacts = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        LSAddListCell *cell = [tableView
                               dequeueReusableCellWithIdentifier:addListCellID
                               forIndexPath:indexPath];
        
        cell.backgroundColor = [LSDesignFactory cellBackgroundColor];
        cell.textField.delegate = self;
        
        return cell;
        
    }
    else
    {
        PFTableViewCell *cell = [tableView
                                 dequeueReusableCellWithIdentifier:cellID
                                 forIndexPath:indexPath];
        cell.backgroundColor = [LSDesignFactory cellBackgroundColor];
        cell.backgroundColor = [LSDesignFactory cellBackgroundColor];
        
        [cell.textLabel setFont:[UIFont flatFontOfSize:28]];
        [cell.textLabel setTextColor:[LSDesignFactory textColor]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [object objectForKey:self.textKey];
        return cell;
    }
}




#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [((LSAddListCell *)[tableView cellForRowAtIndexPath:indexPath]).textField becomeFirstResponder];
    } else {
        for (NSIndexPath *indexPath in tableView.indexPathsForSelectedRows) {
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [((LSAddListCell *)[tableView cellForRowAtIndexPath:indexPath]).textField resignFirstResponder];
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
        return YES;
    } else
        return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     if (indexPath.row == 0) {
     return UITableViewCellEditingStyleInsert;
     } else
     return UITableViewCellEditingStyleNone;
     */
    return UITableViewCellEditingStyleNone;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    /*
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        if (indexPath.row == 0) {
            if ([self.addListTextField.text length] > 0) {
                [self addListTextField];
            }
        }
    }
     */
}



#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text length] > 0) {
        LSList *listItem = [[LSList alloc] init];
        listItem.itemName = textField.text;
        listItem.completed = @NO;
        listItem.dateCreated = [NSDate date];
        listItem.creatorUserName = [PFUser currentUser].username;
        
        PFObject *item = listItem.returnAsPFObject;
        [item saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            [self loadObjects];
            textField.text = @"";
            [textField resignFirstResponder];
        }];
        
        //[self.listsToBeSaved addObject:[listItem saveAsPFObject]];
        
        //NSLog( [NSString stringWithFormat:@"%ld, %ld", (unsigned long)[self.listsToBeSaved count], (unsigned long)[self.objects count]]);
        
        //unsigned int indexPathRow = self.listsToBeSaved.count + self.objects.count;
        

        return YES;
    }
    return NO;
}
@end
