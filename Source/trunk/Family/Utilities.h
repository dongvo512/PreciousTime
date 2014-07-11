//
//  Utilities.h
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject
+(CGRect) getScreenSize;
+(void)animationSlideY:(UIView *)viewCurrent OriginY:(float) y;
+(void)scaleScrollViewContent:(float) height scrollViewCurrent:(UIScrollView *)scrollViewCur;
@end
