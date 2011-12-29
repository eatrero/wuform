//
//  ListViewController.h
//  WuForm
//
//  Created by hack intosh on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MGSplitViewController.h"
#import "ListMasterViewController.h"
#import "ListDetailViewController.h"

@interface ListViewController : MGSplitViewController
{
  NSManagedObjectContext *managedObjectContext;
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
