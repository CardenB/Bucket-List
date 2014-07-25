//
//  LSItem.m
//  ListShare
//
//  Created by Carden Bagwell on 7/15/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLItem.h"

@interface BLItem()

@property (nonatomic, strong) PFObject *itemModel;

@end

@implementation BLItem

static NSString *kItemName = @"name";
static NSString *kCompleted = @"completed";
static NSString *kDateCreated = @"listItemDateCreated";
static NSString *kCreatorUserName = @"listItemCreatorName";
static NSString *kStarred = @"starred";

- (id)init
{
    self = [super init];
    self.name = @"";
    self.completed = @NO;
    self.dateCreated = nil;
    self.creatorUserName = @"";
    self.starred = @NO;
    self.itemModel = [PFObject objectWithClassName:@"BLItem"];
    return self;
    
}

- (void)update
{
    [self.itemModel setObject:self.name forKey:kItemName];
    [self.itemModel setObject:self.completed forKey:kCompleted];
    [self.itemModel setObject:self.dateCreated forKey:kDateCreated];
    [self.itemModel setObject:self.creatorUserName forKey:kCreatorUserName];
    [self.itemModel setObject:self.starred forKey:kStarred];
    
}

- (PFObject *)returnAsPFObject
{
    [self update];
    return self.itemModel;
}

- (void)save
{
    [self update];
    [self.itemModel save];
}

@end
