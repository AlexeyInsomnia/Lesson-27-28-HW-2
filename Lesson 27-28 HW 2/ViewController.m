//
//  ViewController.m
//  Lesson 27-28 HW 2
//
//  Created by Alex on 12.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "ViewController.h"

typedef enum {
    
    APFieldsName,
    APFieldsLastName,
    APFieldsLogin,
    APFieldsPswd,
    APFieldsAge,
    APFieldsPhone,
    APFieldsEmail,
    
    
} APFields;

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    
    
    for (int i = 0; i < [self.arrayFields count]; i++) {
        if ([textField isEqual:self.emailField]) {
            [textField resignFirstResponder];
        } else if ([textField isEqual:[self.arrayFields objectAtIndex:i]]) {
            [[self.arrayFields objectAtIndex:i+1] becomeFirstResponder];
        }
    }
    
    return YES;
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    
 
    for (UILabel* label in self.arrayLabel) {
        if (textField.tag == label.tag	) //this is for clear button so
            label.text = nil;
    }
    
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString* resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    

    
    switch (textField.tag) {
        case APFieldsName:
            self.nameLabel.text = resultString;
            break;
            
        case APFieldsLastName:
            self.lastNameLabel.text = resultString;
            break;
        case APFieldsLogin:
            self.loginLabel.text = resultString;
            break;
        case APFieldsPswd:
            self.pswdLabel.text = resultString;
            break;
        case APFieldsAge:
            [self scriptAgeField:textField shouldChangeCharactersInRange:range replacementString:string];
            self.ageLabel.text = resultString;
                return NO;
            break;
        case APFieldsPhone:
            [self scriptPhoneField:textField shouldChangeCharactersInRange:range replacementString:string ];
            self.phoneLabel.text = resultString;
                return NO;
            break;
        case APFieldsEmail:
            [self scriptEmailField:textField shouldChangeCharactersInRange:range replacementString:string];
            self.emailLabel.text = resultString;
                return NO;
            break;
          
    }
    

   
    
    return YES;
 
    
}

#pragma mark - MethodsWithScriptsForFields

- (BOOL)scriptEmailField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    NSCharacterSet *validation = [NSCharacterSet characterSetWithCharactersInString:@"!~!#$%^,/|&*()<>=+{}][:;'\" \\"];
    
    NSArray * components = [string componentsSeparatedByCharactersInSet:validation];
    
    
    if ([components count] > 1) {
        return NO;
    }
    
    NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (([resultString rangeOfString:@"@"].length) < 1) {
        self.atPresent = NO;
    }
    
    if ([resultString length] < 2 && [string isEqualToString:@"@"]) {
        
        return NO;
    }
    
    if (self.atPresent && [string isEqualToString:@"@"]) {
        return NO;
    }
    
    if ([string isEqualToString:@"@"]) {
        self.atPresent = YES;
    }
    
    
     textField.text = resultString;
    
    
    
    return NO;
    
}


- (BOOL) scriptAgeField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSCharacterSet *validation = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    NSArray * components = [string componentsSeparatedByCharactersInSet:validation];
    
    if ([components count] > 1) {
        return NO;
    }
    
    NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([resultString intValue] < 16) {
        
        self.ageLabel.textColor = [UIColor redColor];
        textField.text = resultString;
        return NO;
        
    } else if ([resultString intValue] > 150) {
        
        self.ageLabel.textColor = [UIColor redColor];
        //textField.text = resultString;
        return NO;
        
    } else {
        
        textField.text = resultString;
        self.ageLabel.textColor = [UIColor blackColor];
        
    }
    
    
    
    return NO;
}



- (BOOL) scriptPhoneField: (UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
    /*
     if ([components count]>1) {
     NSLog(@"NOT VALID");
     } else {
     NSLog(@" VALID");
     }
     */
    // if user types not decimal (not numbers ) - field is not working
    if ([components count] > 1) {
        return NO;
    }
    
    
    //NSString* resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //NSLog(@"new string = %@", resultString);
    
    // lets format string
    
    NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    NSLog(@"new string = %@", newString);
    
    NSArray* validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    
    newString = [validComponents componentsJoinedByString:@""]; //add all to one
    
    NSLog(@"new string fixed = %@", newString);
    
    
    
    NSMutableString* resultString = [NSMutableString string];
    
    static const int localNumberMaxLength = 7;
    static const int areaCodeMaxLength = 3;
    static const int countryCodeMaxLength = 3;
    
    if ([newString length]> localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
        return NO;
    }
    
    // +XX (XXX) XXX-XXXX - local number
    
    NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
    
    if (localNumberLength > 0) {
        NSString* number= [newString substringFromIndex:(int)[newString length]-localNumberLength];
        
        [resultString appendString:number];
        
        if ([resultString length]>3) {
            [resultString insertString:@"-" atIndex:3];
        }
    }
    
    if ([newString length] > localNumberMaxLength ) {
        NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
        
        NSRange areaRange = NSMakeRange((int)[newString length]-localNumberMaxLength - areaCodeLength, areaCodeLength);
        NSString* area= [newString substringWithRange:areaRange];
        
        area = [NSString stringWithFormat:@"(%@)", area];
        
        [resultString insertString:area atIndex:0];
    }
    if ([newString length] > localNumberMaxLength +areaCodeMaxLength ) {
        NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
        
        NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
        NSString* countryCode = [newString substringWithRange:countryCodeRange];
        
        countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
        
        [resultString insertString:countryCode atIndex:0];
    }
    
    textField.text = resultString;
    
    return  NO;

}

@end
