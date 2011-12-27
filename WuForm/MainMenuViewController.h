//
//  MainMenuViewController.h
//  WuForm
//
//  Created by hack intosh on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"

@interface MainMenuViewController : UIViewController
{
  UIButton *addButton;
  UIButton *listButton;
  UINavigationController *mainMenuNavigationController;
  AddViewController *addViewController;
  NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) IBOutlet UIButton *addButton;
@property (nonatomic, retain) IBOutlet UIButton *listButton;
@property (nonatomic, retain) IBOutlet UINavigationController *mainMenuNavigationController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction) showAddView:(id)sender;

@end