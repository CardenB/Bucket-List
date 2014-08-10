//
//  BLAddParticipantView.m
//  Bucket List
//
//  Created by Carden Bagwell on 8/10/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLAddParticipantView.h"

@interface BLAddParticipantView ()

@property BLList *list;

@end

@implementation BLAddParticipantView

//methods to override
//cell for row
//filter for search text
//number of rows in section
//add friend
//remove friend

static NSString *cellID = @"User Cell";

- (id)initWithList:(BLList *)list
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.list = list;
        NSMutableArray *possibleParticipants = [NSMutableArray arrayWithArray:[BLUser currentUser].friends];
        [possibleParticipants removeObjectsInArray:list.participants];
        self.displayCollection = possibleParticipants;
        self.displayObjectIdArray = [self.displayCollection valueForKeyPath:@"objectId"];
        
        self.friendCollection = list.participants;
        self.friendObjectIdArray = [list.participants valueForKeyPath:@"objectId"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissSelf)];
}

- (void)dismissSelf
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Search Bar

- (void)filterForSearchText:(NSString *)text
                      scope:(NSString *)scope
{
    
    /*
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
     */
    
}

#pragma mark - Friend management data source


- (void)addFriend:(BLUser *)user cell:(UITableViewCell *)cell
{
    if (!self.list.participants) {
        self.list.participants = @[user];
    } else {
        self.list.participants = [self.list.participants arrayByAddingObject:user];
    }
    [self.list save];
    
}
- (void)removeFriend:(BLUser *)user cell:(UITableViewCell *)cell
{
    
    NSMutableArray *friendsArray = [[NSMutableArray alloc] initWithCapacity:self.list.participants.count];
    [friendsArray addObjectsFromArray:self.list.participants];
    
    for (BLUser *friend in friendsArray)
    {
        if ([friend.objectId isEqualToString:user.objectId]) {
            [friendsArray removeObject:friend];
            self.list.participants = friendsArray;
            break;
        }
    }
    [self.list save];
    
    
}
@end
