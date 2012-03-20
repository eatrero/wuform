//
//  SettingsViewController.h
//  WuForm
//
//  Created by Ed Atrero on 3/18/12.
//  Copyright (c) 2012 Panocha Bros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *apiKeyField;
@property (strong, nonatomic) IBOutlet UITextField *apiHashField;
@property (strong, nonatomic) IBOutlet UITextField *apiSubdomainField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)doAPIKeyDidEnd:(id)sender;
- (IBAction)doAPIHashDidEnd:(id)sender;
- (IBAction)doAPISubdomainDidEnd:(id)sender;
- (IBAction)doPickImage:(id)sender;


@end
