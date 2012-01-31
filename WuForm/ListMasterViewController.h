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
#import "EventSyncher.h"

@interface ListMasterViewController : UITableViewController
{
  NSArray *inquiryList;
  ListDetailViewController *listDetailViewController;
  Event *selectedEvent;
  Event *currEvent;
  EventSyncher *sync;
}
@property (nonatomic, retain) NSArray *inquiryList;
@property (nonatomic, retain) ListDetailViewController *listDetailViewController;
@property (nonatomic, retain) Event *selectedEvent;
@property (nonatomic, retain) Event *currEvent;

- (void)selectFirstRow;
- (Boolean)syncList;

@end
