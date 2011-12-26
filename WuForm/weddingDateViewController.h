//
//  weddingDateViewController.h
//  WuForm
//
//  Created by hack intosh on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeddingDateViewController : UIViewController
{
  UIDatePicker *weddingDatePicker;
  NSDate *weddingDate;
  UIButton *okButton;
}

@property NSDate *weddingDate;
- (IBAction)finishedDateSelection:(id)sender;

@end
