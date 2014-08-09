//
//  BLUser.h
//  Bucket List
//
//  Created by Carden Bagwell on 8/5/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

@interface BLUser : PFUser< PFSubclassing >

@property NSString *propercaseFullName;
@property NSString *lowercaseFirstName;
@property NSString *lowercaseLastName;
@property NSString *lowercaseFullName;
@property NSArray *friends; //Array of BLUser pointers

+ (void)addFriend:(BLUser *)user;
+ (void)removeFriend:(BLUser *)user;

@end
