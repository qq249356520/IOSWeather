//
//  CityViewController.h
//  testUIKit
//
//  Created by serriezhang on 2019/6/4.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewController.h"
#import "../otherUtils/DBOperating.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) WeatherViewController* weatherViewController;

@property(nonatomic, strong) NSString* provinceName;
@property(nonatomic, assign) NSInteger provinceID;


@end

NS_ASSUME_NONNULL_END
