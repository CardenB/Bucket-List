//
//  LSItem.h
//  ListShare
//
//  Created by Carden Bagwell on 7/15/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface BLItem : NSObject

@property (nonatomic, strong) NSNumber *completed; //generate using [NSNumber numberWithBool:YES/NO];
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *creatorUserName;
@property (nonatomic, strong) NSDate *dateCreated;
@property (nonatomic, strong) NSNumber *starred; //@YES and @NO instead of YES and No or [NSNumber numberWithBool:YES/NO];

- (void)update;
- (void)save;
- (PFObject *)returnAsPFObject;

@end
