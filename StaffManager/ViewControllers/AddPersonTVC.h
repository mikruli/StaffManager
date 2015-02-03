//
//  AddPersonTVC.h
//  StaffManager
//
//  Created by Dejan Kumric on 2/2/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddPersonTVC;
@protocol AddPersonTVCDelegate
- (void)theSaveButtonOnTheAddPersonTVCWasTapped:(AddPersonTVC *)controller;
@end

@interface AddPersonTVC : UITableViewController
// @property (strong, nonatomic) IBOutlet UITextField *personNameTextField;
@property (weak, nonatomic) id <AddPersonTVCDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField *personFirstnameTextField;
@property (strong, nonatomic) IBOutlet UITextField *personSurnameTextField;
- (IBAction)save:(id)sender;
@end
