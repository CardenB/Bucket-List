//
//  LSDesignFactory.m
//  ListShare
//
//  Created by Carden Bagwell on 7/9/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "LSDesignFactory.h"


@implementation LSDesignFactory

+ (void)configureNavBarDesign:(UINavigationController *)nav
{
    [nav.navigationBar configureFlatNavigationBarWithColor:[UIColor belizeHoleColor]];
    
}

+ (UIColor *)mainBackgroundColor
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
@end
