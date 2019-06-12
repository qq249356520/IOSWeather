//
//  ProvinceModel.h
//  testUIKit
//
//  Created by serriezhang on 2019/6/10.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProvinceModel : NSObject

@property(nonatomic, copy) NSString* province;
@property(nonatomic, assign) NSInteger provinceID;
@property(nonatomic, assign) NSInteger pid;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)testWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
