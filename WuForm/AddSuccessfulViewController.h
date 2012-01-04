//
//  AddSuccessfulViewController.h
//  WuForm
//
//  Created by Ed Atrero on 1/4/12.
//  Copyright (c) 2012 Panocha Bros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSuccessfulViewController : UIViewController
{
  UINavigationController *mainMenuViewController;  
  UIButton *okButton;
}
@property (nonatomic, retain) UINavigationController *mainMenuViewController;
@property (nonatomic, retain) UIButton *okButton;

- (IBAction)returnToMainMenu:(id)sender;

@end
