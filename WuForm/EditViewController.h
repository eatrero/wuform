//
//  ViewController.h
//  WuForm
//
//  Created by hack intosh on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UIPopoverControllerDelegate> 
{
  NSMutableArray *eventsArray;
  NSManagedObjectContext *managedObjectContext;
  UIButton *addButton2;
  UIPopoverController *popoverController;
  UIViewController *popoverViewController;
  UITextField *firstNameTextField;
  UITextField *lastNameTextField;
  UITextField *emailTextField;
}
@property (nonatomic, retain) NSMutableArray *eventsArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UIButton *addButton2;
@property (nonatomic, retain) UIViewController *popoverViewController;
@property (nonatomic, retain) IBOutlet UITextField *firstNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *emailTextField;


- (IBAction)addEvent:(id)sender;
- (IBAction)setDate:(id)sender;

@end
