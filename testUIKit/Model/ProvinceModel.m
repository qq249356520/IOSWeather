//
//  ProvinceModel.m
//  testUIKit
//
//  Created by serriezhang on 2019/6/10.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)testWithDict:(NSDictionary *)dict{
    
    ProvinceModel *model = [[ProvinceModel alloc]initWithDict:dict];
    return model;
}

@end
