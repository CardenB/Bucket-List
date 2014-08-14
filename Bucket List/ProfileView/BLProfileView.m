//
//  BLProfileView.m
//  Bucket List
//
//  Created by Carden Bagwell on 8/3/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLProfileView.h"
#import "UIImageView+Letters.h"
#import "BLNavigationDelegate.h"
#import "BLDesignFactory.h"
#import "BLUser.h"
#import "Parse/Parse.h"
#import "BLEditListManager.h"
#import "BLEditProfileView.h"

@interface BLProfileView ()

@property id<BLNavigationDelegate> navigator;

@end

@implementation BLProfileView

static NSString *profileCellPicID = @"Profile Cell Pic";
static NSString *profileCellID = @"Profile Cell";

typedef enum {
    pictureCell = 0,
    listEditCell = 3,
    profileEditCell = 4,
    
} profileViewCellIndices;

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    return self;
}

- (id)initWithNavigationDelegate:(id<BLNavigationDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.navigator = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:profileCellPicID];
    
    [[UITableView appearanceWhenContainedIn:[BLProfileView class], nil] setBackgroundColor:[BLDesignFactory loginBackgroundColor]];
    [[UITableView appearanceWhenContainedIn:[BLProfileView class], nil] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)signOut
{
    [BLUser logOut];
    [self.navigator presentLogInViewFromPresentingViewController];
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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // first cell is height of half page?
    if (indexPath.row == 0) {
        return CGRectGetHeight(self.tableView.frame)/3;
    } else {
        return 44.0f;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:profileCellPicID forIndexPath:indexPath];
        
        NSString *name = [BLUser currentUser].propercaseFullName;
        UIImageView *img = [[UIImageView alloc] initWithFrame:cell.frame];
        [img setImageWithString:name color:[BLDesignFactory loginBackgroundColor]];
        [cell addSubview:img];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:profileCellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:profileCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [BLDesignFactory mainBackgroundColor];

            }
        }
        switch (indexPath.row) {
            case 1:
                cell.textLabel.text = @"Name";
                cell.detailTextLabel.text = [BLUser currentUser].propercaseFullName;
                break;
            case 2:
                cell.textLabel.text = @"Email";
                cell.detailTextLabel.text = [BLUser currentUser].username;
                break;
            case listEditCell:
                cell.textLabel.text = @"Manage Lists";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case profileEditCell:
                cell.textLabel.text = @"Edit Profile";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            default:
                break;
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == listEditCell) {
        BLEditListManager *editListManager = [[BLEditListManager alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:editListManager animated:YES];
    } else if (indexPath.row == profileEditCell) {
        BLEditProfileView *profileManager = [[BLEditProfileView alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:profileManager animated:YES];
    }
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}

#pragma mark - childViewController Delegate

- (void)updateNavigationBar
{
    [self.parentViewController.navigationItem
     setLeftBarButtonItem:[[UIBarButtonItem alloc]
                           initWithTitle:@"Sign Out"
                           style:UIBarButtonItemStyleBordered
                           target:self
                           action:@selector(signOut)]
     animated:YES];
    [self.parentViewController.navigationItem
     setRightBarButtonItem:[[UIBarButtonItem alloc]
                            initWithTitle:@"Lists >"
                            style:UIBarButtonItemStyleBordered
                            
                            target:self.navigator
                            action:@selector(navigateRight)]
     animated:YES];
}

@end
