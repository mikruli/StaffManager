//
//  AddRoleTVC.h
//  StaffManager
//
//  Created by Dejan Kumric on 1/31/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddRoleTVC;
@protocol AddRoleTVCDelegate
- (void)theSaveButtonOnTheAddRoleTVCWasTapped:(AddRoleTVC *)controller;
@end

@interface AddRoleTVC : UITableViewController
@property (weak, nonatomic) id <AddRoleTVCDelegate> delegate;
- (IBAction)save:(id)sender;
@end
