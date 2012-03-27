//
//  AddViewController.m
//  WuForm
//
//  Created by Ed Atrero on 12/31/11.
//  Copyright (c) 2011 Panocha Bros. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "AddViewController.h"
#import "AddSuccessfulViewController.h"
#import "Event.h"
#import "SettingsStore.h"

@implementation AddViewController
@synthesize eventsArray;
@synthesize managedObjectContext;
@synthesize mainMenuViewController;
@synthesize addButton2;
@synthesize popoverViewController;
@synthesize firstNameTextField;
@synthesize lastNameTextField;
@synthesize emailTextField;
@synthesize setDateButton;
@synthesize weddingDate;

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
  newEvent = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self resetForm];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration: 1.50];
  
  //Hook To MainView
  [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
  
  [self.navigationController setNavigationBarHidden:NO animated:NO];
  
  [super viewWillDisappear:NO];
  
  [UIView commitAnimations];  
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait || 
          interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);

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
  self.title = @"Add";
  
  UIImage *bgImage = [[SettingsStore defaultStore] bgImage];
  
  if (bgImage) {
    NSLog(@"User Bg img loaded");
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:bgImage];
  }
  else {
    NSLog(@"Default Bg img loaded");
    self.view.backgroundColor = [UIColor clearColor];
  }
  
  // popoverViewController = [[UIViewController alloc] init];
  popoverViewController = [[WeddingDateViewController alloc] init];
  [popoverViewController setResponder:self];
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
  }
  
  Event *event = (Event *)[eventsArray objectAtIndex:indexPath.row];
  cell.textLabel.text = [dateFormatter stringFromDate:[event creationDate]];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", [event firstName], [event lastName]];
  
  
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
    // Post a note to notification center that the Event was deleted.
    
    // Delete the row from the data source
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
  }   
  else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }   
}

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
  
  if(![self isValidEvent])
  {
    NSLog(@"Invalid Entry.");
    return;
  }
  
  // Create and configure a new instance of the Event entity.
  Event *event = (Event *)[NSEntityDescription
                           insertNewObjectForEntityForName:@"Event"
                           inManagedObjectContext:managedObjectContext];
  
  [event setCreationDate:[NSDate date]];
  [event setFirstName:firstNameTextField.text];
  [event setLastName:lastNameTextField.text];
  [event setEmailAddress:emailTextField.text];
  [event setWeddingDate:weddingDate];
  [event setSynched:[NSNumber numberWithBool:NO]];
  
  CFUUIDRef theUUID = CFUUIDCreate(NULL);
  CFStringRef theUUIDCFString = CFUUIDCreateString(NULL, theUUID);  
  NSString *theUUIDString = (__bridge_transfer NSString *) theUUIDCFString;
  NSLog(@"uuid = %@", theUUIDString);
  [event setUuid:theUUIDString];
   
  
  NSError *error = nil;
  if (![managedObjectContext save:&error]) {
    // Handle the error.
  }    
  
#ifdef TEST_ADD
  // test
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event"
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
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle:NSDateFormatterMediumStyle];

  NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
  for (eventTmp in mutableFetchResults) {
    NSLog(@"%@ %@ %@ %@ %@", eventTmp.firstName, eventTmp.lastName, eventTmp.emailAddress, [dateFormatter stringFromDate:eventTmp.weddingDate], [numberFormatter stringFromNumber:eventTmp.synched]);
  }  
  
#endif  
  
  [eventsArray insertObject:event atIndex:0];
//  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	//Push OnTo NavigationController
  AddSuccessfulViewController *addSuccessfulViewController = [[AddSuccessfulViewController alloc] init];
  [addSuccessfulViewController setMainMenuViewController:mainMenuViewController];
  [[self mainMenuViewController] pushViewController:addSuccessfulViewController animated:YES];
//  [self showForm];
  
}

- (IBAction)setDate:(id)sender
{
  [self.emailTextField resignFirstResponder];
  [self.lastNameTextField resignFirstResponder];
  [self.firstNameTextField resignFirstResponder];

  NSLog(@"Popup Controller");
  [popoverController presentPopoverFromRect:CGRectMake(260.0, 403.0, 182, 37.0) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
  
}


- (void)textFieldDidEndEditing:(UITextField *)textField
// A delegate method called by the URL text field when the editing is complete. 
// We save the current value of the field in our settings.
{
  [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
// A delegate method called by the URL text field when the user taps the Return 
// key.  We just dismiss the keyboard.
{
  NSInteger nextTag = textField.tag + 1;
  // Try to find next responder
  UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
  if (nextResponder) {
    // Found next responder, so set it.
    [nextResponder becomeFirstResponder];
  } else {
    // Not found, so remove keyboard.
    [textField resignFirstResponder];
  }
  return NO; // We do not want UITextField to insert line-breaks.
}

- (void)dateSelected:(NSDate *)date;
{
  NSLog(@"date Selected delegate");  
  self.weddingDate = date;
  [newEvent setWeddingDate:date];
  [self isValidEvent];
  NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  setDateButton.titleLabel.text = [dateFormatter stringFromDate:date];
  setDateButton.titleLabel.textAlignment = UITextAlignmentCenter;
  [popoverController dismissPopoverAnimated:YES];
}

- (void)resetForm
{
  [[self firstNameTextField] setText:nil];
  [[self lastNameTextField] setText:nil];
  [[self emailTextField] setText:nil];
  [[[self setDateButton] titleLabel] setText:@"WEDDING DATE"];
  [self disableSaveButton];  
  self.weddingDate= nil;
}

- (void)hideForm
{
  [[self firstNameTextField] setHidden:YES];
  [[self lastNameTextField] setHidden:YES];
  [[self emailTextField] setHidden:YES];
  [[self setDateButton] setHidden:YES];  
}

- (void)showForm
{
  [[self firstNameTextField] setHidden:NO];
  [[self lastNameTextField] setHidden:NO];
  [[self emailTextField] setHidden:NO];
  [[self setDateButton] setHidden:NO];  
}

- (BOOL)isValidEvent
{
  // check for valid email
  if (![self isValidEmail:[[self emailTextField] text]]) {
    [self disableSaveButton];
    return NO;
  }
  
  // check for valid first name & last name
  if ((self.firstNameTextField.text.length == 0) || (self.lastNameTextField.text.length == 0))
  {
    [self disableSaveButton];
    return NO;    
  }
  
  // check for valid wedding date
  if (![self weddingDate])
  {
    [self disableSaveButton];
    return NO;    
  }
  [self enableSaveButton];
  return YES;  
}

- (BOOL)isValidEmail:(NSString *)checkString
{
  BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
  NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
  NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
  NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
  NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  return [emailTest evaluateWithObject:checkString];
}

- (IBAction)enteredFirstName:(id)sender
{
  [self isValidEvent];
}

- (IBAction)enteredLastName:(id)sender
{
  [self isValidEvent];
}

- (IBAction)enteredEmail:(id)sender
{
  [self isValidEvent];
  if(![self isValidEmail:[[self emailTextField] text]])
  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Check yo email!" message:@"Please check if your email is entered correctly.  Thanks!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];    
  }
}

- (void)disableSaveButton
{
  [addButton2 setEnabled:NO];    
  [addButton2 setAlpha:0.5];  
}
- (void)enableSaveButton
{
  [addButton2 setEnabled:YES];    
  [addButton2 setAlpha:1.0];  
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self.emailTextField resignFirstResponder];
  [self.firstNameTextField resignFirstResponder];
  [self.lastNameTextField resignFirstResponder];
}

@end
