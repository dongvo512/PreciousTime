//
//  CircleView.h
//  Family
//
//  Created by Admin on 7/6/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"
@interface CircleView : UIView <XYPieChartDelegate, XYPieChartDataSource,UITableViewDataSource,UITableViewDelegate>
-(void) createCircleSlices;
@end
