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

+ (UIColor *)textFieldTextColor
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

+ (UIColor *)textFieldBackgroundColor
{
    return [UIColor
     blendedColorWithForegroundColor:[self textFieldTextColor]
     backgroundColor:[self loginBackgroundColor]
            percentBlend:0.3];
    
}

+ (UIColor *)placeholderTextColor
{
    return [self.textFieldTextColor colorWithAlphaComponent:.6];
    
}

+ (UIColor *)buttonBackgroundColor
{
    return [UIColor
            blendedColorWithForegroundColor:[self textFieldTextColor]
            backgroundColor:[self loginBackgroundColor]
            percentBlend:0.15];
}

+ (UIColor *)textColor
{
    return [UIColor belizeHoleColor];
}

+ (void)customizeLoginButton:(UIButton *)button color:(UIColor *)color title:(NSString *)title
{
    [button setBackgroundImage:nil forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    [button setBackgroundImage:nil forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    button.layer.shadowOpacity = 0.15;
    button.layer.shadowRadius = 3;
    button.layer.shadowOffset = CGSizeMake(0, 0);
}

+ (FUITextField *)getLogo:(CGRect)frame
{
    FUITextField *logoTextField = [[FUITextField alloc] initWithFrame:frame];
    [logoTextField setText:@"Bucket List"];
    [logoTextField setFont:[UIFont lightFlatFontOfSize:40]];
    [logoTextField setTextAlignment:NSTextAlignmentCenter];
    [logoTextField setTextColor:[self textFieldTextColor]];
    [logoTextField setUserInteractionEnabled:NO];
    return logoTextField;
}

+ (void)customizeSearchBars
{
    [[UISearchBar appearance] setBackgroundColor:[BLDesignFactory loginBackgroundColor]];
    [[UISearchBar appearance] setSearchBarStyle:UISearchBarStyleMinimal];
    [[UISearchBar appearance]
     setBackgroundImage:[UIImage
                         imageWithColor:[BLDesignFactory loginBackgroundColor]
                         cornerRadius:0.0f]
     forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UISearchBar appearance] setTintAdjustmentMode:UIViewTintAdjustmentModeAutomatic];
   [[UISearchBar appearance] setTintColor:[self loginBackgroundColor]];
    
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil]
     setTitleTextAttributes:[self searchBarButtonAttributes] forState:UIControlStateNormal];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil]
     setTitleTextAttributes:[self searchBarButtonAttributes] forState:UIControlStateHighlighted];
    [[UILabel appearanceWhenContainedIn:[UISearchBar class], nil] setAttributedText:[[NSAttributedString alloc] initWithString:@"Search for friends" attributes:[self placeholderTextAttributes]]];
    
    UIImage *searchFieldImage = [[UIImage imageWithColor:[self mainBackgroundColor] cornerRadius:0.0f]
                                 imageWithMinimumSize:[UISearchBar appearance].frame.size];
    [[UISearchBar appearance] setSearchFieldBackgroundImage:searchFieldImage forState:UIControlStateNormal];
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[self mainBackgroundColor]];
    [[UISearchBar appearance] setBarTintColor:[self mainBackgroundColor]];
    

}

+ (void)customizeSearchBar:(UISearchBar *)searchBar
{
}

+ (NSDictionary *)placeholderTextAttributes
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
     [self placeholderTextColor], NSForegroundColorAttributeName,
            nil];
    
}

+ (NSDictionary *)searchBarButtonAttributes
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [BLDesignFactory mainBackgroundColor], NSForegroundColorAttributeName,
            nil];
}

+ (UIButton *)createAddUserButton
{
    FUIButton *button = [[FUIButton alloc] initWithFrame:CGRectMake(250, 10, 40, 20)];
    [button setTitleColor:[self loginBackgroundColor] forState:UIControlStateNormal];
    [button setTitleColor:[self mainBackgroundColor] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageWithColor:[self mainBackgroundColor] cornerRadius:button.cornerRadius] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[self loginBackgroundColor] cornerRadius:button.cornerRadius] forState:UIControlStateHighlighted];
    [button setTitle:@ "+" forState:UIControlStateNormal];
    [button setTitle:@"added" forState:UIControlStateHighlighted];
    
    return button;
}

+ (void)customizeUserCell:(UITableViewCell *)cell user:(BLUser *)user
{

    cell.textLabel.text = user.propercaseFullName;
    cell.detailTextLabel.text = user.username;
    
    CGRect frame = CGRectMake(0, 0, 40, 40);
    cell.imageView.layer.cornerRadius = frame.size.height/2;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.borderWidth = 0;
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [img setImageWithString:user.propercaseFullName];
    
    [cell.imageView setImage:img.image];
}

+ (void)customizeListItemCell:(UITableViewCell *)cell
{
    CGRect frame = CGRectMake(0, 0, 40, 40);
    UIView *imageView = [[UIView alloc] initWithFrame:cell.imageView.frame];
    imageView.layer.cornerRadius = frame.size.height/2;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = 0;
    NSLog(@"Imageview frame: %f, %f", cell.imageView.frame.size.width, cell.imageView.frame.size.height);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(12, 6, 31, 31)];
    CGFloat cornerRad = button.bounds.size.width/2.0;
    
    [button setBackgroundImage:[UIImage imageWithColor:[self mainBackgroundColor] cornerRadius:cornerRad] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[self loginBackgroundColor] cornerRadius:cornerRad] forState:UIControlStateSelected];
    
    button.userInteractionEnabled = YES;
    [button addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:button];
}

+ (void)selectedButton:(id)sender
{
    [sender setSelected:!((UIButton *)sender).selected];
    
}

@end
