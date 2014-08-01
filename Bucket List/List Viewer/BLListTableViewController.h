//
//  LSListTableViewController.h
//  ListShare
//
//  Created by Carden Bagwell on 7/9/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface BLListTableViewController : PFQueryTableViewController<UITextFieldDelegate>

- (id)initWithStyle:(UITableViewStyle)style object:(PFObject *)list;
@end
