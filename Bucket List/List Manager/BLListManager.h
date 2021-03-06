//
//  LSListManager.h
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "BLNavigationDelegate.h"
#import "BLChildViewController.h"
#import "BLList.h"

@interface BLListManager : PFQueryTableViewController <UITextFieldDelegate, BLChildViewController>

- (id)initWithStyle:(UITableViewStyle)style delegate:(id<BLNavigationDelegate>)delegate;
- (PFTableViewCell *)tableView:(UITableView *)tableView
     createListCellAtIndexPath:(NSIndexPath *)indexPath
                        object:(BLList *)listObject;

- (PFObject *)filterObjectAtIndexPath:(BOOL)useSuper indexPath:(NSIndexPath *)indexPath;

@end
