//
//  CDTools.h
//  CDBLESupToolProject
//
//  Created by bbigcd on 16/10/28.
//  Copyright © 2016年 chendi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CDTools : NSObject

/**
 *  NSData转换成HexString--16进制字符串
 */
+ (NSString *)convertDataToHexString:(NSData *)data;

/**
 *  HexString--16进制字符串转换成NSData
 */
+ (NSData *)convertHexStringToData:(NSString *)string;

/**
 *  section点击按钮工厂方法
 *
 *  @param frame    坐标
 *  @param title    名称
 *  @param target   点击的代理者
 *  @param selector 点击触发方法
 *
 *  @return 返回一个button, 减少ViewController中代码, 避免重复代码
 */
+ (UIButton *)initWithCustomButton:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)selector;

/**
 *  documents路径
 *
 *  @return documents路径
 */
+ (NSString *)documentsPath;

/**
 *  获取沙盒路径的所有文件
 *
 *  @return 所有文件名的数组
 */
+ (NSArray *)getAllFileNames;

/**
 *  删除沙盒路径的所有文件
 */
+ (void)removeAllFile;

/**
 *  删除沙盒路径的指定文件名文件
 */
+ (void)removeWithFileName:(NSString *)fileName;

/**
 *  将字符串写入文件
 *
 *  @param string 需要写入的内容
 */
+ (void)writefile:(NSString *)string fileName:(NSString *)fileName;


@end
