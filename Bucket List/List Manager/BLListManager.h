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

@interface BLListManager : PFQueryTableViewController <UITextFieldDelegate>

- (id)initWithStyle:(UITableViewStyle)style delegate:(id<BLNavigationDelegate>)delegate;

@end
