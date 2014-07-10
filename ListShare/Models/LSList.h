//
//  LSItem.h
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface LSList : NSObject

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSNumber *completed; //generate using [NSNumber numberWithBool:YES/NO];
@property (nonatomic, strong) NSDate *dateCreated;
@property (nonatomic, strong) NSString *creatorUserName;
@property (nonatomic, strong) NSMutableArray *listParticipants;

- (PFObject *)saveAsPFObject;
- (PFObject *)returnAsPFObject;

/*
+ (NSString *)getListName:(PFObject *)object;
+ (NSNumber *)getCompleted:(PFObject *)object;
+ (NSDate *)getDateCreated:(PFObject *)object;
+ (NSString *)getCreatorUserName:(PFObject *)object;
+ (NSMutableArray *)getlistParticipants:(PFObject *)object;
*/

@end
