//
//  DOCNewTaskViewController.m
//  Patience
//
//  Created by Angie Lal on 11/25/13.
//  Copyright (c) 2013 Angie Lal. All rights reserved.
//

#import "DOCNewTaskViewController.h"
#import "DOCPatientsViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "DOCPatient.h"
#import "DOCAccount.h"
#import "DOCTask.h"

@interface DOCNewTaskViewController () <UITextFieldDelegate, UITextViewDelegate, DOCPatientsViewControllerDelegate>

@property (strong, nonatomic) DOCPatient *patient;
@property (strong, nonatomic) IBOutlet UITextView *description;
@property (strong, nonatomic) IBOutlet UITextField *patientName;

@end

@implementation DOCNewTaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"New Task";
    self.description.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.description.layer.borderWidth = 1.0f;

	// Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destinationVC = [segue destinationViewController];
    if ([destinationVC isKindOfClass:[DOCPatientsViewController class]]) {
        [(DOCPatientsViewController *)destinationVC setDelegate:self];
    }
}

#pragma mark - UIResponder

- (IBAction)willCreateTask:(UIBarButtonItem *)createButton
{
    //create task via post and dismiss
    createButton.enabled = NO;
    [[AFHTTPRequestOperationManager manager] POST:API_URL(@"/tasks/create")
                                       parameters:@{
                                                    @"description": self.description.text,
                                                    @"patient_id": self.patient.objectId,
                                                    @"provider_id": [[[DOCAccount account] currentProvider] objectId]
                                                    }
                                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                              DOCTask *task = [[DOCTask alloc] initWithJson:responseObject[@"task"]];
                                              [[NSNotificationCenter defaultCenter] postNotificationName:@"ProviderDidCreateTaskNotification"
                                                                                                  object:self
                                                                                                userInfo:@{@"task" : task}];
                                              [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              createButton.enabled = YES;
                                              HUDWithErrorInView(self.view, @"Error creating task.");
                                          }];
}

- (IBAction)willCancel:(UIBarButtonItem *)cancelButton
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self performSegueWithIdentifier:@"DOCSelectPatientSegue" sender:self];
    return NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"string: %@", text);

    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark - DOCPatientsViewControllerDelegate

- (void)didSelectPatient:(DOCPatient *)patient
{
    self.patient = patient;
    self.patientName.text = self.patient.name;
}

@end
