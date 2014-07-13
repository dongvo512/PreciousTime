//
//  ImagePickerViewController.m
//  Family
//
//  Created by Admin on 7/11/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ImagePickerViewController.h"
#import "Utilities.h"
@interface ImagePickerViewController ()

@end

@implementation ImagePickerViewController
#define NEW_SIZE_IMAGE_HEIGHT 100
#define NEW_SIZE_IMAGE_WIDTH 100
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)takeAPickture:(UIViewController *)vcCurrent
{
    self.delegate = self;
    if([self isCheckCamrera])
    {
    self.allowsEditing = YES;
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [vcCurrent presentViewController:self animated:YES completion:NULL];
    }
        
}

-(void)cameraRoll:(UIViewController *)vcCurrent
{
    self.delegate = self;
    self.allowsEditing = YES;
    self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [vcCurrent presentViewController:self animated:YES completion:NULL];
}
-(Boolean) isCheckCamrera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        return NO;
    }
    else
        return YES;
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    UIImage *imgNewSize = [self reSizeImage:chosenImage scaledToSize:CGSizeMake(NEW_SIZE_IMAGE_WIDTH, NEW_SIZE_IMAGE_HEIGHT)];
    NSData *data = UIImagePNGRepresentation(imgNewSize);
    
    NSDateFormatter* f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString* dateString = [f stringFromDate:[NSDate date]];
    self.nameImageChosenCurr = dateString;
    NSString *documentsDirectory = [Utilities getPathOfDocument];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:dateString];
    
    // Save it into file system
    [data writeToFile:dataPath atomically:YES];
    [self.btnCurrent setImage:imgNewSize forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (UIImage *)reSizeImage:(UIImage *)image scaledToSize:(CGSize)newSize {
  
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
