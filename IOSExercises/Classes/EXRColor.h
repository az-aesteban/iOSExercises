//
//  ColorOption.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/24/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, EXRSupportedColor) {
  EXRSupportedColorRed = 0,
  EXRSupportedColorBlue,
  EXRSupportedColorBlack
};

@interface EXRColor : NSObject

@property (strong, readwrite, nonatomic) UIColor *uiColor;

@property (strong, readwrite, nonatomic) NSString *colorName;

+ (instancetype)supportedColor:(EXRSupportedColor)aSuppportedColor;

@end

NS_ASSUME_NONNULL_END
