#import <Foundation/Foundation.h>
#import "PageLayer.h"

@interface ImagePageLayer : PageLayer
{
    int frameType;
    
    NSMutableString *imageFrame;
    NSMutableString *naturalImageSize;
    NSMutableString *resourceId;
    NSMutableString *size;
    NSMutableString *uuid;    
}

@property (readonly) NSMutableString *resourceId;

- (id) initWithCoder: (NSCoder *) coder;

- (id) initWithImageSize: (NSSize) imageSize;

- (void)encodeWithCoder:(NSCoder *)coder;

@end
