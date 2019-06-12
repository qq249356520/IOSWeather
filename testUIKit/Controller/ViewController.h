//
//  ViewController.h
//  testUIKit
//
//  Created by serriezhang on 2019/5/29.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WeatherViewController.h"
#import "CityViewController.h"
#import "../otherUtils/DBOperating.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic, strong) WeatherViewController* weatherViewController;

@property(nonatomic, strong) NSMutableArray* provinceArr;

@end

