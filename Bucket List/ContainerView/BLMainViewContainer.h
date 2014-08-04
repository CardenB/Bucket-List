//
//  BLMainViewContainer.h
//  Bucket List
//
//  Created by Carden Bagwell on 8/3/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLNavigationDelegate.h"

@class BLMainViewContainer;
@interface BLMainViewContainer : UIViewController<BLNavigationDelegate, UIScrollViewDelegate>

- (void)navigateLeft;
- (void)navigateRight;

@end
