//
//  SettingsViewController.m
//  WuForm
//
//  Created by Ed Atrero on 3/18/12.
//  Copyright (c) 2012 Panocha Bros. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsStore.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface LogoPicker : NSObject <UINavigationControllerDelegate, UIPickerViewDelegate>

@end

@implementation LogoPicker
{
  UIImagePickerController *ip;  
  UIPopoverController *popoverController;
  UIImage *logoImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  NSLog(@"%s", __FUNCTION__);
  //  NSLog(@"%s", );
  
  logoImage = [info objectForKey:(NSString *) UIImagePickerControllerOriginalImage];
  
  [[SettingsStore defaultStore] setLogoImage:logoImage];
      
  NSNotification *note = [NSNotification notificationWithName:@"DismissPopup" 
                                                       object:self 
                                                     userInfo:nil]; 
  [[NSNotificationCenter defaultCenter] postNotification:note];
  
  
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
  NSLog(@"%s", __FUNCTION__);
  
}

@end

@interface SettingsViewController ()

@end

@implementation SettingsViewController
{
  UIImagePickerController *ip;  
  UIPopoverController *popoverController;
  UIImage *bgImage;
  LogoPicker *logoPicker;
}
@synthesize apiSubdomainField;
@synthesize scrollView;
@synthesize apiKeyField;
@synthesize apiHashField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  NSLog(@"%s", __FUNCTION__);
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  NSLog(@"%s", __FUNCTION__);
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  // Set the title.
  self.title = @"Settings";
  
  self.apiHashField.text      = [[SettingsStore defaultStore] apiHash];
  self.apiKeyField.text       = [[SettingsStore defaultStore] apiKey];
  self.apiSubdomainField.text = [[SettingsStore defaultStore] apiSubdomain];
  logoPicker = [[LogoPicker alloc] init];
  
  // Set Navigation Bar style
  scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height*1.5);  
  [self.navigationController setNavigationBarHidden:NO animated:NO];  
  ip = [[UIImagePickerController alloc] init];
  popoverController = [[UIPopoverController alloc] initWithContentViewController:ip];

  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; 
  [nc addObserver:self  
         selector:@selector(dismissPopup:)       
             name:@"DismissPopup"          
           object:nil];                     
  
}

- (void)viewWillAppear:(BOOL)animated
{
  
  bgImage = [SettingsStore defaultStore].bgImage;
  
  if (bgImage) {
    NSLog(@"User Bg img loaded");
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:bgImage];
  }
  else {
    NSLog(@"Default Bg img loaded");
    self.view.backgroundColor = [UIColor clearColor];
  }
}

- (void)viewDidUnload
{
  NSLog(@"%s", __FUNCTION__);
  [self setApiKeyField:nil];
  [self setApiHashField:nil];
  [self setScrollView:nil];
  [self setApiSubdomainField:nil];
  logoPicker = nil;
  [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  NSLog(@"%s", __FUNCTION__);
	return YES;
}

- (IBAction)doAPIKeyDidEnd:(id)sender {
  NSLog(@"%s", __FUNCTION__);
  [[SettingsStore defaultStore] setApiKey:self.apiKeyField.text];
}

- (IBAction)doAPIHashDidEnd:(id)sender {
  NSLog(@"%s", __FUNCTION__);
  [[SettingsStore defaultStore] setApiHash:self.apiHashField.text];
}

- (IBAction)doAPISubdomainDidEnd:(id)sender {
  NSLog(@"%s", __FUNCTION__);
  [[SettingsStore defaultStore] setApiSubdomain:self.apiSubdomainField.text];
}

- (IBAction)doPickImage:(id)sender {
  NSLog(@"%s", __FUNCTION__);

  
  [ip setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
  if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
  {
    NSLog(@"%s got photo library type", __FUNCTION__);    
  }
  
  NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
  
  if([mediaTypes containsObject:(NSString *) kUTTypeImage])
  {
    NSLog(@"%s got photo library has Images", __FUNCTION__);        
  }
  
  [ip setMediaTypes:[[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil]];
  [ip setDelegate:self];
  
  [popoverController setPopoverContentSize:CGSizeMake(320, 280) animated:YES];
//  [self presentViewController:popoverController animated:YES completion:Nil];
  [popoverController presentPopoverFromRect:CGRectMake(293.0, 403.0, 182, 37.0) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

  
}

- (IBAction)doPickLogo:(id)sender {
  NSLog(@"%s", __FUNCTION__);
  
  
  [ip setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
  if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
  {
    NSLog(@"%s got photo library type", __FUNCTION__);    
  }
  
  NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
  
  if([mediaTypes containsObject:(NSString *) kUTTypeImage])
  {
    NSLog(@"%s got photo library has Images", __FUNCTION__);        
  }
  
  [ip setMediaTypes:[[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil]];
  [ip setDelegate:logoPicker];
  
  [popoverController setPopoverContentSize:CGSizeMake(320, 280) animated:YES];
  //  [self presentViewController:popoverController animated:YES completion:Nil];
  [popoverController presentPopoverFromRect:CGRectMake(293.0, 403.0, 182, 37.0) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  NSLog(@"%s", __FUNCTION__);
//  NSLog(@"%s", );

  bgImage = [info objectForKey:(NSString *) UIImagePickerControllerOriginalImage];

  self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:bgImage];
  
  [[SettingsStore defaultStore] setBgImage:bgImage];
  
  [popoverController dismissPopoverAnimated:YES];
  
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
  NSLog(@"%s", __FUNCTION__);
  
}

- (void)dismissPopup:(NSNotification *)note
{
  NSLog(@"%s", __FUNCTION__);
  [popoverController dismissPopoverAnimated:YES];
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
// A delegate method called by the URL text field when the user taps the Return 
// key.  We just dismiss the keyboard.
{
  NSLog(@"%s", __FUNCTION__);
  
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

@end
