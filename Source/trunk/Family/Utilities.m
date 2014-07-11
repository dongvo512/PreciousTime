//
//  Utilities.m
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "Utilities.h"

@interface Utilities()
{
   
}
@end
@implementation Utilities

+(CGRect) getScreenSize
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect;
}

+(NSString*)idWithName:(NSString*)name{
    NSString *idString = [name capitalizedString];
    [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    idString = [idString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return idString;
}
/*+(void)takePhoto:(id)sender viewContent:(UIView *)view
{
    
    BlockActionSheet *blockActionSheet = [[BlockActionSheet alloc] initWithTitle:@"Image Option"];
    [blockActionSheet setCancelButtonWithTitle:@"Cancel" block:^{
        NSLog(@"Cancel");
    }];
    [blockActionSheet setDestructiveButtonWithTitle:@"Take a Picture" block:^{
        NSLog(@"Take a Picture");
        [self takeAPickture];
    }];
    [blockActionSheet addButtonWithTitle:@"Camera Roll" block:^{
        NSLog(@"Camera Roll");
        if([self isCheckCamrera])
            [self cameraRoll];
    }];
    [blockActionSheet showInView:view;

}
     - (void)takeAPickture
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
     -(void)cameraRoll
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }*/

@end
