//
//  NSObject+ModelToDict.h
//  XYKit
//
//  Created by Xiao Yuen on 2020/1/6.
//  Copyright © 2020 Xiao Yuen. All rights reserved.
//  model转Dict，用于一些新增，编辑界面
//  ps：后台不支持model转json传参的方式的解决方案
//  比如一个复杂界面里model有30个属性，就要传个元素为30个key/value的字典，十分坑爹

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ModelToDict)

/**
 model转字典
 
 @param model model
 @return 字典
 */
+ (NSDictionary *)dictFromModel:(id)model;

@end

NS_ASSUME_NONNULL_END
