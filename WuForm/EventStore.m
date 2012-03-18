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
  
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; 
  [nc addObserver:self                    // The object self will be sent 
         selector:@selector(updateEvent:) // retrieveDog: 
             name:@"UpdateEvent"          // when @"UpdateEvent" is posted 
           object:nil];                   // by any object.
                                               
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

// respond to update event notifications
- (void)updateEvent:(NSNotification *)note
{
  NSLog(@"%s", __FUNCTION__);
  if(!managedObjectContext)
  {
    NSLog(@"EventStore:updateEvent invalid managedObjectContext!");
    
    return;
  }
  
  NSDictionary *userInfo = [note userInfo];
  Event *event = [userInfo objectForKey:@"updatedEvent"];
  
  if(!event)
  {
    NSLog(@"invalid updatedEvent!");
    
    return;
  }

  NSError *error;
  Event *tmpEvent;
  for (tmpEvent in allEvents)
  {
    if([[tmpEvent uuid] isEqualToString:[event uuid]])
    {
      NSLog(@"updateEvent: Event located!");      
      [tmpEvent setFirstName:[event firstName]];
      [tmpEvent setLastName:[event lastName]];
      [tmpEvent setEmailAddress:[event emailAddress]];
      [tmpEvent setSynched:[event synched]];
      
      if (![managedObjectContext save:&error]) {
        // Handle the error.
        NSLog(@"updateEvent: Error saving context: %@", error);      
      }    
      NSDictionary *extraInfo = [NSDictionary dictionaryWithObject:event forKey:@"updatedDisplay"]; 
      
      NSNotification *note = [NSNotification notificationWithName:@"UpdateDisplay" 
                                                           object:self 
                                                         userInfo:extraInfo]; 
      [[NSNotificationCenter defaultCenter] postNotification:note];
      
      return;
    }
  }  
  NSLog(@"updateEvent: Event not found!");
  return;
}

- (void)updateEventSync:(Event *)event
{
  NSLog(@"%s", __FUNCTION__);
  if(!managedObjectContext)
  {
    NSLog(@"EventStore:updateEvent invalid managedObjectContext!");
    
    return;
  }
  
  if(!event)
  {
    NSLog(@"invalid updatedEvent!");
    
    return;
  }
  
  NSError *error;
  Event *tmpEvent;
  for (tmpEvent in allEvents)
  {
    if([[tmpEvent uuid] isEqualToString:[event uuid]])
    {
      NSLog(@"updateEvent: Event located!");      
      [tmpEvent setFirstName:[event firstName]];
      [tmpEvent setLastName:[event lastName]];
      [tmpEvent setEmailAddress:[event emailAddress]];
      [tmpEvent setSynched:[event synched]];
      
      if (![managedObjectContext save:&error]) {
        // Handle the error.
        NSLog(@"updateEvent: Error saving context: %@", error);      
      }    
      NSDictionary *extraInfo = [NSDictionary dictionaryWithObject:event forKey:@"updatedDisplay"]; 
      
      NSNotification *note = [NSNotification notificationWithName:@"UpdateDisplay" 
                                                           object:self 
                                                         userInfo:extraInfo]; 
      [[NSNotificationCenter defaultCenter] postNotification:note];
      
      return;
    }
  }  
  NSLog(@"updateEvent: Event not found!");
  return;
}

// respond to remove event notifications
- (void)removeEvent:(Event *)event
{
  NSLog(@"%s", __FUNCTION__);
  if(!managedObjectContext)
  {
    NSLog(@"EventStore:updateEvent invalid managedObjectContext!");
    
    return;
  }
    
  if(!event)
  {
    NSLog(@"invalid removeEvent!");
    
    return;
  }
  
  NSError *error;
  Event *tmpEvent;
  for (tmpEvent in allEvents)
  {
    if([[tmpEvent uuid] isEqualToString:[event uuid]])
    {
      NSLog(@"removeEvent: Event located!");
      
      [allEvents removeObject:tmpEvent];
      
      [managedObjectContext deleteObject:tmpEvent];
      
      if (![managedObjectContext save:&error]) {
        // Handle the error.
        NSLog(@"removeEvent: Error saving context: %@", error);      
      }    
      return;
    }
  }  
  NSLog(@"removeEvent: Event not found!");
  return;
  
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

- (void)dealloc
{
  allEvents = nil;
}

- (NSArray *)allEvents
{
  return allEvents;
}


@end
