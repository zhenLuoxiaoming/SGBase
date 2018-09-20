//
//  SGBaseNetTool.m
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "SGBaseNetTool.h"
#import "SGBaseNetConfig.h"
#import "SGBaseMacro.h"

static NSMutableArray *tasks;

@implementation SGBaseNetTool
+ (void)cancelNetwork{
    [[[self shareAFManager] operationQueue] cancelAllOperations];
}

+ (AFHTTPSessionManager *)shareAFManager{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        /*! 设置请求超时时间 */
        manager.requestSerializer  = [AFHTTPRequestSerializer serializer];// 请求
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
        manager.requestSerializer.timeoutInterval = 10;
        /*! 设置响应数据的基本了类型 */
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", nil];
        /*! 设置相应的缓存策略 */
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        // https  参数配置
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        manager.securityPolicy = securityPolicy;
    });
    return manager;
}

+ (NSMutableArray *)tasks{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}

+ (id)GET_UrlString:(NSString *)urlString parameters:(NSDictionary *)params complete:(void (^)(id, NSString *, NSInteger))complete {
    if (urlString == nil){
        return nil;
    }
    /*! 检查地址中是否有中文 */
    NSString * URLString = [NSURL URLWithString:urlString] ? urlString : [self strUTF8Encoding:urlString];
    NSURLSessionTask *sessionTask = nil;
    sessionTask = [[self shareAFManager] GET:URLString parameters:params  progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = responseObject;
        NSDictionary *responseObjectDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([responseObjectDict[@"code"] intValue] == [SGBaseNetConfig shareInstance].requestSuccessStatusCode) {
            complete(responseObjectDict, nil, 0);
        }else{
            complete(nil, responseObjectDict[@"msg"], [responseObjectDict[@"code"] integerValue]);
        }
        [[self tasks] removeObject:sessionTask];
        SGLog(@"《== URL:%@ PARAMETRS:%@ \nRESPONSE:%@ ==》", urlString, params, responseObjectDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SGLog(@"\nURL:%@ PARAMETRS:%@ \nERROR:%@",urlString, params, error);
        complete(error, [SGBaseNetConfig shareInstance].requestErrorString?@"请求失败":[SGBaseNetConfig shareInstance].requestErrorString, 1);
        [[self tasks] removeObject:sessionTask];
    }];
    if (sessionTask){
        [[self tasks] addObject:sessionTask];
    }
    return sessionTask;
}

+ (NSString *)strUTF8Encoding:(NSString *)str{
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
}

+ (id)POST_UrlString:(NSString *)url parameters:(NSDictionary *)params complete:(void (^)(id, NSString *, NSInteger))complete {
    if (url == nil){
        return nil;
    }
    /*! 检查地址中是否有中文 */
    NSString *URLString = [NSURL URLWithString:url] ? url : [self strUTF8Encoding:url];
    NSURLSessionTask *sessionTask = nil;
    sessionTask = [[self shareAFManager] POST:URLString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = responseObject;
        NSDictionary *responseObjectDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([responseObjectDict[@"code"] intValue] == [SGBaseNetConfig shareInstance].requestSuccessStatusCode) {
            complete(responseObjectDict, nil, 0);
        }else{
            complete(nil, responseObjectDict[@"msg"], [responseObjectDict[@"code"] integerValue]);
        }
        [[self tasks] removeObject:sessionTask];
        SGLog(@"《== URL:%@ PARAMETRS:%@ \nRESPONSE:%@ ==》", url, params, responseObjectDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SGLog(@"《== URL:%@ PARAMETRS:%@ \nRESPONSE:%@ ==》", url, params, error);
        complete(error, [SGBaseNetConfig shareInstance].requestErrorString?@"请求失败":[SGBaseNetConfig shareInstance].requestErrorString, 1);
        [[self tasks] removeObject:sessionTask];
    }];
    if (sessionTask){
        [[self tasks] addObject:sessionTask];
    }
    return sessionTask;
}

