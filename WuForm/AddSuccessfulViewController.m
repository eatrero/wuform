//
//  AddSuccessfulViewController.m
//  WuForm
//
//  Created by Ed Atrero on 1/4/12.
//  Copyright (c) 2012 Panocha Bros. All rights reserved.
//

#import "AddSuccessfulViewController.h"
#import "SettingsStore.h"

@implementation AddSuccessfulViewController

@synthesize mainMenuViewController;
@synthesize okButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  // Set the title.
  self.title = @"Thank You!";
  
  UIImage *bgImage = [[SettingsStore defaultStore] bgImage];
  
  if (bgImage) {
    NSLog(@"User Bg img loaded");
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:bgImage];
  }
  else {
    NSLog(@"Default Bg img loaded");
    self.view.backgroundColor = [UIColor clearColor];
  }
  UIImage *btnImage = [UIImage imageNamed:@"date-button.png"];
  okButton = [[UIButton alloc] initWithFrame:CGRectMake(293.0, 540.0, 200.0, 60.0)];
  [okButton setBackgroundImage:btnImage forState:UIControlStateNormal];
  [okButton setTitle:@"OK" forState:UIControlStateNormal];
  [okButton addTarget:self action:@selector(returnToMainMenu:) forControlEvents:UIControlEventTouchUpInside];
  
  [self.view addSubview:okButton];
  
  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait || 
          interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)returnToMainMenu:(id)sender
{
  if (mainMenuViewController == nil)
  {
    NSLog(@"INVALID mainMenuViewController");
  }
  [mainMenuViewController popToRootViewControllerAnimated:YES];
}

@end
