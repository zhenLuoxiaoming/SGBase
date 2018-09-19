//
//  SGBaseNetTool.h
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
/*! 定义请求成功的block */
typedef void( ^ XMResponseSuccess)(id responseObject);
/*! 定义请求失败的block */
typedef void( ^ XMResponseFail)(id error);
/*! 定义下载进度block */
typedef void( ^ XMDownloadProgress)(int64_t bytesProgress,
                                    int64_t totalBytesProgress);
/*! 定义上传进度block */
typedef void( ^ XMUploadProgress)(int64_t bytesProgress,
                                  int64_t totalBytesProgress);

@interface SGBaseNetTool : NSObject

+ (AFHTTPSessionManager *)shareAFManager;

/**
 *  GET请求
 *
 */
+ (id)GET_UrlString:(NSString *)urlString
         parameters:(NSDictionary *)params
            complete:(void (^)(id responseObject, NSString *message, NSInteger success))complete;
/**
 *  POST请求
 */
+ (id)POST_UrlString:(NSString *)url
          parameters:(NSDictionary *)params
             complete:(void (^)(id responseObject, NSString *message, NSInteger success))complete;

/**
 *  PUT请求
 */
+ (id)PUT_UrlString:(NSString *)url
        parameters:(NSDictionary *)params
           complete:(void (^)(id responseObject, NSString *message, NSInteger success))complete;

/**
 *  Delete请求
 */
+ (id)Delete_UrlString:(NSString *)url
            parameters:(NSDictionary *)params
              complete:(void (^)(id responseObject, NSString *message, NSInteger success))complete;

/**
 *  请求参数放body里post请求
 */
+(id)PostParametersInBodyWithUrl:(NSString *)url
                           param:(NSDictionary *)param
                            body:(id)body
                        complete:(void (^)(id, NSString *, NSInteger))complete;

/**
 *  请求参数放body里put请求
 */
+(id)PutParametersInBodyWithUrl:(NSString *)url
                          param:(NSDictionary *)param
                           body:(id)body
                       complete:(void (^)(id, NSString *, NSInteger))complete;

/**
 * 图片上传（多张）
 */
+(NSURLSessionTask *)startMultiPartUploadTaskWithURL:(NSString *)url
                                         imagesArray:(NSArray *)images
                                   parameterOfimages:(NSString *)parameter
                                      parametersDict:(NSDictionary *)parameters
                                    compressionRatio:(float)ratio
                                        succeedBlock:(void (^)(id task, id responseObject))succeedBlock
                                         failedBlock:(void (^)(id task, NSError *))failedBlock
                                 uploadProgressBlock:(void (^)(float percent, long long totalBytesWritten, long long totalBytesExpectedToWrite))uploadProgressBlock;

/**
 * 取消请求
 */
+ (void)cancelNetwork;
@end
