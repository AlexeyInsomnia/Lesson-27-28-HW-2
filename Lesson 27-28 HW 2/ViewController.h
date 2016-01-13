//
//  ViewController.h
//  Lesson 27-28 HW 2
//
//  Created by Alex on 12.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *lastNameField;

@property (weak, nonatomic) IBOutlet UITextField *loginField;

@property (weak, nonatomic) IBOutlet UITextField *pswdField;

@property (weak, nonatomic) IBOutlet UITextField *ageField;

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *arrayFields;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *arrayLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (assign, nonatomic) BOOL atPresent;

@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *pswdLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

