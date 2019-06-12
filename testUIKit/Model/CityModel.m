//
//  CityModel.m
//  testUIKit
//
//  Created by serriezhang on 2019/6/10.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)testWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
