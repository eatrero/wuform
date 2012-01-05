//
//  AddViewController.h
//  WuForm
//
//  Created by Ed Atrero on 12/31/11.
//  Copyright (c) 2011 Panocha Bros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "weddingDateViewController.h"
#import "Event.h"


@interface AddViewController : UIViewController <UITextFieldDelegate, UIPopoverControllerDelegate, WeddingDateViewControllerDelegate> 
{
  NSMutableArray *eventsArray;
  NSManagedObjectContext *managedObjectContext;
  UINavigationController *mainMenuViewController;
  UIViewController *showAddSuccessfulView;
  UIButton *addButton2;
  UIPopoverController *popoverController;
  WeddingDateViewController *popoverViewController;
  UITextField *firstNameTextField;
  UITextField *lastNameTextField;
  UITextField *emailTextField;
  UIButton *setDateButton;
  NSDate *weddingDate;
  Event *newEvent;
}
@property (nonatomic, retain) NSMutableArray *eventsArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UINavigationController *mainMenuViewController;
@property (nonatomic, retain) IBOutlet UIButton *addButton2;
@property (nonatomic, retain) UIViewController *popoverViewController;
@property (nonatomic, retain) IBOutlet UITextField *firstNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *emailTextField;
@property (nonatomic, retain) IBOutlet UIButton    *setDateButton;
@property (nonatomic, retain) NSDate *weddingDate;

- (IBAction)addEvent:(id)sender;
- (IBAction)enteredFirstName:(id)sender;
- (IBAction)enteredLastName:(id)sender;
- (IBAction)enteredEmail:(id)sender;
- (IBAction)setDate:(id)sender;
- (void)dateSelected:(NSDate *)date;
- (void)resetForm;
- (void)showForm;
- (void)hideForm;
- (BOOL)isValidEvent;
- (BOOL)isValidEmail:(NSString *)checkString;
- (void)disableSaveButton;
- (void)enableSaveButton;

@end
