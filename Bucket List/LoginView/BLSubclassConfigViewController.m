//
//  LSSubclassConfigViewController.m
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLSubclassConfigViewController.h"
#import "BLSignUpViewController.h"
#import "BLLoginViewController.h"
#import "BLListManager.h"
#import "BLUser.h"
#import "BLMainViewContainer.h"
#import "BLProfileView.h"

@interface BLSubclassConfigViewController ()

@end

@implementation BLSubclassConfigViewController

-(id) initWithDelegate:(id<BLPresenterDelegate>)delegate
{
    self = [super initWithNibName:@"BLSubclassConfigViewController" bundle:[NSBundle mainBundle]];
    self.delegate = delegate;
    return self;
}


#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([PFUser currentUser]) {
        [self presentInitialAppView];
    } else {
        self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![BLUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[BLLoginViewController alloc] init];
        [logInViewController setFields:PFLogInFieldsDefault | PFLogInFieldsFacebook ];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[BLSignUpViewController alloc] init];
        [signUpViewController setFields: PFSignUpFieldsDismissButton
         | PFSignUpFieldsSignUpButton
         | PFSignUpFieldsDismissButton
         | PFSignUpFieldsUsernameAndPassword
         | PFSignUpFieldsAdditional];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    
}

- (void)presentInitialAppView
{
    BLMainViewContainer *viewContainer = [[BLMainViewContainer alloc] initWithPresenterDelegate:self.delegate];
    [self.delegate presentAsMainViewController:viewContainer];
}


#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(BLUser *)user
{
    //TODO: query for friend notifications on login
    [self dismissViewControllerAnimated:YES completion:^(){
            if ([BLUser currentUser]) {
                [self presentInitialAppView];
            }
        }];
}


// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
}


#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    //TODO: validate additional information field
    //key is fieldname
    //field is text inside field
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) { // check completion
            informationComplete = NO;
            break;
        }
        //TODO: validate email field
        //validate first/last name field
        else if ([key isEqualToString:@"additional"]) {
            NSString *firstAndLastNameRegex = @"[a-zA-Z]+ ++[a-zA-Z]+$";
            NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", firstAndLastNameRegex];
            if( ![nameTest evaluateWithObject:(NSString *)field] )
            {
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out first and last name properly.\n(Ex: \"John Doe\"", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
                return NO;
            }
            
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}


#pragma mark - ()

- (IBAction)logOutButtonTapAction:(id)sender {
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
