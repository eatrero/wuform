//
//  ListViewController2.h
//  WuForm
//
//  Created by hack intosh on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MGSplitViewController.h"
#import "ListMasterViewController.h"
#import "ListDetailViewController.h"

@interface ListViewController2 : UIViewController <UIActionSheetDelegate>
{
  NSManagedObjectContext *managedObjectContext;
  ListMasterViewController *listMasterViewController;
  ListDetailViewController *listDetailViewController;
  
}
@property (nonatomic, retain) NSManagedObjectContext   *managedObjectContext;
@property (nonatomic, retain) ListMasterViewController *listMasterViewController;
@property (nonatomic, retain) ListDetailViewController *listDetailViewController;


- (CGSize)splitViewSizeForOrientation:(UIInterfaceOrientation)theOrientation;

@end
