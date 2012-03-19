//
//  SettingsViewController.m
//  WuForm
//
//  Created by Ed Atrero on 3/18/12.
//  Copyright (c) 2012 Panocha Bros. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsStore.h"
@interface SettingsViewController ()

@end

@implementation SettingsViewController
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
  self.apiHashField.text      = [[SettingsStore defaultStore] apiHash];
  self.apiKeyField.text       = [[SettingsStore defaultStore] apiKey];
  self.apiSubdomainField.text = [[SettingsStore defaultStore] apiSubdomain];
  
  // Set Navigation Bar style
  scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height*1.5);  
  [self.navigationController setNavigationBarHidden:NO animated:NO];  
}

- (void)viewDidUnload
{
  NSLog(@"%s", __FUNCTION__);
  [self setApiKeyField:nil];
  [self setApiHashField:nil];
  [self setScrollView:nil];
  [self setApiSubdomainField:nil];
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
