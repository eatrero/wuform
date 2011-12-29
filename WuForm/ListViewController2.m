//
//  ListViewController2.m
//  WuForm
//
//  Created by hack intosh on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ListViewController2.h"

@implementation ListViewController2
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
    // Do any additional setup after loading the view from its nib.
  [self.navigationController setNavigationBarHidden:NO animated:NO];
  splitViewController = [[MGSplitViewController alloc] initWithNibName:Nil bundle:Nil];
  listMasterViewController = [[ListMasterViewController alloc] init];
  listDetailViewController = [[ListDetailViewController alloc] init];
  splitViewController.masterViewController = listMasterViewController;
  splitViewController.detailViewController = listDetailViewController;
  
  splitViewController.showsMasterInPortrait = YES;
  splitViewController.splitWidth = 4.0; // make it wide enough to actually drag!
  splitViewController.allowsDraggingDivider = NO;
  [self.view addSubview:splitViewController.view];
  
  [self.navigationController setNavigationBarHidden:NO animated:NO];
  
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

@end
