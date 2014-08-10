//
//  BLParticipantManager.m
//  Bucket List
//
//  Created by Carden Bagwell on 8/10/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLParticipantManager.h"
#import "BLUser.h"
#import "BLAddParticipantView.h"

@interface BLParticipantManager ()

@property BLList *list;

@end

@implementation BLParticipantManager

static NSString *cellID = @"cell id";
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithList:(BLList *)list
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.list = list;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addParticipant)];
}

- (void)addParticipant
{
    //TODO: need a way to hit "done"
    UIViewController *addView = [[BLAddParticipantView alloc] initWithList:self.list];
    UINavigationController *modalNav = [[UINavigationController alloc] initWithRootViewController:addView];
    
    [self.navigationController presentViewController:modalNav animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.list fetchIfNeeded];
    [self.tableView reloadData];
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
    if (section == 0) {
        if (self.list.participants > 0) {
            return self.list.participants.count;
        } else {
            return 1;
        }
    } else {
        return 1;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    // Configure the cell...
    if (self.list.participants > 0) {
        BLUser *participant = (BLUser *)self.list.participants[indexPath.row];
        [participant fetchIfNeeded];
        cell.textLabel.text = participant.propercaseFullName;
    } else {
        cell.textLabel.text = @"Add members to share your list.";
    }

    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if ( [((BLUser *)self.list.participants[indexPath.row]).objectId isEqualToString:[BLUser currentUser].objectId] ) {
        return NO;
    }
    
    return YES;
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSMutableArray *friendsArray = [[NSMutableArray alloc] initWithCapacity:self.list.participants.count];
        [friendsArray addObjectsFromArray:self.list.participants];
        
        [friendsArray removeObjectAtIndex:indexPath.row];
        self.list.participants = friendsArray;
        [self.list save];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
