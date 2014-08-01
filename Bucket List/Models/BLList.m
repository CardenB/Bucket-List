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
    [self.listModel setObject:self.name forKey:kListName];
    [self.listModel setObject:self.dateLastUpdated forKey:kListDateLastUpdated];
    [self.listModel setObject:self.dateCreated forKey:kListDateCreated];
    [self.listModel setObject:self.creatorUserName forKey:kListCreatorUserName];
    [self.listModel setObject:self.participants forKey:kListParticipants];
    [self.listModel setObject:self.itemArray forKey:kListItemArray];

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
