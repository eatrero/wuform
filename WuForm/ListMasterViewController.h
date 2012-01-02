//
//  ListMasterViewController.h
//  WuForm
//
//  Created by hack intosh on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"

@interface ListMasterViewController : UITableViewController
{
  NSArray *inquiryList;
  ListDetailViewController *listDetailViewController;
}
@property (nonatomic, retain) NSArray *inquiryList;
@property (nonatomic, retain) ListDetailViewController *listDetailViewController;
- (void)selectFirstRow;

@end
