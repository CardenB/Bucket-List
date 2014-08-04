//
//  LSDesignFactory.h
//  ListShare
//
//  Created by Carden Bagwell on 7/9/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlatUIKit.h"

@interface BLDesignFactory : NSObject

//tableView
+ (UIColor *)mainBackgroundColor;

+ (UIColor *)cellSeparatorColor;

+ (UIColor *)cellBackgroundColor;

//login and signup
+ (UIColor *)loginBackgroundColor;

+ (UIColor *)textFieldTextColor;

+ (UIColor *)textFieldBackgroundColor;

+ (UIColor *)placeholderTextColor;

+ (UIColor *)buttonBackgroundColor;

+ (FUITextField *)getLogo:(CGRect)frame;

+ (void)customizeLoginButton:(UIButton *)button color:(UIColor *)color title:(NSString *)title;

//other

+ (void)configureNavBarDesign:(UINavigationController *)nav;

+ (UIColor *)iconTintColor;

+ (UIColor *)textColor;
@end