+ (id)PUT_UrlString:(NSString *)url parameters:(NSDictionary *)params complete:(void (^)(id, NSString *, NSInteger))complete {
    if (url == nil){
        return nil;
    }
    /*! 检查地址中是否有中文 */
    NSString *URLString = [NSURL URLWithString:url] ? url : [self strUTF8Encoding:url];
    NSURLSessionTask *sessionTask = nil;
    sessionTask = [[self shareAFManager] PUT:URLString parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = responseObject;
        NSDictionary *responseObjectDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([responseObjectDict[@"code"] intValue] == [SGBaseNetConfig shareInstance].requestSuccessStatusCode) {
            complete(responseObjectDict, nil, 0);
        }else{
            complete(nil, responseObjectDict[@"msg"], [responseObjectDict[@"code"] integerValue]);
        }
        [[self tasks] removeObject:sessionTask];
        SGLog(@"《== URL:%@ PARAMETRS:%@ \nRESPONSE:%@ ==》", url, params, responseObjectDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SGLog(@"《== URL:%@ PARAMETRS:%@ \nRESPONSE:%@ ==》", url, params, error);
        complete(error, [SGBaseNetConfig shareInstance].requestErrorString?@"请求失败":[SGBaseNetConfig shareInstance].requestErrorString, 1);
        [[self tasks] removeObject:sessionTask];
    }];
    if (sessionTask){
        [[self tasks] addObject:sessionTask];
    }
    return sessionTask;
}

+ (id)Delete_UrlString:(NSString *)url parameters:(NSDictionary *)params complete:(void (^)(id, NSString *, NSInteger))complete{
    if (url == nil){
        return nil;
    }
    /*! 检查地址中是否有中文 */
    NSString *URLString = [NSURL URLWithString:url] ? url : [self strUTF8Encoding:url];
    NSURLSessionTask *sessionTask = nil;
    sessionTask = [[self shareAFManager] DELETE:URLString parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = responseObject;
        NSDictionary *responseObjectDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([responseObjectDict[@"code"] intValue] == [SGBaseNetConfig shareInstance].requestSuccessStatusCode) {
            complete(responseObjectDict, nil, 0);
        }else{
            complete(nil, responseObjectDict[@"msg"], [responseObjectDict[@"code"] integerValue]);
        }
        [[self tasks] removeObject:sessionTask];
        SGLog(@"《== URL:%@ PARAMETRS:%@ \nRESPONSE:%@ ==》", url, params, responseObjectDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SGLog(@"《== URL:%@ PARAMETRS:%@ \nRESPONSE:%@ ==》", url, params, error);
        complete(error, [SGBaseNetConfig shareInstance].requestErrorString?@"请求失败":[SGBaseNetConfig shareInstance].requestErrorString, 1);
        [[self tasks] removeObject:sessionTask];
    }];
    if (sessionTask){
        [[self tasks] addObject:sessionTask];
    }
    return sessionTask;
}

+(NSURLSessionTask *)startMultiPartUploadTaskWithURL:(NSString *)url
                                         imagesArray:(NSArray *)images
                                   parameterOfimages:(NSString *)parameter
                                      parametersDict:(NSDictionary *)parameters
                                    compressionRatio:(float)ratio
                                        succeedBlock:(void (^)(id task, id responseObject))succeedBlock
                                         failedBlock:(void (^)(id task, NSError *))failedBlock
                                 uploadProgressBlock:(void (^)(float percent, long long totalBytesWritten, long long totalBytesExpectedToWrite))uploadProgressBlock{
    if (images.count == 0) {
        NSLog(@"上传内容没有包含图片");
        return nil;
    }
    for (int i = 0; i < images.count; i++) {
        if (![images[i] isKindOfClass:[UIImage class]]) {
            NSLog(@"images中第%d个元素不是UIImage对象",i+1);
            return nil;
        }
    }

    NSURLSessionTask *task = [[self shareAFManager] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int i = 0;
        //根据当前系统时间生成图片名称
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString = [formatter stringFromDate:date];
        for (UIImage *image in images) {
            i++;
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateString,i];
            NSData *imageData;
            if (ratio > 0.0f && ratio < 1.0f) {
                imageData = UIImageJPEGRepresentation(image, ratio);
            }else{
                imageData = UIImageJPEGRepresentation(image, 1.0f);
            }
            [formData appendPartWithFileData:imageData name:parameter fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        uploadProgressBlock(uploadProgress.fractionCompleted,1,1);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeedBlock(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(task,error);
    }];
    [task resume];
    return task;
}

+(id)PostParametersInBodyWithUrl:(NSString *)url param:(NSDictionary *)param body:(id)body complete:(void (^)(id, NSString *, NSInteger))complete {
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    //如果你不需要将通过body传 那就将参数放入parameters里面
    __block NSString * paramStr = @"";
    [param enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        paramStr = [paramStr stringByAppendingString:@"&"];
        paramStr = [paramStr stringByAppendingString:key];
        paramStr = [paramStr stringByAppendingString:@"="];
        if ([obj isKindOfClass:[NSNumber class]]) {
            paramStr = [paramStr stringByAppendingString:[((NSNumber *)obj) stringValue]];
        } else {
            paramStr = [paramStr stringByAppendingString:obj];
        }
    }];
    if (paramStr.length > 0) {
        paramStr = [paramStr substringFromIndex:1];
        url = [NSString stringWithFormat:@"%@?%@",url,paramStr];
    }
    NSMutableURLRequest *request = [[self shareAFManager].requestSerializer requestWithMethod:@"POST" URLString:url parameters:param error:nil];
    request.timeoutInterval= 10;
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 设置body 在这里将参数放入到body
    SGLog(@"%@",[request allHTTPHeaderFields]);
    
    [request setHTTPBody:data];
    NSURLSessionTask *sessionTask = nil;
    sessionTask = [[self shareAFManager] dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(responseObject!=nil){
            NSData *data = responseObject;
            NSDictionary *responseObjectDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([responseObjectDict[@"code"] intValue] == [SGBaseNetConfig shareInstance].requestSuccessStatusCode) {
                complete(responseObjectDict, nil, 0);
            }else{
                complete(nil, responseObjectDict[@"msg"], [responseObjectDict[@"code"] integerValue]);
            }
            [[self tasks] removeObject:sessionTask];
            SGLog(@"《== URL:%@ PARAMETRS:%@ \nRESPONSE:%@ ==》", url, body, responseObjectDict);
        } else {
            SGLog(@"《== URL:%@ PARAMETRS:%@ \nRESPONSE:%@ ==》", url, body, error);
            complete(error, [SGBaseNetConfig shareInstance].requestErrorString?@"请求失败":[SGBaseNetConfig shareInstance].requestErrorString, 1);
            [[self tasks] removeObject:sessionTask];
        }
        [[self tasks] removeObject:sessionTask];
    }];
    if (sessionTask)
    {
        [[self tasks] addObject:sessionTask];
    }
    [sessionTask resume];
    return sessionTask;
}

