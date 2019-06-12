//
//  DBOpeating.m
//  testUIKit
//
//  Created by serriezhang on 2019/6/11.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import "DBOperating.h"

@interface DBOperating ()

@property(nonatomic,strong)OHMySQLQueryContext *queryContext;

@end

@implementation DBOperating

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static DBOperating *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[DBOperating alloc]init];
    });
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        //[self initDBContent];
    }
    return self;
}

- (OHMySQLQueryContext*)dbConnection{
    
    if (self.queryContext) {
        return self.queryContext;
    }
    
    //初始化用户
    OHMySQLUser *user = [[OHMySQLUser alloc] initWithUserName:@"root"
                                                     password:@"wolegecao144"
                                                   serverName:@"47.93.23.130"
                                                       dbName:@"pncinchina"
                                                         port:3306
                                                       socket:nil];
    //OHMySQL协调器
    OHMySQLStoreCoordinator *coordinator = [[OHMySQLStoreCoordinator alloc] initWithUser:user];
    [coordinator connect];
    //连接后保存协调器到上下文 不用每次操作数据库都重新连接
    OHMySQLQueryContext *queryContext = [OHMySQLQueryContext new];
    queryContext.storeCoordinator = coordinator;
    
    self.queryContext = queryContext;
    
    return queryContext;
}

- (NSMutableArray*)findProvinceFromProvince{
    OHMySQLQueryContext *queryContext = [self dbConnection];
    
    OHMySQLQueryRequest *query = [OHMySQLQueryRequestFactory SELECT:@"province" condition:nil];
    NSError *error = nil;
    NSArray *tasks = [queryContext executeQueryRequestAndFetchResult:query error:&error];
    NSMutableArray *arrayModels = [NSMutableArray array];
    if(tasks != nil){
        for(NSDictionary* dict in tasks){
            ProvinceModel* provinceModel = [ProvinceModel testWithDict: dict];
            [arrayModels addObject:provinceModel];
        }
    }
    else{
        NSLog(@"%@", error.description);
    }
    return arrayModels;
}

-(NSMutableArray*)findCityFromCity:(NSInteger) provinceID{
    OHMySQLQueryContext *queryContext = [self dbConnection];
    NSMutableString* selStr = [NSMutableString stringWithFormat:@"fatherID=%ld", provinceID];
    OHMySQLQueryRequest *query = [OHMySQLQueryRequestFactory SELECT:@"city" condition:selStr];
    NSError *error = nil;
    NSArray *tasks = [queryContext executeQueryRequestAndFetchResult:query error:&error];
    //NSLog(@"%d^^^^^^^^^^^^^^^", tasks.count);
    NSMutableArray *arrayModels = [NSMutableArray array];
    if(tasks != nil){
        for(NSDictionary* dict in tasks){
            CityModel* cityModel = [CityModel testWithDict: dict];
            [arrayModels addObject:cityModel];
        }
    }
    else{
        NSLog(@"%@", error.description);
    }
    return arrayModels;
}

@end
