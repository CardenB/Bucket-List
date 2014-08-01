//
//  LSItem.h
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface BLList : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *dateLastUpdated;
@property (nonatomic, strong) NSDate *dateCreated;
@property (nonatomic, strong) NSString *creatorUserName;
@property (nonatomic, strong) NSMutableArray *participants;
@property (nonatomic, strong) NSMutableArray *itemArray;

- (void)update;
- (void)save;
- (PFObject *)returnAsPFObject;

@end

static NSString *kListName = @"name";
static NSString *kListDateLastUpdated = @"lastUpdated";
static NSString *kListDateCreated = @"dateCreated";
static NSString *kListCreatorUserName = @"creatorName";
static NSString *kListParticipants = @"participantArray";
static NSString *kListItemArray = @"itemArray";