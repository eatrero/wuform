//
//  SettingsStore.h
//  WuForm
//
//  Created by Ed Atrero on 3/18/12.
//  Copyright (c) 2012 Panocha Bros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsStore : NSObject

// Properties
@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *apiHash;
@property (nonatomic, strong) NSString *apiSubdomain;


// EventStore is a Singleton
+ (SettingsStore *) defaultStore;
- (void) initSettings;
- (void) storeSettings;

- (UIImage *) bgImage;
- (UIImage *) logoImage;
- (void) setBgImage:(UIImage *)img;
- (void) setLogoImage:(UIImage *)img;

@end
