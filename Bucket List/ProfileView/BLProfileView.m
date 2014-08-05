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
@interface BLProfileView ()

@property BOOL statusBarHidden;
@property id<BLNavigationDelegate> navigator;
@end

@implementation BLProfileView

static NSString *profileCellPicID = @"Profile Cell Pic";
static NSString *profileCellID = @"Profile Cell";
- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    _statusBarHidden = NO;
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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:profileCellPicID];
    [self.tableView setBackgroundColor:[BLDesignFactory mainBackgroundColor]];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

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
    return 3;
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
        
        NSString *name = [BLUser currentUser].name;
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
                cell.textLabel.text = @"Email";
                cell.detailTextLabel.text = [BLUser currentUser].username;
                break;
            case 2:
                cell.textLabel.text = @"Name";
                cell.detailTextLabel.text = [BLUser currentUser].name;
                break;
                
            default:
                break;
    }

    
    return cell;
}


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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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
