//
//  CityModel.h
//  testUIKit
//
//  Created by serriezhang on 2019/6/10.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityModel : NSObject

@property(nonatomic, assign) NSInteger cid;
@property(nonatomic, assign) NSInteger cityID;
@property(nonatomic, copy) NSMutableString* city;
@property(nonatomic, assign) NSInteger fatherID;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)testWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
