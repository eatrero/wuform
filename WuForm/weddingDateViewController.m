//
//  weddingDateViewController.m
//  WuForm
//
//  Created by hack intosh on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "weddingDateViewController.h"

#define MAX_DATE_IN_SEC 60*60*24*365.25*10.0  // 10 years

@implementation WeddingDateViewController

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
  weddingDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
  [weddingDatePicker setDatePickerMode:UIDatePickerModeDate];
  [weddingDatePicker setMinimumDate:[[NSDate alloc] initWithTimeIntervalSinceNow:0.0]];
  [weddingDatePicker setMaximumDate:[[NSDate alloc] initWithTimeIntervalSinceNow:MAX_DATE_IN_SEC]];
  [self.view addSubview:weddingDatePicker];
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
