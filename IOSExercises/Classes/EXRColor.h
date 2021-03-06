//
//  ColorOption.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/24/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EXRColor : NSObject

@property (strong, readwrite, nonatomic) NSString *colorName;

+ (instancetype)colorNamed:(NSString *)aColorName;

@end

NS_ASSUME_NONNULL_END
