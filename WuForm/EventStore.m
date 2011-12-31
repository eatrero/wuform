//
//  EventStore.m
//  WuForm
//
//  Created by Ed Atrero on 12/31/11.
//  Copyright (c) 2011 Panocha Bros. All rights reserved.
//

#import "EventStore.h"
#import "Event.h"

static EventStore *defaultStore = nil;

@implementation EventStore

-(void) setManagedObjectContext:theManagedObjectContext
{ 
  managedObjectContext = theManagedObjectContext;
  
  if(!managedObjectContext)
  {
    NSLog(@"invalid managedObjectContext!");
    
    return;
  }

  NSError *error = nil;
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event"
                                            inManagedObjectContext:managedObjectContext];
  [request setEntity:entity];
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                      initWithKey:@"creationDate" ascending:YES];
  NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor,
                              nil];
  [request setSortDescriptors:sortDescriptors];
  
  allEvents = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];  
  if(error)
  {
    NSLog(@"error fetching from managedObjectContext! %@, %@", error, [error userInfo]);
  }
}

- (NSManagedObjectContext *) managedObjectContext
{
  return managedObjectContext;
}

+ (EventStore *)defaultStore
{
  if(!defaultStore)
  {
    // Create the singleton
    defaultStore = [[super allocWithZone:NULL] init];
  }
  return defaultStore;
}

// Prevent creation of additional instances
+ (id)allocWithZone:(NSZone *)zone
{
  return [self defaultStore];
}

- (id)init
{
  // If we already have an instance of PossesionStore...
  if (defaultStore) {
    // return the old one
    return defaultStore;
  }
  
  self = [super init];
  
  if (self) {
    allEvents = [[NSMutableArray alloc] init];
  }
  
  return self;
}

- (NSArray *)allEvents
{
  return allEvents;
}

@end
