//
//  CDTools.m
//  CDBLESupToolProject
//
//  Created by bbigcd on 16/10/28.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import "CDTools.h"

@implementation CDTools
//NSData转HexString
+ (NSString *)convertDataToHexString:(NSData *)data{
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}

//16进制字符串转成NSData
+ (NSData *)convertHexStringToData:(NSString *)str{
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:20];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

+ (UIButton *)initWithCustomButton:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)selector{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button.layer setCornerRadius:5];
    [button.layer setMasksToBounds:YES];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.14 green:0.15 blue:0.69 alpha:1.00] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1.00]];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (NSString *)documentsPath{
    NSArray *docArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return docArray[0];
}

+ (NSArray *)getAllFileNames{
    NSString *documentsPath = [CDTools documentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *files = [fileManager subpathsOfDirectoryAtPath:documentsPath error:nil];
    return files;
}

+ (void)removeAllFile{
    NSString *documentsPath = [CDTools documentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *files = [fileManager subpathsOfDirectoryAtPath:documentsPath error:nil];
    for (int i = 0; i < files.count; i ++) {//这里是不是可以直接删除上一级的路径，不需要遍历所有文件
        NSString *path = [documentsPath stringByAppendingPathComponent:files[i]];
        [fileManager removeItemAtPath:path error:nil];
    }
}

+ (void)removeWithFileName:(NSString *)fileName{
    NSString *documentsPath = [CDTools documentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [documentsPath stringByAppendingPathComponent:fileName];
    if (fileName != nil) {//如果fileName的值为空，会删除所有文件
        [fileManager removeItemAtPath:path error:nil];
    }
}

+ (void)writefile:(NSString *)string fileName:(NSString *)fileName{
    // 1.Document路径获取
    NSString *documentsPath = [CDTools documentsPath];
    
    // 2.创建文本的名称
    NSString *fileNameString = nil;
    if (fileName == nil) {
        fileNameString = [NSString stringWithFormat:@"000000.text"];
    }else{
        fileNameString = [NSString stringWithFormat:@"%@.text",fileName];
    }
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileNameString];
    
    // 3.文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:filePath]) //如果不存在
    {
        NSString *str = @"保存返回数据";
        [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    
    // 文件操作
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    // 将节点跳到文件的末尾
    [fileHandle seekToEndOfFile];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    NSString *str = [NSString stringWithFormat:@"\n[%@] %@", [formatter stringFromDate:[NSDate date]], string];
    NSData* stringData  = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // 4.追加写入数据
    [fileHandle writeData:stringData];
    
    // 5.关闭
    [fileHandle closeFile];
}


@end
