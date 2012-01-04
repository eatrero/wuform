//
//  EventStore.h
//  WuForm
//
//  Created by Ed Atrero on 12/31/11.
//  Copyright (c) 2011 Panocha Bros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface EventStore : NSObject
{
  NSManagedObjectContext *managedObjectContext;
  NSMutableArray *allEvents;
}

// Properties
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


// EventStore is a Singleton
+ (EventStore *) defaultStore;

- (NSArray *)allEvents;
- (void)updateEvent:(NSNotification *)note;
- (void)removeEvent:(Event *)event;
@end
