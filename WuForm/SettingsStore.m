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

- (UIImage *) bgImage
{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                       NSUserDomainMask, 
                                                       YES);
  NSString *documentPaths = [paths objectAtIndex:0];
  NSString *bgImagePath = [documentPaths stringByAppendingPathComponent:@"bgImage.png"];

  NSData *imgData = [[NSData alloc] initWithContentsOfFile:bgImagePath];
  
  UIImage *bgImg = [[UIImage alloc] initWithData:imgData];
  
  return bgImg;
}

- (void) setBgImage:(UIImage *)img
{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                       NSUserDomainMask, 
                                                       YES);
  NSString *documentPaths = [paths objectAtIndex:0];
  NSString *bgImagePath = [documentPaths stringByAppendingPathComponent:@"bgImage.png"];
  
  // Create file manager
  NSError *error;
  NSFileManager *fileMgr = [NSFileManager defaultManager];
  
  // Point to Document directory
  NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
  
  // Write out the contents of home directory to console
  NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);  
  
  // execute save to disk as a background thread
  dispatch_queue_t myQueue = dispatch_queue_create("com.panoche.myqueue", 0);
  dispatch_async(myQueue, ^{
    BOOL wroteImg = [UIImagePNGRepresentation(img) writeToFile:bgImagePath atomically:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
      if (wroteImg) {   
        [self performSelectorOnMainThread: @selector(doNotification:) withObject: self waitUntilDone: YES];
      }
    });
  });
}


- (UIImage *) logoImage
{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                       NSUserDomainMask, 
                                                       YES);
  NSString *documentPaths = [paths objectAtIndex:0];
  NSString *logoImagePath = [documentPaths stringByAppendingPathComponent:@"logoImage.png"];
  
  NSData *imgData = [[NSData alloc] initWithContentsOfFile:logoImagePath];
  
  UIImage *logoImage = [[UIImage alloc] initWithData:imgData];
  
  return logoImage;
}

- (void) setLogoImage:(UIImage *)img
{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                       NSUserDomainMask, 
                                                       YES);
  NSString *documentPaths = [paths objectAtIndex:0];
  NSString *logoImagePath = [documentPaths stringByAppendingPathComponent:@"logoImage.png"];
  
  // Create file manager
  NSError *error;
  NSFileManager *fileMgr = [NSFileManager defaultManager];
  
  // Point to Document directory
  NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
  
  // Write out the contents of home directory to console
  NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);  
  
  // execute save to disk as a background thread
  dispatch_queue_t myQueue = dispatch_queue_create("com.panoche.myqueue", 0);
  dispatch_async(myQueue, ^{
    BOOL wroteImg = [UIImagePNGRepresentation(img) writeToFile:logoImagePath atomically:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
      if (wroteImg) {   
        [self performSelectorOnMainThread: @selector(doNotification:) withObject: self waitUntilDone: YES];
      }
    });
  });
  
  
}

-(void) doNotification: (id) thingToPassAlong
{
//  [[NSNotificationCenter defaultCenter] postNotificationName:kImageSavedSuccessfully object:thingToPassAlong];
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved" 
                                                  message:@"Image stored" 
                                                 delegate:self 
                                        cancelButtonTitle:@"OK" 
                                        otherButtonTitles:nil];
  [alert show];
}




@end
