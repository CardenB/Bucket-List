//
//  LSLoginViewController.m
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLLoginViewController.h"
#import "BLListManager.h"
#import "FlatUIKit.h"
#import "BLDesignFactory.h"

@interface BLLoginViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) FUIButton *anotherLogInButton;

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation BLLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    [self.logInView setBackgroundColor:[BLDesignFactory loginBackgroundColor]];
    
    //create logo
    FUITextField *logoTextField = [BLDesignFactory getLogo:[self.logInView.logo frame]];
    [logoTextField sizeToFit];
    [self.logInView setLogo:logoTextField];
    
    [self.logInView.dismissButton setHidden:YES];
    
    [self customizeFields];
    [self customizeButtons];
    [self customizeLabels];

}

- (void)resetPassword
{
    UIAlertView * forgotPassword=[[UIAlertView alloc] initWithTitle:@"Forgot Password"      message:@"Please enter your email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    forgotPassword.alertViewStyle=UIAlertViewStylePlainTextInput;
    [forgotPassword textFieldAtIndex:0].delegate=self;
    [forgotPassword show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex ==1){
        NSLog(@"ok button clicked in forgot password alert view");
        NSString *femailId=[alertView textFieldAtIndex:0].text;
        if ([femailId isEqualToString:@""]) {
            UIAlertView *display;
            display=[[UIAlertView alloc] initWithTitle:@"Email" message:@"Please enter password for resetting password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [display show];
            
        }else{
            [PFUser requestPasswordResetForEmailInBackground:femailId block:^(BOOL succeeded, NSError *error) {
                UIAlertView *display;
                if(succeeded){
                    display=[[UIAlertView alloc] initWithTitle:@"Password email" message:@"Please check your email for resetting the password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    
                }else{
                    display=[[UIAlertView alloc] initWithTitle:@"Email" message:@"Email doesn't exists in our database" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
                }
                [display show];
            }];
            
        }
    }

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)customizeFields
{
    // Set field text color
    
    [self.logInView.usernameField setTextColor:[BLDesignFactory textFieldTextColor]];
    [self.logInView.usernameField setBackgroundColor:[BLDesignFactory textFieldBackgroundColor]];
    if ([self.logInView.usernameField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.logInView.usernameField.attributedPlaceholder = [[NSAttributedString alloc]
                                                              initWithString:@"Email"
                                                              attributes:@{
                                                                           NSForegroundColorAttributeName:
                                                                               [BLDesignFactory placeholderTextColor]
                                                                           }];
    }
    
    self.logInView.passwordForgottenButton.imageView.hidden = YES;
    
    [self.logInView.passwordField setTextColor:[BLDesignFactory textFieldTextColor]];
    [self.logInView.passwordField setBackgroundColor:[BLDesignFactory textFieldBackgroundColor]];
    if ([self.logInView.passwordField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.logInView.passwordField.attributedPlaceholder = [[NSAttributedString alloc]
                                                              initWithString:@"Password"
                                                              attributes:@{
                                                                           NSForegroundColorAttributeName:
                                                                               [BLDesignFactory placeholderTextColor]
                                                                           }];
    }
    
}

- (void)customizeButtons
{
    /*
     // Set buttons appearance
     
     [self.logInView.facebookButton setImage:nil forState:UIControlStateNormal];
     [self.logInView.facebookButton setImage:nil forState:UIControlStateHighlighted];
     [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"FacebookDown.png"] forState:UIControlStateHighlighted];
     [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"Facebook.png"] forState:UIControlStateNormal];
     [self.logInView.facebookButton setTitle:@"" forState:UIControlStateNormal];
     [self.logInView.facebookButton setTitle:@"" forState:UIControlStateHighlighted];
     
     [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"Signup.png"] forState:UIControlStateNormal];
     [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"SignupDown.png"] forState:UIControlStateHighlighted];
     [self.logInView.signUpButton setTitle:@"" forState:UIControlStateNormal];
     [self.logInView.signUpButton setTitle:@"" forState:UIControlStateHighlighted];
     */
    
    FUIButton *logInButton = [[FUIButton alloc] initWithFrame:self.logInView.logInButton.bounds];
    //[logInButton addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
    self.anotherLogInButton = logInButton;
    
    [self.logInView.facebookButton addTarget:self
                                      action:@selector(loginButtonTouchHandler:)
                            forControlEvents:UIControlEventTouchUpInside];
    
    FUIButton *forgotButton = [[FUIButton alloc] initWithFrame:CGRectMake(
                                                                          CGRectGetWidth(self.logInView.bounds)/2 - 50,
                                                                          CGRectGetMaxY(self.logInView.bounds) - 10,
                                                                          100, 25)];
    
    [forgotButton setTitleColor:[BLDesignFactory mainBackgroundColor] forState:UIControlStateNormal];
    [forgotButton setTitle:@"Forgot Password?" forState:UIControlStateNormal];
    [forgotButton.titleLabel setFont:[UIFont lightFlatFontOfSize:12]];
    [forgotButton.titleLabel setEnabled:YES];
    [forgotButton addTarget:self action:@selector(resetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.logInView addSubview:forgotButton];
    [self.logInView.passwordForgottenButton setHidden:YES];
    [self.logInView.passwordForgottenButton setEnabled:NO];
    
    [BLDesignFactory customizeLoginButton:self.logInView.signUpButton color:[BLDesignFactory buttonBackgroundColor] title:@"Sign Up"];
    
    [BLDesignFactory customizeLoginButton:self.logInView.logInButton color:[BLDesignFactory buttonBackgroundColor] title:@"Log In"];
}

- (void)customizeLabels
{
    [self.logInView.signUpLabel setTextColor:[BLDesignFactory mainBackgroundColor]];
    [self.logInView.externalLogInLabel setTextColor:[BLDesignFactory mainBackgroundColor]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/* Login to facebook method */
- (IBAction)loginButtonTouchHandler:(id)sender  {
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"public_profile", @"email", @"user_friends"];
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [self.delegate logInViewController:self didLogInUser:[PFUser currentUser]];

        } else {
            NSLog(@"User with facebook logged in!");
            [self.delegate logInViewController:self didLogInUser:[PFUser currentUser]];
        }
    }];
    [_activityIndicator startAnimating]; // Show loading indicator until login is finished

}

@end
