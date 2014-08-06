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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [BLUser currentUser].friends.count;
}


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

@end
