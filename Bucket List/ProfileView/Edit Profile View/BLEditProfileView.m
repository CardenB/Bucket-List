//
//  BLEditProfileView.m
//  Bucket List
//
//  Created by Carden Bagwell on 8/14/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLEditProfileView.h"
#import "BLDesignFactory.h"
#import "BLEditFieldTableViewCell.h"

@interface BLEditProfileView ()

@end

@implementation BLEditProfileView


static NSString *profileCellPicID = @"Profile Cell Pic";
static NSString *profileCellID = @"Profile Cell";

typedef enum {
    pictureCell = 0,
    nameCell = 1,
    emailCell = 2,
    listEditCell = 3,
    profileEditCell = 4,
    
} profileViewCellIndices;

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BLEditFieldTableViewCell" bundle:[NSBundle mainBundle] ] forCellReuseIdentifier:profileCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:profileCellPicID];
    
    [[UITableView appearanceWhenContainedIn:[BLEditProfileView class], nil] setBackgroundColor:[BLDesignFactory loginBackgroundColor]];
    [[UITableView appearanceWhenContainedIn:[BLEditProfileView class], nil] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    if (indexPath.row == pictureCell) {
        return CGRectGetHeight(self.tableView.frame)/3;
    } else {
        return 44.0f;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == pictureCell) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:profileCellPicID forIndexPath:indexPath];
        
        NSString *name = [BLUser currentUser].propercaseFullName;
        UIImageView *img = [[UIImageView alloc] initWithFrame:cell.frame];
        [img setImageWithString:name color:[BLDesignFactory loginBackgroundColor]];
        [cell addSubview:img];
        return cell;
    } else {
        BLEditFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:profileCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [BLDesignFactory mainBackgroundColor];
        switch (indexPath.row) {
            case nameCell:
                cell.fieldLabel.text = @"Name";
                cell.fieldTextField.text = [BLUser currentUser].propercaseFullName;
                break;
            case emailCell:
                cell.fieldLabel.text = @"Email";
                cell.fieldTextField.text = [BLUser currentUser].username;
                break;
            default:
                break;
        }
        return cell;
    }

    
    

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
