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
  addViewController = [[AddViewController alloc] init];
  addViewController.managedObjectContext = managedObjectContext;
  
   [addButton addTarget:self action:@selector(showAddView:) forControlEvents:UIControlEventTouchUpInside];
  
    // Do any additional setup after loading the view from its nib.
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
  
  [mainMenuNavigationController pushViewController:addViewController animated:YES];

}


@end
