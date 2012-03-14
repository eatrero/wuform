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
{
  Event *currEvent;
}

@synthesize inquiryList;
@synthesize listDetailViewController;
@synthesize selectedEvent;

- (id) init
{
  // Call the superclass's designtated initializer
  self = [super initWithStyle:UITableViewStyleGrouped];
  
  // Init the eventSyncher
  if (self) {
    // Add event synch
    sync = [[EventSyncher alloc] init];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; 
    [nc addObserver:self                      // The object self will be sent 
           selector:@selector(nextEvent:)     // send msg to @nextEvent: after the event is synched   
               name:@"UpdateDisplay"          // when @"UpdateDisplay" is posted 
             object:nil];                     // by any object.

  }
  
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
    
    if ([self.tableView numberOfSections] > 0 && [self.tableView numberOfRowsInSection:0] > 0) {
      if(indexPath.row>1)
      {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:0];
        [self.tableView selectRowAtIndexPath:newIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self tableView:self.tableView didSelectRowAtIndexPath:newIndexPath];
      }
      else
      {
        [self selectFirstRow];
      }
      
    }
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

- (Boolean)syncList
{
  NSLog(@"%s", __FUNCTION__);

  Boolean allSync = YES;

  NSArray *events = [[EventStore defaultStore] allEvents];
  
  if(events == nil)
  {
    return NO;    
  }
  
  for (currEvent in events)
  {
    if (![currEvent.synched boolValue]) {
      NSLog(@"%@ Not Synched. Kick off sync", [currEvent uuid]);
      allSync = NO;
      [sync startSync:currEvent];
      break;
    }
    else{
      NSLog(@"Synched");
    }
  }
  
  if(allSync)
  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"All Synched" message:@"All entires are already synched!  W00t!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];        
    
    NSLog(@"%@, %@, %@, %@,", 
          @"First Name", 
          @"Last Name",
          @"Email",
          @"Date");
    
    for (currEvent in events)
    {
      NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateFormat:@"MM-dd-yyyy"];
//      [dateFormatter setDateFormat:@"yyyyMMdd"];
      NSString *dateString = [dateFormatter stringFromDate:currEvent.weddingDate];  

      
      NSLog(@"%@, %@, %@, %@,", 
            currEvent.firstName, 
            currEvent.lastName,
            currEvent.emailAddress,
            dateString);
      
    }    
  }
  
  return YES;
}

- (Boolean)exportListToCSV
{
  NSLog(@"%s", __FUNCTION__);
#if 1    
  NSArray *events = [[EventStore defaultStore] allEvents];
  
  if(events == nil)
  {
    return NO;    
  }
  
  NSString *eventsCSVString = [[NSString alloc] initWithFormat:@"First Name, Last Name, Email, Phone, Location, Comment, Date, Company, Business Type, Title, Website\n"];
  NSLog(@"First Name, Last Name, Email, Phone, Location, Comment, Date, Company, Business Type, Title, Website\n");        
  
  for (currEvent in events)
  {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:currEvent.weddingDate];  
    

    eventsCSVString = [eventsCSVString stringByAppendingFormat:@"%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@\n", 
                       currEvent.firstName, 
                       currEvent.lastName,
                       currEvent.emailAddress,
                       currEvent.phone,
                       currEvent.location,
                       currEvent.comment,
                       dateString,
                       currEvent.company,
                       currEvent.business,
                       currEvent.title,
                       currEvent.website
                       ];
    NSLog(@"%@, %@, %@, %@\n", 
          currEvent.firstName, 
          currEvent.lastName,
          currEvent.emailAddress,
          dateString);        
  }
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
  NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
  
  NSError *error;
  BOOL succeed = [eventsCSVString writeToFile:[documentsDirectory stringByAppendingPathComponent:@"entries.csv"]
                            atomically:YES encoding:NSUTF8StringEncoding error:&error];
  if (!succeed){
    // Handle error here
    NSLog(@"Write to FILE FAILED\n");        
  }
#endif  
  
//  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
//  NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
  

  MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
  controller.mailComposeDelegate = self;
  
  //get list of document directories in sandbox 
//  NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
  //get one and only document directory from that list
  NSString *documentDirectory = [documentsDirectory stringByAppendingPathComponent:@"/entries.csv"];

  if([[NSFileManager defaultManager] fileExistsAtPath:documentDirectory])
  {
    [controller setToRecipients:[NSArray arrayWithObject:[NSString stringWithString:@"info@aperturaphoto.com"]]];
    [controller setMessageBody:@"You've got contacts..." isHTML:NO];
    [controller setSubject:@"You've got contacts"];
    
    NSError *error;
    NSString *tstRead = [NSString stringWithContentsOfFile:documentDirectory encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"Read back: %@", tstRead);
    
    NSURL *csvURL = [NSURL fileURLWithPath:documentDirectory];
    NSData *csvData = [NSData dataWithContentsOfURL:csvURL];
    NSLog(@"Read back: %@", [csvData description]);
    [controller addAttachmentData:csvData mimeType:@"text/csv" fileName:@"entries.csv"];
    
    [self presentModalViewController:controller animated:YES];
    
    return YES;
  }
  
  return NO;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
  // NEVER REACHES THIS PLACE
  [self dismissModalViewControllerAnimated:YES];
  
  NSLog (@"mail finished");
}

- (void) nextEvent:(NSNotification *)note
{
  NSLog(@"%s", __FUNCTION__);
  
  Boolean allSync = NO;
  
  NSArray *events = [[EventStore defaultStore] allEvents];
  
  for (currEvent in events)
  {
    if (![currEvent.synched boolValue]) {
      NSLog(@"%@ Not Synched. Kick off sync", [currEvent uuid]);
      allSync = NO;
//      [sync startSync:currEvent];
      [NSTimer scheduledTimerWithTimeInterval:0.500 
                                       target:sync 
                                     selector:@selector(startSync2:) 
                                     userInfo:currEvent 
                                      repeats:NO];
      break;
    }
    else{
      NSLog(@"Synched");
    }
  }
  
  if(allSync)
  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Synch Finished!" message:@"Great Success!  All entries are now synchronized." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];        
  }
}
@end