+(id)PutParametersInBodyWithUrl:(NSString *)url param:(NSDictionary *)param body:(id)body complete:(void (^)(id, NSString *, NSInteger))complete {
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    //如果你不需要将通过body传 那就将参数放入parameters里面
    __block NSString * paramStr = @"";
    [param enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        paramStr = [paramStr stringByAppendingString:@"&"];
        paramStr = [paramStr stringByAppendingString:key];
        paramStr = [paramStr stringByAppendingString:@"="];
        if ([obj isKindOfClass:[NSNumber class]]) {
            paramStr = [paramStr stringByAppendingString:[((NSNumber *)obj) stringValue]];
        } else {
            paramStr = [paramStr stringByAppendingString:obj];
        }
    }];
    if (paramStr.length > 0) {
        paramStr = [paramStr substringFromIndex:1];
        url = [NSString stringWithFormat:@"%@?%@",url,paramStr];
    }
    NSMutableURLRequest *request = [[self shareAFManager].requestSerializer requestWithMethod:@"PUT" URLString:url parameters:param error:nil];
    request.timeoutInterval= 10;
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 设置body 在这里将参数放入到body
    SGLog(@"%@",[request allHTTPHeaderFields]);
    
    [request setHTTPBody:data];
    NSURLSessionTask *sessionTask = nil;
    sessionTask = [[self shareAFManager] dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(responseObject!=nil){
            NSData *data = responseObject;
            NSDictionary *responseObjectDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([responseObjectDict[@"code"] intValue] == [SGBaseNetConfig shareInstance].requestSuccessStatusCode) {
                complete(responseObjectDict, nil, 0);
            }else{
                complete(nil, responseObjectDict[@"msg"], [responseObjectDict[@"code"] integerValue]);
            }
            [[self tasks] removeObject:sessionTask];
            SGLog(@"《== URL:%@ PARAMETRS:%@ \nRESPONSE:%@ ==》", url, body, responseObjectDict);
        } else {
            SGLog(@"《== URL:%@ PARAMETRS:%@ \nRESPONSE:%@ ==》", url, body, error);
            complete(error, [SGBaseNetConfig shareInstance].requestErrorString?@"请求失败":[SGBaseNetConfig shareInstance].requestErrorString, 1);
            [[self tasks] removeObject:sessionTask];
        }
        [[self tasks] removeObject:sessionTask];
    }];
    if (sessionTask)
    {
        [[self tasks] addObject:sessionTask];
    }
    [sessionTask resume];
    return sessionTask;
}

@end
