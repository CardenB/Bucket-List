//
//  LSSignUpViewController.m
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLSignUpViewController.h"
#import "FlatUIKit.h"
#import "BLDesignFactory.h"

@interface BLSignUpViewController ()

@end

@implementation BLSignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    [self.signUpView setBackgroundColor:[BLDesignFactory loginBackgroundColor]];
    //create logo
    FUITextField *logoTextField = [BLDesignFactory getLogo:[self.signUpView.logo frame]];
    [logoTextField sizeToFit];
    
    [self.signUpView setLogo:logoTextField];
    [self setEmailAsUsername:YES];
   
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
     
    [self customizeFields];
    [self customizeButtons];
}

- (void)customizeFields
{
    UITextField *textField = self.signUpView.usernameField;
    
    self.signUpView.emailAsUsername = NO;
    
    [self.signUpView.usernameField setTextColor:[BLDesignFactory textFieldTextColor]];
    [self.signUpView.usernameField setBackgroundColor:[BLDesignFactory textFieldBackgroundColor]];
    if ([self.signUpView.usernameField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: [BLDesignFactory placeholderTextColor]}];
    }
    
    [self.signUpView.passwordField setTextColor:[BLDesignFactory textFieldTextColor]];
    [self.signUpView.passwordField setBackgroundColor:[BLDesignFactory textFieldBackgroundColor]];
    textField = self.signUpView.passwordField;
    if ([self.signUpView.passwordField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [BLDesignFactory placeholderTextColor]}];
    }
    
    
    [self.signUpView.emailField setTextColor:[BLDesignFactory textFieldTextColor]];
    [self.signUpView.emailField setBackgroundColor:[BLDesignFactory textFieldBackgroundColor]];
    if ([self.signUpView.emailField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.signUpView.emailField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: [BLDesignFactory placeholderTextColor]}];
    }
    
    [self.signUpView.emailField setEnabled:YES];
    [self.signUpView.emailField setHidden:NO];
    
    [self.signUpView.additionalField setTextColor:[BLDesignFactory textFieldTextColor]];
    [self.signUpView.additionalField setBackgroundColor:[BLDesignFactory textFieldBackgroundColor]];
    
    if ([self.signUpView.additionalField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.signUpView.additionalField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First and Last Name" attributes:@{NSForegroundColorAttributeName: [BLDesignFactory placeholderTextColor]}];
    }
    
}

- (void)customizeButtons
{
    [BLDesignFactory customizeLoginButton:self.signUpView.signUpButton color:[BLDesignFactory buttonBackgroundColor ] title:@"Sign Up"];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
