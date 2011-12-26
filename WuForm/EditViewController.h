//
//  ViewController.h
//  WuForm
//
//  Created by hack intosh on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPopoverControllerDelegate>
{
  NSMutableArray *eventsArray;
  NSManagedObjectContext *managedObjectContext;
  UIButton *addButton2;
  UIPopoverController *popoverController;
  UIViewController *popoverViewController;
}
@property (nonatomic, retain) NSMutableArray *eventsArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UIButton *addButton2;
@property (nonatomic, retain) UIViewController *popoverViewController;

- (IBAction)addEvent:(id)sender;
- (IBAction)setDate:(id)sender;
@end
