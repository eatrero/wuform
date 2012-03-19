//
//  SettingsStore.m
//  WuForm
//
//  Created by Ed Atrero on 3/18/12.
//  Copyright (c) 2012 Panocha Bros. All rights reserved.
//

#import "SettingsStore.h"


@implementation SettingsStore
{
  NSArray *allSettings;  
}

static SettingsStore *defaultStore = nil;
static NSString *APIKEY_KEY = @"ApiKeyKey";
static NSString *HASH_KEY = @"HashKey";
static NSString *SUBDOMAIN_KEY = @"SubdomainKey";

@synthesize apiKey;
@synthesize apiHash;
@synthesize apiSubdomain;

+ (SettingsStore *)defaultStore
{
  NSLog(@"%s", __FUNCTION__);
  if(!defaultStore)
  {
    // Create the singleton
    defaultStore = [[super allocWithZone:NULL] init];
  }
  return defaultStore;
}

- (id)init
{
  NSLog(@"%s", __FUNCTION__);
  // If we already have an instance of PossesionStore...
  if (defaultStore) {
    // return the old one
    return defaultStore;
  }
  
  self = [super init];
  
  if (self) {
    allSettings = [[NSMutableArray alloc] init];
  }
  
  return self;
}

- (void)dealloc
{
  NSLog(@"%s", __FUNCTION__);
  allSettings = nil;
}

- (void)initSettings
{
  NSLog(@"%s", __FUNCTION__);
  self.apiKey = [[NSUserDefaults standardUserDefaults]
               objectForKey:APIKEY_KEY];
  self.apiHash = [[NSUserDefaults standardUserDefaults]
                  stringForKey:HASH_KEY];
  self.apiSubdomain = [[NSUserDefaults standardUserDefaults]
                  stringForKey:SUBDOMAIN_KEY];
 
}

- (void)storeSettings
{
  NSLog(@"%s", __FUNCTION__);
  [[NSUserDefaults standardUserDefaults] 
   setObject:self.apiKey forKey:APIKEY_KEY];  
  [[NSUserDefaults standardUserDefaults] 
   setObject:self.apiHash forKey:HASH_KEY];  
  [[NSUserDefaults standardUserDefaults] 
   setObject:self.apiSubdomain forKey:SUBDOMAIN_KEY];  
  [[NSUserDefaults standardUserDefaults] synchronize];

}
@end
