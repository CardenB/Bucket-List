//
//  LSSubclassConfigViewController.h
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "BLPresenterDelegate.h"

@interface BLSubclassConfigViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, weak) id<BLPresenterDelegate> delegate;

@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;

-(id) initWithDelegate:(id<BLPresenterDelegate>)delegate;

- (IBAction)logOutButtonTapAction:(id)sender;

@end