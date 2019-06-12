//
//  DBOpeating.h
//  testUIKit
//
//  Created by serriezhang on 2019/6/11.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OHMySQL.h>

#import "../Model/ProvinceModel.h"
#import "../Model/CityModel.h"
#import "../Controller/ViewController.h"
#import "../Controller/CityViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBOperating : NSObject


-(NSMutableArray*) findProvinceFromProvince;
-(NSMutableArray*) findCityFromCity:(NSInteger) provinceID;

//单例，防止new多个
+(instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
