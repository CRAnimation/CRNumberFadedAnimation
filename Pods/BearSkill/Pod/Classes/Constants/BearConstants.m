//
//  BearConstants.m
//  Bear
//
//  Created by Bear on 30/12/24.
//  Copyright © 2015年 Bear. All rights reserved.
//

#import "BearConstants.h"

@implementation BearConstants

//  获取当前时间，日期
+ (NSString *)getCurrentTimeStr
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    
    return dateString;
}

//  dict取值并判断是否为空
+ (id)setDataWithDict:(NSDictionary *)dict keyStr:(NSString *)keyStr
{
    if (nil != [dict objectForKey:keyStr] && ![[dict objectForKey:keyStr] isEqual:[NSNull null]]) {
        return [dict objectForKey:keyStr];
    }
    
    return nil;
}

//  dict取值并判断是否为空,string类型专用
+ (NSString *)setStringWithDict:(NSDictionary *)dict keyStr:(NSString *)keyStr
{
    if (nil != [dict objectForKey:keyStr] && ![[dict objectForKey:keyStr] isEqual:[NSNull null]]) {
        return [NSString stringWithFormat:@"%@", [dict objectForKey:keyStr]];
    }
    
    return nil;
}

//  防止字符串为<null>
+ (NSString *)avoidStringCrash:(id)string
{
    if (string && string != nil) {
        NSString *tempStr = [NSString stringWithFormat:@"%@", string];
        if ([tempStr isEqualToString:@"<null>"]) {
            return @"";
        }
        return tempStr;
    }
    
    return @"";
}

//  判断字符串是否为空
+ (BOOL)judgeStringExist:(id)string
{
    if (string && string != nil) {
        if ([string isKindOfClass:[NSString class]]) {
            if ([string isEqualToString:@"<null>"]) {
                return NO;
            }
        }
        
        NSString *tempStr = [NSString stringWithFormat:@"%@", string];
        if ([tempStr length] > 0) {
            return YES;
        }
    }
    
    return NO;
}

//  判断数组里的字符串是否都存在
+ (BOOL)judgeStringExistFromArray:(NSArray *)array
{
    if (!array || [array count] == 0) {
        return NO;
    }
    
    for (id str in array) {
        if (![self judgeStringExist:str]) {
            return NO;
        }
    }
    
    return YES;
}

//  判断dict中是否包含某字段
+ (BOOL)judgeDictHaveStr:(NSString *)keyStr dict:(NSDictionary *)dict
{
    if ([[dict allKeys]containsObject:keyStr]&&![[dict objectForKey:keyStr] isEqual:[NSNull null]]&&[dict objectForKey:keyStr])
    {
        return YES;
    }
    
    return NO;
}

//  从URL获取图片
+ (UIImage *)getImageFromURL:(NSString *)imageURL
{
    if ([imageURL rangeOfString:@"http://"].location != NSNotFound || [imageURL rangeOfString:@"https://"].location != NSNotFound) {
        __block UIImage *image = [[UIImage alloc] init];
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
        });
        return image;
    }
    
    return nil;
}

//  修改iamge尺寸
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(newsize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//  验证姓名
+ (BOOL)validateNameString:(NSString *)nameStr
{
    if ([nameStr length] > 0 && [nameStr length] < 10) {
        //數字條件
        NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
        
        //符合數字條件的有幾個字元
        NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:nameStr
                                                                           options:NSMatchingReportProgress
                                                                             range:NSMakeRange(0, nameStr.length)];
        
        if (tNumMatchCount == 0) {
            return YES;
        }
    }
    
    return NO;
}

//  验证手机号码
+ (BOOL)validatePhoneString:(NSString *)phoneStr
{
    if ([phoneStr length] == 11) {
        //數字條件
        NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
        //符合數字條件的有幾個字元
        NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:phoneStr
                                                                           options:NSMatchingReportProgress
                                                                             range:NSMakeRange(0, phoneStr.length)];
        
        if (tNumMatchCount == 11) {
            return YES;
        }
    }
    
    return NO;
}

/**
 *  Block Demo
 */
+ (void)requestClearMessage:(NSNumber *)notificationId success:(void (^) ())success failure:(void (^) ())failure
{
    
    if (success) {
        success();
    }

    if (failure) {
        failure();
    }
}

//  延时block
+ (void)delayAfter:(CGFloat)delayTime dealBlock:(void (^)())dealBlock
{
    dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime *NSEC_PER_SEC));
    dispatch_after(timer, dispatch_get_main_queue(), ^{
        
        if (dealBlock) {
            dealBlock();
        }
    });
}

@end




