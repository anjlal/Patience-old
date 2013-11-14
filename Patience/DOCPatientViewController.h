//
//  DOCPatientViewController.h
//  Patience
//
//  Created by Angie Lal on 11/13/13.
//  Copyright (c) 2013 Angie Lal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOCPatientViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIView *tableHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *patientPhoto;
@property (weak, nonatomic) IBOutlet UILabel *patientNameLabel;

@end
