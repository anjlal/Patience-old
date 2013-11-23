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
    self.taskID.text = [NSString stringWithFormat: @"%d", [self.task.objectId intValue]];
    [self.patientName setTitle:self.task.patient.name forState:UIControlStateNormal];
    self.taskDescription.text = self.task.issue;

    if(!self.patientPhoto.image){
        self.patientPhoto.image = [UIImage imageNamed:@"lego.jpg"];
    }

    //NSLog(@"The task: %@, %i", self.task, arc4random());

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//- (BOOL)textViewShouldReturn:(UITextView *)theTextField {
//    if (theTextField == self.taskDescription) {
//        [theTextField resignFirstResponder];
//    }
//
//    return YES;
//}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }

    return YES;
}
- (IBAction)willViewPatient:(UIButton *)patientNameButton
{
    NSLog(@"Implement will view patient");

    // Commenting out performSegueWithIdentifier: http://stackoverflow.com/questions/11813091/nested-push-animation-can-result-in-corrupted-navigation-bar-multiple-warning

    /*** The NEW way ***/
    /* In the storyboard world, we don't have to create a Patient VC. We have already
     in our storyboard, dragged on a PatientVC and wired up a transition between the
     patient name button and a patientVC. We gave that segue (transition) a name, 
     'DOCPatientDetailsSegue'. iOS is going to basically do exactly what we did below in
     THE OLD WAY, except, it's not going to set the patient property. iOS doesn't know about
     what data requirements we have. So in THE NEW WAY, since iOS is doing everything with
     regards to instantiating our Patient VC, except the important part, that is wiring up
     the data, we need a place to do that... enter prepareForSegue */

    //[self performSegueWithIdentifier:@"DOCPatientDetailsSegue" sender:self];

    /*** The OLD way ***/

    /* So here is where the user tapped the patient name.
     Normally what would happen is we would say, OK, they want to move to 
     patient details, let's move them over: */

    /* Notice that we're manually creating an instance of our Patient VC,
     and setting the public property 'patient'. We're populating the required
     patient data here ourselves. */

    //DOCPatientViewController *patientVC = [DOCPatientViewController new];
    //patientVC.patient = self.task.patient;

    // our taskVC is in a navigation controller, so we tell our nav controller
    // to push on another VC with animation (the iOS slide that you know and love)

    //[self.navigationController pushViewController:patientVC animated:YES];
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
    /* This gets called by iOS right _before_ a segue occurs. So our Patient VC or
     any other VC hasn't appeared yet. Note, this method is called when ANY segue
     will occur. So if you do two different segues, this will get called in both of those
     different cases. That's why we need to check here what type of class we're seguiing(sp?)
     to. In this case, there is currently only one segue, to the Patient VC. We'll still check
     anyway, in case you add more. */

    if ([[segue destinationViewController] isKindOfClass:[DOCPatientViewController class]]) {

        // you pretty much got it here!

        /* Remember above, in the handler for the patient button being hit, i said iOS was
         going to do all the instantiation and pushing of the VC onto the navigationController
         viewControllers array. Well, this is the in-between phase. iOS has already instantiated
         the Patient VC and passed it to us here, via [segue destinationViewController] - makes sense right? Destination is where we're headed, i.e. the Patient VC. But we haven't
         segued yet. The segue will be that "push" (horizontal slide) animation. We're in _prepare_ for segue. So it hasn't happened yet. Hence, in-between phase. In between instantiation => push. The thing we were doing manually above in  THE OLD WAY. And in THE OLD WAY, what were we doing in between? If you look at the code, we were instantiating => setting the patient property => pushing. So since iOS is now taking care of (1) and (3) automatically. We need to still do (2). And we do it here. */

        /* This is where we set the patient property. We do the cast (DOCPatientViewController *) because the compiler will complain that it doesn't know about a patient property otherwise. Remember, I said above that this method gets called by iOS when ANY segue is happening from this VC. So the destination VC could be something other than Patient VC (hence why we check above in the if statement). But we still need to tell the compiler that this is a Patient VC, so it knows that setting the patient property is OK. */
        [(DOCPatientViewController *)[segue destinationViewController] setPatient:self.task.patient];

//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        DOCTask *task = self.tasks[indexPath.row];
//        ((DOCTaskDetailViewController *)[segue destinationViewController]).task = task;
    }

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
