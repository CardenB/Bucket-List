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

+ (void)configureNavBarDesign:(UINavigationController *)nav;

+ (UIColor *)mainBackgroundColor;

+ (UIColor *)loginBackgroundColor;

+ (UIColor *)loginTextColor;

+ (UIColor *)cellSeparatorColor;

+ (UIColor *)cellBackgroundColor;

+ (UIColor *)iconTintColor;

+ (UIColor *)textColor;

+ (FUITextField *)getLogo:(CGRect)frame;
@end
