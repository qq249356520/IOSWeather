//
//  testAFNetrowk.m
//  testUIKit
//
//  Created by serriezhang on 2019/6/4.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
void downloadTasktest(){
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

void uploadTaskTest(){
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}

//void requestTaskTest1(){
//    //NSString *string = [NSString stringWithFormat:@"%@%@", Url_pat1, Url_part2];
//    //string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString* urlCity = @"成都";
//    NSString* urlString = [NSString stringWithFormat:@"https://www.apiopen.top/weatherApi?city=%@", urlCity];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"123123214524123");
//        NSLog(@"请求成功，转换为字典------ %@", dict);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败----%@", error);
//        //可以再次添加后续操作
//    }];
//
//    NSLog(@"请求完成");
//}
//
//void testcmd(){
//    NSLog(@"testttttttt");
//}
//
//int main2(){
//    
//    @autoreleasepool {
//        NSLog(@"test");
//        //requestTaskTest();
//        testcmd();
//        NSLog(@"finish");
//    }
//    
//    return 0;
//}
