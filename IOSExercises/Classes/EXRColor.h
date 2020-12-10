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
  EXRSupportedColorRed,
  EXRSupportedColorBlue,
  EXRSupportedColorBlack,
  EXRSupportedColorUnsupported
};

@interface EXRColor : NSObject

@property (strong, readwrite, nonatomic) UIColor *uiColor;

@property (strong, readwrite, nonatomic) NSString *colorName;

+ (instancetype)supportedColor:(EXRSupportedColor)aSuppportedColor;

+ (EXRSupportedColor)colorWithName:(NSString *)colorName;

- (int64_t) colorCode;

@end

NS_ASSUME_NONNULL_END
