//
//  ListMasterViewController.m
//  WuForm
//
//  Created by hack intosh on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ListMasterViewController.h"
#import "EventStore.h"

@implementation ListMasterViewController
@synthesize inquiryList;
@synthesize listDetailViewController;
@synthesize selectedEvent;

- (id) init
{
  // Call the superclass's designtated initializer
  self = [super initWithStyle:UITableViewStyleGrouped];
  
  return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
  return [self init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.clearsSelectionOnViewWillAppear = NO;
//  self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// There is only one section.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of time zone names.
  NSInteger count = [[[EventStore defaultStore] allEvents] count];
  if (count==0){
    [listDetailViewController hideDisplay];
  }
  else {
    [listDetailViewController showDisplay];    
  }
  return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	// Try to retrieve from the table view a now-unused cell with the given identifier.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	// If no cell is available, create a new one using the given identifier.
	if (cell == nil) {
		// Use the default cell style.
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
	}
	
	// Set up the cell.
//	Event *inquiry = [inquiryList objectAtIndex:indexPath.row];
//	cell.textLabel.text = timeZoneName;
//  cell.textLabel.text = @"Elvis";
  Event *event = [[[EventStore defaultStore] allEvents] objectAtIndex:indexPath.row];
//  cell.textLabel.text = timeZoneName;
  NSString *name = [NSString stringWithFormat:@"%@ %@", event.firstName, event.lastName];
  cell.textLabel.text = name;
	
	return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Return NO if you do not want the specified item to be editable.
  return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete the row
    Event *event = [[[EventStore defaultStore] allEvents] objectAtIndex:indexPath.row];
    [[EventStore defaultStore] removeEvent:event];
    
    // Delete the row from the data source
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
  }   
  else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }   
}

/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}
 */

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// When a row is selected, set the detail view controller's detail item to the item associated with the selected row.
  Event *event = [[[EventStore defaultStore] allEvents] objectAtIndex:indexPath.row];
  [self setSelectedEvent:event];
  [[self listDetailViewController] setEvent:event];
  [[self listDetailViewController] showEvent];
  
}

- (void)selectFirstRow
{
	if ([self.tableView numberOfSections] > 0 && [self.tableView numberOfRowsInSection:0] > 0) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
		[self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
		[self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
	}
}


@end
