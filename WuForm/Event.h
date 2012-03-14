//
//  Event.h
//  WuForm
//
//  Created by hack intosh on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSDate   * creationDate;
@property (nonatomic, retain) NSDate   * weddingDate;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * emailAddress;
@property (nonatomic, retain) NSNumber * synched;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * business;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * website;

@end
