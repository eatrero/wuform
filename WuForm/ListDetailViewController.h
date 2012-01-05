//
//  ListDetailViewController.h
//  WuForm
//
//  Created by hack intosh on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "EventSyncher.h"

@interface ListDetailViewController : UIViewController
{
  Event       *event;
  UITextField *firstNameTextField;
  UITextField *lastNameTextField;
  UITextField *emailTextField;
  UITextField *weddingDateTextField;
  UILabel     *syncLabel;
  UIButton    *syncButton;
  EventSyncher *sync;
}

@property (nonatomic, retain) IBOutlet Event       *event;
@property (nonatomic, retain) IBOutlet UITextField *firstNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *emailTextField;
@property (nonatomic, retain) IBOutlet UITextField *weddingDateTextField;
@property (nonatomic, retain) IBOutlet UILabel     *syncLabel;
@property (nonatomic, retain) IBOutlet UIButton    *syncButton;

- (IBAction)syncEvent:(id)sender;
- (void)showEvent;
- (void)hideDisplay;
- (void)showDisplay;

@end
