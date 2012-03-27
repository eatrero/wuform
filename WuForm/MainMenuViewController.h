//
//  MainMenuViewController.h
//  WuForm
//
//  Created by hack intosh on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"
#import "ListViewController2.h"

@interface MainMenuViewController : UIViewController
{
  UIButton *addButton;
  UIButton *listButton;
  UINavigationController *mainMenuNavigationController;
  AddViewController *addViewController;
  ListViewController2 *listViewController;
  NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) IBOutlet UIButton *addButton;
@property (nonatomic, retain) IBOutlet UIButton *listButton;
@property (nonatomic, retain) IBOutlet UINavigationController *mainMenuNavigationController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UIView *logoView;

- (IBAction) showAddView:(id)sender;
- (IBAction) showListView:(id)sender;
- (IBAction) showSettingsView:(id)sender;

@end
