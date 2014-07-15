//
//  LSItem.m
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLList.h"

@interface BLList()

@property (nonatomic, strong) PFObject *listModel;

@end

@implementation BLList

static NSString *kName = @"name";
static NSString *kDateLastUpdated = @"lastUpdated";
static NSString *kDateCreated = @"dateCreated";
static NSString *kCreatorUserName = @"creatorName";
static NSString *kParticipants = @"participantArray";
static NSString *kItemArray = @"itemArray";

- (id)init
{
    self = [super init];
    self.name = @"";
    self.dateLastUpdated = nil;
    self.dateCreated = nil;
    self.creatorUserName = @"";
    self.participants = [[NSMutableArray alloc] init];
    self.itemArray = [[NSMutableArray alloc] init];
    
    self.listModel = [PFObject objectWithClassName:@"BLList"];
    return self;
    
}

- (void)update
{
    [self.listModel setObject:self.name forKey:kName];
    [self.listModel setObject:self.dateLastUpdated forKey:kDateLastUpdated];
    [self.listModel setObject:self.dateCreated forKey:kDateCreated];
    [self.listModel setObject:self.creatorUserName forKey:kCreatorUserName];
    [self.listModel setObject:self.participants forKey:kParticipants];
    [self.listModel setObject:self.itemArray forKey:kItemArray];

}

- (PFObject *)returnAsPFObject
{
    [self update];
    return self.listModel;
}

- (void)save
{
    [self update];
    [self.listModel save];
}

@end
