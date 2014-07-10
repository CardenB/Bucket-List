//
//  LSSubclassConfigViewController.h
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "LSPresenterDelegate.h"

@interface LSSubclassConfigViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, weak) id<LSPresenterDelegate> delegate;

@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;

-(id) initWithDelegate:(id<LSPresenterDelegate>)delegate;

- (IBAction)logOutButtonTapAction:(id)sender;

@end