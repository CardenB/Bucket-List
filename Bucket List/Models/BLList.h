//
//  LSItem.h
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "BLUser.h"

@interface BLList : PFObject< PFSubclassing >

+ (NSString *)parseClassName;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) BLUser *creator;
@property (nonatomic, strong) NSMutableArray *participants;
//@property (nonatomic, strong) NSMutableArray *itemArray;

@end


static NSString *kListName = @"name";
static NSString *kListCreator = @"creator";
static NSString *kListParticipants = @"participants";
static NSString *kListItemArray = @"itemArray";
