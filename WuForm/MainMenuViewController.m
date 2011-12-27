//
//  MainMenuViewController.m
//  WuForm
//
//  Created by hack intosh on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewController.h"

@implementation MainMenuViewController

@synthesize addButton;
@synthesize listButton;
@synthesize mainMenuNavigationController;
@synthesize managedObjectContext;

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
  
  self.title = @"Atrero Photography";
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background-2.png"]];
  addViewController = [[AddViewController alloc] init];
  addViewController.managedObjectContext = managedObjectContext;
  [self.navigationController setNavigationBarHidden:YES animated:NO];
  
   [addButton addTarget:self action:@selector(showAddView:) forControlEvents:UIControlEventTouchUpInside];
  
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:animated];
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
	return YES;
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


@end
