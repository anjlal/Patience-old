//
//  DOCTaskDetailViewController.h
//  Patience
//
//  Created by Angie Lal on 11/12/13.
//  Copyright (c) 2013 Angie Lal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOCTask.h"

@interface DOCTaskDetailViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *patientPhoto;
@property (weak, nonatomic) IBOutlet UILabel *taskID;
@property (weak, nonatomic) IBOutlet UIButton *patientName;
@property (weak, nonatomic) IBOutlet UITextView *taskDescription;
@property (weak, nonatomic) IBOutlet UIButton *completed;
@property (weak, nonatomic) IBOutlet UIButton *assign;
@property (weak, nonatomic) IBOutlet UIButton *sendMessage;

@property DOCTask *task;

@end
