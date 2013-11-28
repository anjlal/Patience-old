//
//  DOCNewMessageViewController.m
//  Patience
//
//  Created by Angie Lal on 11/27/13.
//  Copyright (c) 2013 Angie Lal. All rights reserved.
//

#import "DOCNewMessageViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "DOCAccount.h"

@interface DOCNewMessageViewController ()

@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DOCNewMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"New Message";
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth = 1.0f;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIResponder

- (IBAction)willSendMessage:(UIBarButtonItem *)sendButton
{
    //send message then dismiss after sending
    sendButton.enabled = NO;
    [[AFHTTPRequestOperationManager manager] POST:[NSString stringWithFormat:API_URL(@"/patients/%d/message"), [self.patient.objectId intValue]]
                                       parameters:@{
                                                    @"message" : self.textView.text,
                                                    @"provider_id" : [[[DOCAccount account] currentProvider] objectId]
                                                   }
                                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                              [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              sendButton.enabled = YES;
                                              HUDWithErrorInView(self.view, @"Error sending message.");
                                          }];
}

- (IBAction)willCancel:(UIBarButtonItem *)cancelButton
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
