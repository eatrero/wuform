//
//  ListMasterViewController.h
//  WuForm
//
//  Created by hack intosh on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"
#import "Event.h"

@interface ListMasterViewController : UITableViewController
{
  NSArray *inquiryList;
  ListDetailViewController *listDetailViewController;
  Event *selectedEvent;
}
@property (nonatomic, retain) NSArray *inquiryList;
@property (nonatomic, retain) ListDetailViewController *listDetailViewController;
@property (nonatomic, retain) Event *selectedEvent;

- (void)selectFirstRow;

@end
