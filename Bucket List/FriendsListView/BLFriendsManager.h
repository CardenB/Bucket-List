//
//  BLFriendsManager.h
//  Bucket List
//
//  Created by Carden Bagwell on 8/6/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLAbstractFriendsDisplay.h"
#import "BLChildViewController.h"
#import "BLNavigationDelegate.h"

@interface BLFriendsManager : BLAbstractFriendsDisplay< BLChildViewController >

- (id)initWithNavigationDelegate:(id<BLNavigationDelegate>)delegate;

@end
