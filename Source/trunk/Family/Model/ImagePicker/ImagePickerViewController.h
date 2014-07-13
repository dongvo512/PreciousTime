//
//  ImagePickerViewController.h
//  Family
//
//  Created by Admin on 7/11/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePickerViewController : UIImagePickerController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (retain, nonatomic) UIButton *btnCurrent;
- (void)takeAPickture:(UIViewController *)vcCurrent;
-(Boolean) isCheckCamrera;
-(void)cameraRoll:(UIViewController *)vcCurrent;
@property (nonatomic, retain) NSString *nameImageChosenCurr;
@end
