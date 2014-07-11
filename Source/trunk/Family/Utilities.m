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
=======
+(void)animationSlideY:(UIView *)viewCurrent OriginY:(float) y
>>>>>>> 968bc4ade76c768557ab9a9f0d161a386dc45a59
{
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frameViewDatePicker = viewCurrent.frame;
        frameViewDatePicker.origin.y = y;
        viewCurrent.frame = frameViewDatePicker;
    }completion:^(BOOL finished){}];
    
    [UIView commitAnimations];
}
+(void)scaleScrollViewContent:(float) height scrollViewCurrent:(UIScrollView *)scrollViewCur
{
    CGRect frameScrollView = scrollViewCur.frame;
    frameScrollView.size.height = height;
    scrollViewCur.frame = frameScrollView;
}
 */
@end
