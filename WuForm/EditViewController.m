//
//  ViewController.m
//  WuForm
//
//  Created by hack intosh on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "EditViewController.h"
#import "Event.h"
#import "weddingDateViewController.h"


@implementation ViewController
@synthesize eventsArray;
@synthesize managedObjectContext;
@synthesize addButton2;
@synthesize emailTextField;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.eventsArray = nil;
    self.addButton2 = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  return YES;
}

- (id)initWithStyle:(UITableViewStyle)style
{
//  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Set the title.
  self.title = @"WuForm";
  // Set up the buttons.
  
  addButton2 = [[UIButton alloc] init];
  [addButton2 addTarget:self action:@selector(addEvent) forControlEvents:UIControlEventTouchUpInside];
  [addButton2 setFrame:CGRectMake(0.0f, 0.0f, 60.0f, 40.0f)];
  [addButton2 setCenter:CGPointMake(120.0f,280.f)];
  [addButton2 setBackgroundColor:[UIColor blueColor]];
  [self.view addSubview:addButton2];
  
//  popoverViewController = [[UIViewController alloc] init];
  popoverViewController = [[WeddingDateViewController alloc] init];
  popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverViewController];
  [popoverController setPopoverContentSize:CGSizeMake(320, 280) animated:YES];
  
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event"
                                            inManagedObjectContext:managedObjectContext];
  [request setEntity:entity];
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                      initWithKey:@"creationDate" ascending:NO];
  NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor,
                              nil];
  [request setSortDescriptors:sortDescriptors];
  
  NSError *error = nil;
  NSMutableArray *mutableFetchResults = [[managedObjectContext
                                          executeFetchRequest:request error:&error] mutableCopy];
  if (mutableFetchResults == nil) {
    // Handle the error.
  }    
  [self setEventsArray:mutableFetchResults];    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return [eventsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  // A date formatter for the time stamp.
  static NSDateFormatter *dateFormatter = nil;
  if (dateFormatter == nil) {
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  }
  // A number formatter for the latitude and longitude.
  static NSNumberFormatter *numberFormatter = nil;
  if (numberFormatter == nil) {
    numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:3];
  }
  
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    UITableViewCellStyleSubtitle;
  }
  
  Event *event = (Event *)[eventsArray objectAtIndex:indexPath.row];
  cell.textLabel.text = [dateFormatter stringFromDate:[event creationDate]];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", [event firstName], [event lastName]];
  
  
  return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Navigation logic may go here. Create and push another view controller.
  /*
   <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
   // ...
   // Pass the selected object to the new view controller.
   [self.navigationController pushViewController:detailViewController animated:YES];
   [detailViewController release];
   */
}


#pragma mark

- (IBAction)addEvent:(id)sender {
  
  // Create and configure a new instance of the Event entity.
  Event *event = (Event *)[NSEntityDescription
                           insertNewObjectForEntityForName:@"Event"
                           inManagedObjectContext:managedObjectContext];
  
  [event setCreationDate:[NSDate date]];
  [event setFirstName:@"first name 2"];
  [event setLastName:@"last name"];
  
  NSError *error = nil;
  if (![managedObjectContext save:&error]) {
    // Handle the error.
  }    
  
#if 1
  // test
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = (Event *)[NSEntityDescription entityForName:@"Event"
                                            inManagedObjectContext:managedObjectContext];
  [request setEntity:entity];
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                      initWithKey:@"creationDate" ascending:YES];
  NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor,
                              nil];
  [request setSortDescriptors:sortDescriptors];
  
  NSMutableArray *mutableFetchResults = [[managedObjectContext
                                          executeFetchRequest:request error:&error] mutableCopy];  
  
  Event *eventTmp;
  for (eventTmp in mutableFetchResults) {
    NSLog(@"%@", eventTmp.firstName);
  }  
  
#endif  
  
  [eventsArray insertObject:event atIndex:0];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  
}

- (IBAction)setDate:(id)sender
{
  [self.emailTextField resignFirstResponder];

  NSLog(@"Popup Controller");
  [popoverController presentPopoverFromRect:CGRectMake(293.0, 403.0, 182, 37.0) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
  
//  UIPopoverController *aPopoverController = [[UIPopoverController alloc] initWithContentViewController:];
//  [aPopoverController setDelegate:self];
//  [aPopoverController presentPopoverFromRect:CGRectMake(40, 40, 40, 40) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//  [aPopoverController setPopoverContentSize:CGSizeMake(240, 320)];

}


- (void)textFieldDidEndEditing:(UITextField *)textField
// A delegate method called by the URL text field when the editing is complete. 
// We save the current value of the field in our settings.
{
  [textField resignFirstResponder];
  return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
// A delegate method called by the URL text field when the user taps the Return 
// key.  We just dismiss the keyboard.
{
  [textField resignFirstResponder];
  return NO;
}

@end
