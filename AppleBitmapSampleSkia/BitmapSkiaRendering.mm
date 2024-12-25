//
//  BitmapSkiaRendering.mm
//  AppleBitmapSampleSkia
//
//  Created by m3 on 2024/12/26.
//

#import "BitmapSkiaRendering.h"
#include "include/core/SkCanvas.h"
#include "include/core/SkPaint.h"
#include "include/core/SkSurface.h"
#include "include/core/SkRect.h"
#include "include/core/SkImage.h"
#include "include/core/SkData.h"
#include "include/core/SkStream.h"
#include "include/core/SkTypeface.h"
#include "include/core/SkFont.h"
#include "include/core/SkBitmap.h"
#include "include/encode/SkEncoder.h"
#include "include/encode/SkPngEncoder.h"
#include "include/core/SkStream.h"
#import <UIKit/UIKit.h>

@implementation BitmapSkiaRendering

+ (UIImage*) toUIImage {
    SkBitmap bitmap;
    bitmap.allocN32Pixels(800, 600);  // 800x600 image
    size_t width = bitmap.width();
    size_t height = bitmap.height();
    
    // Create a SkCanvas backed by the bitmap
    SkCanvas canvas(bitmap);
    
    SkPaint paint;
    paint.setAntiAlias(true);
    paint.setColor(SK_ColorBLACK);

    sk_sp<SkTypeface> emojiface = SkTypeface::MakeFromName("Apple Color Emoji", SkFontStyle());
    SkFont emojifont = SkFont(emojiface, 80);
    SkGlyphID glyphid = 1275;
    SkPoint point = SkPoint::Make(0, 0);
    canvas.drawGlyphs(1, &glyphid, &point, {static_cast<SkScalar>(0 + arc4random_uniform(74)), static_cast<SkScalar>(0 + arc4random_uniform(400))}, emojifont, paint);
    
    size_t bytesPerRow = bitmap.rowBytes();

    // Create a CGDataProvider from SkBitmap pixel data
    CFDataRef data = CFDataCreate(NULL, (const UInt8*)bitmap.getPixels(), height * bytesPerRow);
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(data);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast;  // Assuming RGBA format
    CGImageRef cgImage = CGImageCreate(width, height, 8, 32, bytesPerRow, colorSpace, bitmapInfo, provider, NULL, NO, kCGRenderingIntentDefault);


    // Convert CGImage to UIImage
    UIImage *image = [UIImage imageWithCGImage:cgImage];

    // Clean up
    CFRelease(data);
    CGImageRelease(cgImage);

    return image;
}

@end
