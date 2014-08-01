//
//  LSDesignFactory.m
//  ListShare
//
//  Created by Carden Bagwell on 7/9/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLDesignFactory.h"


@implementation BLDesignFactory

+ (void)configureNavBarDesign:(UINavigationController *)nav
{
    [nav.navigationBar configureFlatNavigationBarWithColor:[UIColor belizeHoleColor]];
    nav.navigationBar.tintColor = [self cellBackgroundColor];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [self cellBackgroundColor]}];
    nav.navigationBar.translucent = NO;
    
}

+ (UIColor *)mainBackgroundColor
{
    return [UIColor cloudsColor];
}

+ (UIColor *)loginBackgroundColor
{
    return [UIColor belizeHoleColor];
}

+ (UIColor *)loginTextColor
{
    return [UIColor cloudsColor];
}

+ (UIColor *)cellSeparatorColor
{
    return [UIColor belizeHoleColor];
}

+ (UIColor *)cellBackgroundColor
{
    return [UIColor cloudsColor];
}

+ (UIColor *)iconTintColor
{
    UIColor *iconColor = [UIColor belizeHoleColor];
    [iconColor colorWithAlphaComponent:.6];
    return iconColor;
}

+ (UIColor *)textColor
{
    return [UIColor belizeHoleColor];
}

+ (FUITextField *)getLogo:(CGRect)frame
{
    FUITextField *logoTextField = [[FUITextField alloc] initWithFrame:frame];
    [logoTextField setText:@"Bucket List"];
    [logoTextField setFont:[UIFont lightFlatFontOfSize:40]];
    [logoTextField setTextAlignment:NSTextAlignmentCenter];
    [logoTextField setTextColor:[BLDesignFactory loginTextColor]];
    [logoTextField setUserInteractionEnabled:NO];
    return logoTextField;
}
@end
