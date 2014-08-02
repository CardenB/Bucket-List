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
    
    /*
    // Set buttons appearance
    
    [self.logInView.facebookButton setImage:nil forState:UIControlStateNormal];
    [self.logInView.facebookButton setImage:nil forState:UIControlStateHighlighted];
    [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"FacebookDown.png"] forState:UIControlStateHighlighted];
    [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"Facebook.png"] forState:UIControlStateNormal];
    [self.logInView.facebookButton setTitle:@"" forState:UIControlStateNormal];
    [self.logInView.facebookButton setTitle:@"" forState:UIControlStateHighlighted];
    
    [self.logInView.twitterButton setImage:nil forState:UIControlStateNormal];
    [self.logInView.twitterButton setImage:nil forState:UIControlStateHighlighted];
    [self.logInView.twitterButton setBackgroundImage:[UIImage imageNamed:@"Twitter.png"] forState:UIControlStateNormal];
    [self.logInView.twitterButton setBackgroundImage:[UIImage imageNamed:@"TwitterDown.png"] forState:UIControlStateHighlighted];
    [self.logInView.twitterButton setTitle:@"" forState:UIControlStateNormal];
    [self.logInView.twitterButton setTitle:@"" forState:UIControlStateHighlighted];
    
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"Signup.png"] forState:UIControlStateNormal];
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"SignupDown.png"] forState:UIControlStateHighlighted];
    [self.logInView.signUpButton setTitle:@"" forState:UIControlStateNormal];
    [self.logInView.signUpButton setTitle:@"" forState:UIControlStateHighlighted];
    */
    
    // Remove text shadow
    self.logInView.usernameField.layer.shadowOpacity = 0.0f;
    self.logInView.passwordField.layer.shadowOpacity = 0.0f;

    
    // Set field text color
    
    [self.logInView.usernameField setTextColor:[BLDesignFactory loginTextColor]];
    self.logInView.usernameField.placeholder = @"Email";
    [self.logInView.usernameField setBackgroundColor:[UIColor
                                                      blendedColorWithForegroundColor:[BLDesignFactory loginTextColor]
                                                      backgroundColor:[BLDesignFactory loginBackgroundColor]
                                                      percentBlend:0.3]];
    if ([self.logInView.usernameField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [BLDesignFactory loginTextColor];
        self.logInView.usernameField.attributedPlaceholder = [[NSAttributedString alloc]
                                                              initWithString:@"Email"
                                                              attributes:@{
                                                                           NSForegroundColorAttributeName:
                                                                               [color colorWithAlphaComponent:.6]
                                                                           }];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
    self.logInView.passwordForgottenButton.imageView.hidden = YES;
    
    [self.logInView.passwordField setTextColor:[BLDesignFactory loginTextColor]];
    self.logInView.passwordField.placeholder = @"Password";
    [self.logInView.passwordField setBackgroundColor:[UIColor
                                                      blendedColorWithForegroundColor:[BLDesignFactory loginTextColor]
                                                      backgroundColor:[BLDesignFactory loginBackgroundColor]
                                                      percentBlend:0.3]];
    if ([self.logInView.passwordField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [BLDesignFactory loginTextColor];
        self.logInView.passwordField.attributedPlaceholder = [[NSAttributedString alloc]
                                                              initWithString:@"Password"
                                                              attributes:@{
                                                                           NSForegroundColorAttributeName:
                                                                               [color colorWithAlphaComponent:.6]
                                                                           }];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    


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
    [self.logInView addSubview:self.anotherLogInButton];
    
    [forgotButton setTitleColor:[BLDesignFactory mainBackgroundColor] forState:UIControlStateNormal];
    [forgotButton setTitle:@"Forgot Password?" forState:UIControlStateNormal];
    [forgotButton.titleLabel setFont:[UIFont lightFlatFontOfSize:12]];
    [forgotButton.titleLabel setEnabled:YES];
    [forgotButton addTarget:self action:@selector(resetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.logInView addSubview:forgotButton];
    

    
    [self.logInView.signUpLabel setTextColor:[BLDesignFactory mainBackgroundColor]];
    [self.logInView.externalLogInLabel setTextColor:[BLDesignFactory mainBackgroundColor]];
    
    [self.logInView.passwordForgottenButton setHidden:YES];
    [self.logInView.passwordForgottenButton setEnabled:NO];

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
    
    /*
    [self.logInView.logInButton setEnabled:NO];
    [self.logInView.logInButton setHidden:YES];
    [self.anotherLogInButton setFrame:self.logInView.logInButton.bounds];
    [self.anotherLogInButton setButtonColor:[BLDesignFactory mainBackgroundColor]];
    self.anotherLogInButton.cornerRadius = 3.0f;
    [self.anotherLogInButton setTitleColor:[BLDesignFactory textColor] forState:UIControlStateNormal];
     */
    
    /*
    // Set frame for elements
    [self.logInView.dismissButton setFrame:CGRectMake(10.0f, 10.0f, 87.5f, 45.5f)];
    [self.logInView.logo setFrame:CGRectMake(66.5f, 70.0f, 187.0f, 58.5f)];
    [self.logInView.facebookButton setFrame:CGRectMake(35.0f, 287.0f, 120.0f, 40.0f)];
    [self.logInView.twitterButton setFrame:CGRectMake(35.0f+130.0f, 287.0f, 120.0f, 40.0f)];
    [self.logInView.signUpButton setFrame:CGRectMake(35.0f, 385.0f, 250.0f, 40.0f)];
    [self.logInView.usernameField setFrame:CGRectMake(35.0f, 145.0f, 250.0f, 50.0f)];
    [self.logInView.passwordField setFrame:CGRectMake(35.0f, 195.0f, 250.0f, 50.0f)];
    [self.fieldsBackground setFrame:CGRectMake(35.0f, 145.0f, 250.0f, 100.0f)];
     */
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
