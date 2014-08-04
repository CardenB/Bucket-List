//
//  BLProfileView.h
//  Bucket List
//
//  Created by Carden Bagwell on 8/3/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLChildViewController.h"
#import "BLNavigationDelegate.h"

@interface BLProfileView : UITableViewController<BLChildViewController>

- (id)initWithNavigationDelegate:(id<BLNavigationDelegate>)delegate;

@end
