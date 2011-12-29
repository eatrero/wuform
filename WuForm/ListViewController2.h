//
//  ListViewController2.h
//  WuForm
//
//  Created by hack intosh on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSplitViewController.h"
#import "ListMasterViewController.h"
#import "ListDetailViewController.h"

@interface ListViewController2 : UIViewController
{
  NSManagedObjectContext *managedObjectContext;
  MGSplitViewController *splitViewController;
  ListMasterViewController *listMasterViewController;
  ListDetailViewController *listDetailViewController;
  
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
