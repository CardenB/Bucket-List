//
//  LSItem.m
//  ListShare
//
//  Created by Carden Bagwell on 7/15/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLItem.h"
#import "Parse/PFObject+Subclass.h"

@interface BLItem()

//@property (nonatomic, strong) PFObject *itemModel;

@end

@implementation BLItem

@dynamic completed;
@dynamic name;
@dynamic creator;
@dynamic starred;
@dynamic parentList;

+ (NSString *)parseClassName {
    return @"BLItem";
}

/*
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
    [self.itemModel setObject:self.completed forKey:kItemCompleted];
    [self.itemModel setObject:self.dateCreated forKey:kItemDateCreated];
    [self.itemModel setObject:self.creatorUserName forKey:kItemCreatorUserName];
    [self.itemModel setObject:self.starred forKey:kItemStarred];
    [self.itemModel setObject:self.parentList forKey:kItemParentList];
    
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
*/
@end
