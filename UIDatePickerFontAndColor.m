//
//  UIDatePickerFontAndColor.m
//
//  Created by Grig Uskov on 07/03/2018.
//

#import "UIDatePickerFontAndColor.h"
#import <objc/runtime.h>

@implementation UIDatePickerFontAndColor

static UIColor *_textColor = nil;
static UIFont *_font = nil;

+ (void)setFont:(UIFont *)font textColor:(UIColor *)textColor {
    _textColor = textColor;
    _font = font;
}


+ (void)load {
    [super load];
    Class class = NSClassFromString(@"UIDatePickerContentView");
    if (!!class)
        class_swizzleMethodAndStore(class, @selector(layoutSubviews), (IMP)swizzledLayoutSubviews, (IMP *)&SwizzledLayoutSubviewsIMP);
}


typedef IMP *IMPPointer;
static void (*SwizzledLayoutSubviewsIMP)(id self, SEL _cmd);

static BOOL class_swizzleMethodAndStore(Class class, SEL original, IMP replacement, IMPPointer store) {
    IMP imp = NULL;
    Method method = class_getInstanceMethod(class, original);
    if (method) {
        const char *type = method_getTypeEncoding(method);
        imp = class_replaceMethod(class, original, replacement, type);
        if (!imp) {
            imp = method_getImplementation(method);
        }
    }
    if (imp && store) { *store = imp; }
    return (imp != NULL);
}


static void swizzledLayoutSubviews(UIView *self, SEL _cmd) {
    SwizzledLayoutSubviewsIMP(self, _cmd);
    
    if (!!_font || !!_textColor) {
        UILabel *label = self.subviews.firstObject;
        if ([label isKindOfClass:UILabel.class]) {
            if (!!_font)
                label.font = _font;
            if (!!_textColor)
                label.textColor = _textColor;
        }
    }
}

@end
