//
//  LSItem.h
//  ListShare
//
//  Created by Carden Bagwell on 7/15/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "BLList.h"
#import "BLUser.h"

@interface BLItem : PFObject< PFSubclassing >

+ (NSString *)parseClassName;

@property (nonatomic, strong) NSNumber *completed; //generate using [NSNumber numberWithBool:YES/NO];
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) BLUser *creator;
//@property (nonatomic, strong) NSDate *dateCreated; //use createdAt
@property (nonatomic, strong) NSNumber *starred; //@YES and @NO instead of YES and No or [NSNumber numberWithBool:YES/NO];
@property (nonatomic, strong) BLList *parentList;

/*
- (void)update;
- (void)save;
- (PFObject *)returnAsPFObject;
*/
@end


static NSString *kItemName = @"name";
static NSString *kItemCompleted = @"completed";
static NSString *kItemCreator = @"listItemCreator";
static NSString *kItemStarred = @"starred";
static NSString *kItemParentList = @"parentList";