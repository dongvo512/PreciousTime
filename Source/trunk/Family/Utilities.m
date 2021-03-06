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
    NSString *idString = [name lowercaseString];
    [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    idString = [idString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return idString;
}
+(NSString *) idWithDate
{
    NSDate *currDate = [NSDate date];
    int timeInterval = [currDate timeIntervalSinceReferenceDate];
    return [NSString stringWithFormat:@"%d",timeInterval];
    
}

+(void)animationSlideY:(UIView *)viewCurrent OriginY:(float) y
{
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frameViewDatePicker = viewCurrent.frame;
        frameViewDatePicker.origin.y = y;
        viewCurrent.frame = frameViewDatePicker;
    }completion:^(BOOL finished){}];
    
    [UIView commitAnimations];
}
+(NSString *) getPathOfDocument
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
+(void)scaleScrollViewContent:(float) height scrollViewCurrent:(UIScrollView *)scrollViewCur
{
    CGRect frameScrollView = scrollViewCur.frame;
    frameScrollView.size.height = height;
    scrollViewCur.frame = frameScrollView;
}

+(void)saveCurrentUserNameToUserDefault:(NSString*)idMember{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:idMember forKey:@"idMember"];
    [defaults synchronize];
}
+(NSString*)getCurrentUserNameFromUserDefault{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *idMember = [defaults objectForKey:@"idMember"];
    return idMember;
}
+(NSString *) getDateBefore:(int) rangeDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [NSDateComponents new];
    comps.day = rangeDay;
    NSDate *sevenDays = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringBeforeDate = [formatter stringFromDate:sevenDays];
    return stringBeforeDate;
    
}
+(NSString *)convertMMddyyyyToddMMyyyy:(NSString *) stringDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *dateCurent = [formatter dateFromString:stringDate];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    return [formatter stringFromDate:dateCurent];
}
+(NSString *)convertddMMyyyyToMMddyyyy:(NSString *) stringDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *dateCurent = [formatter dateFromString:stringDate];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    return [formatter stringFromDate:dateCurent];
}
+(NSString *)getYear:(NSDate *) date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    NSArray *arrDate = [stringFromDate componentsSeparatedByString:@"/"];
    
    return [arrDate objectAtIndex:2];
}
+(NSString *) getUnitType:(int) unitType
{
    NSString *strUnittype = nil;
    switch (unitType) {
        case 0:
            strUnittype = @"Second";
            break;
        case 1:
            strUnittype = @"Minute";
            break;
        case 2:
            strUnittype = @"Hour";
            break;
        default:
            break;
    }
    return strUnittype;
}
+(NSString *)getStringCurrentWithDateMMddyyyy
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    return stringFromDate;
}
+(NSString *)getStringBeforeDateOneDay
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    NSArray *arrDate = [stringFromDate componentsSeparatedByString:@"/"];
    int numbeforDate = [[arrDate objectAtIndex:1] intValue] -1;
 
    NSString *stringBeforeOneDay = [NSString stringWithFormat:@"%@/%d/%@",[arrDate objectAtIndex:0],numbeforDate,[arrDate objectAtIndex:2]];
    return stringBeforeOneDay;
}
+(void) setBackGroundForViewWithVersion:(UIView *) viewCurr
{
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7)
        [viewCurr setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_320x560@2x.png"]]];
    else
        [viewCurr setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_320x480@2x.png"]]];

}
+(NSString *)convertNSmutableToJsonObjectWithKey:(NSMutableArray *)arrCurr keyName:(NSString *)key
{
    //NSArray *keys = [NSArray arrayWithObjects:key,nil];
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObject:arrCurr forKey:key];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = nil;
    if (!jsonData) {
        NSLog(@"eror ");
        return nil;
    } else {
        
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    return jsonString;
}
@end
