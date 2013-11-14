//
//  DOCTaskViewController.m
//  Patience
//
//  Created by Angie Lal on 11/12/13.
//  Copyright (c) 2013 Angie Lal. All rights reserved.
//

#import "DOCTaskDetailViewController.h"
#import "DOCPatientViewController.h"

@interface DOCTaskDetailViewController ()

@end

@implementation DOCTaskDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.taskID.text = [NSString stringWithFormat: @"%d", [self.task.tid intValue]];
    [self.patientName setTitle:self.task.name forState:UIControlStateNormal];
    self.taskDescription.text = self.task.issue;

    if(!self.patientPhoto.image){
        self.patientPhoto.image = [UIImage imageNamed:@"placeholder.jpg"];
    }

    NSLog(@"The task: %@, %i", self.task, arc4random());

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)willViewPatient:(UIButton *)patientNameButton
{
    NSLog(@"Implement will view patient");

    // Commenting out performSegueWithIdentifier: http://stackoverflow.com/questions/11813091/nested-push-animation-can-result-in-corrupted-navigation-bar-multiple-warning
    //[self performSegueWithIdentifier:@"DOCPatientDetailsSegue" sender:self];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([[segue destinationViewController] isKindOfClass:[DOCPatientViewController class]]) {

        NSLog(@"awerwerwer will view patient");

//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        DOCTask *task = self.tasks[indexPath.row];
//        ((DOCTaskDetailViewController *)[segue destinationViewController]).task = task;
    }

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
