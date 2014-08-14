//
//  BLEditListManager.m
//  Bucket List
//
//  Created by Carden Bagwell on 8/14/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLEditListManager.h"

@interface BLEditListManager ()

@end

@implementation BLEditListManager

static NSString *cellID = @"List Manager Cell";

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (PFObject *)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [super filterObjectAtIndexPath:YES indexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(BLList *)listObject {
    
    return [super tableView:tableView createListCellAtIndexPath:indexPath object:listObject ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    [self setEditing:YES];
}

- (void)updateNavigationBar
{
    return;
}

@end