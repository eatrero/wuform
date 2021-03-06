//
//  MainMenuViewController.m
//  WuForm
//
//  Created by hack intosh on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ListViewController2.h"
#import "AddSuccessfulViewController.h"
#import "SettingsViewController.h"
#import "SettingsStore.h"

@implementation MainMenuViewController
{
  UIImage *logoImage;
  UIView  *logoView;
}
 
@synthesize addButton;
@synthesize listButton;
@synthesize mainMenuNavigationController;
@synthesize managedObjectContext;
@synthesize logoImageView;
@synthesize logoView;

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
  
  self.title = @"Main Menu";
  UIImage *bgImage = [[SettingsStore defaultStore] bgImage];
  
  if (bgImage) {
    NSLog(@"User Bg img loaded");
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:bgImage];
  }
  else {
    NSLog(@"Default Bg img loaded");
//    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background-2.png"]];
    self.view.backgroundColor = [UIColor clearColor];
  }  
  
  addViewController = [[AddViewController alloc] init];
  [addViewController setMainMenuViewController:[self mainMenuNavigationController]];
  addViewController.managedObjectContext = managedObjectContext;
  [self.navigationController setNavigationBarHidden:YES animated:NO];
//  [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
  
  [addButton addTarget:self action:@selector(showAddView:) forControlEvents:UIControlEventTouchUpInside];
  [listButton addTarget:self action:@selector(showListView:) forControlEvents:UIControlEventTouchUpInside];
  [self.logoImageView setOpaque:YES];
  [self.logoView setOpaque:YES];

}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:NO];
  
  // load background
  UIImage *bgImage = [[SettingsStore defaultStore] bgImage];
  
  if (bgImage) {
    NSLog(@"User Bg img loaded");
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:bgImage];
  }
  else {
    NSLog(@"Default Bg img loaded");
    self.view.backgroundColor = [UIColor clearColor];
  }
  
  // load logo 
	//Set Animation Properties
	[UIView setAnimationDuration: 0.50];
  self.logoView.backgroundColor = [UIColor clearColor];
  self.logoImageView.contentMode = UIViewContentModeCenter;
  logoImage = [[SettingsStore defaultStore] logoImage];
  [self.logoImageView setImage:logoImage];
}


- (void)viewDidUnload
{
    [self setLogoImageView:nil];
  [self setLogoView:nil];
  [self setLogoImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait || 
            interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)showAddView:(id)sender
{
  // 
  NSLog(@"ShowAddView");
  
	//Set Animation Properties
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: 0.50];
	
	//Hook To MainView
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.mainMenuNavigationController.view cache:YES];
	
	//Push OnTo NavigationController
  [mainMenuNavigationController pushViewController:addViewController animated:NO];
	
	//Start Animation
	[UIView commitAnimations];
}

- (IBAction)showListView:(id)sender
{
  // 
  NSLog(@"ShowListView");
  listViewController = [[ListViewController2 alloc] init];
  [listViewController setManagedObjectContext:managedObjectContext];
  
	//Set Animation Properties
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: 0.50];
	
	//Hook To MainView
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.mainMenuNavigationController.view cache:YES];

	//Push OnTo NavigationController
  [mainMenuNavigationController pushViewController:listViewController animated:NO];
	
	//Start Animation
	[UIView commitAnimations];
}

- (IBAction)showSettingsView:(id)sender 
{
  NSLog(@"%s", __FUNCTION__);
  
  SettingsViewController *settingsVC = [[SettingsViewController alloc] init];
  
	//Set Animation Properties
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: 0.50];
	
	//Hook To MainView
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.mainMenuNavigationController.view cache:YES];
	//Push OnTo NavigationController
  [mainMenuNavigationController pushViewController:settingsVC animated:NO];
  
	//Start Animation
	[UIView commitAnimations];
}
@end
