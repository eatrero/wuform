//
//  ListDetailViewController.h
//  WuForm
//
//  Created by hack intosh on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListDetailViewController : UIViewController
{
  UITextField *firstNameTextField;
  UITextField *lastNameTextField;
  UITextField *emailTextField;
  UITextField *weddingDateTextField;  
}

@property (nonatomic, retain) IBOutlet UITextField *firstNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *emailTextField;
@property (nonatomic, retain) IBOutlet UITextField *weddingDateTextField;

@end
