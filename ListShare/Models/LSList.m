//
//  LSItem.m
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "LSList.h"

@implementation LSList

- (id)init
{
    self = [super init];
    self.itemName = @"";
    self.completed = @NO;
    self.dateCreated = nil;
    self.creatorUserName = @"";
    self.listParticipants = [[NSMutableArray alloc] init];
    return self;
    
}

- (PFObject *)returnAsPFObject
{
    PFObject *item = [[PFObject alloc] initWithClassName:@"LSList"];
    
    [item setObject:self.itemName forKey:@"name"];
    [item setObject:self.completed forKey:@"completed"];
    [item setObject:self.dateCreated forKey:@"dateCreated"];
    [item setObject:self.creatorUserName forKey:@"creatorName"];
    [item setObject:self.listParticipants forKey:@"listParticipantArray"];
    
    return item;
}

- (PFObject *)saveAsPFObject
{
    PFObject *item = [[PFObject alloc] initWithClassName:@"LSList"];
    
    item[@"name"] = self.itemName;
    item[@"completed"] = self.completed;
    item[@"dateCreated"] = self.dateCreated;
    item[@"creatorName"] = self.creatorUserName;
    item[@"listParticipantArray"] = self.listParticipants;
    
    [item save];
    
    return item;
}
@end
