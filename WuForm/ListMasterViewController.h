//
//  ListMasterViewController.h
//  WuForm
//
//  Created by hack intosh on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "ListDetailViewController.h"
#import "Event.h"
#import "EventSyncher.h"

@interface ListMasterViewController : UITableViewController <MFMailComposeViewControllerDelegate>
{
  NSArray *inquiryList;
  ListDetailViewController *listDetailViewController;
  Event *selectedEvent;
  EventSyncher *sync;
}
@property (nonatomic, retain) NSArray *inquiryList;
@property (nonatomic, retain) ListDetailViewController *listDetailViewController;
@property (nonatomic, retain) Event *selectedEvent;

- (void)selectFirstRow;
- (Boolean)syncList;
- (Boolean)exportListToCSV;

@end
