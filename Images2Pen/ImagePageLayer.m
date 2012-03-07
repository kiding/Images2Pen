#import "ImagePageLayer.h"

@implementation ImagePageLayer

@synthesize resourceId;

- (id) initWithCoder: (NSCoder *) coder
{
    self = [super init];
    if(self) {
        frameType = [coder decodeIntForKey:@"frameType"];
        
        imageFrame = [[coder decodeObjectForKey:@"imageFrame"] retain];
        naturalImageSize = [[coder decodeObjectForKey:@"naturalImageSize"] retain];
        resourceId = [[coder decodeObjectForKey:@"resourceId"] retain];
        size = [[coder decodeObjectForKey:@"size"] retain];
        uuid = [[coder decodeObjectForKey:@"uuid"] retain];
    }
    return self;
}

- (id) initWithImageSize: (NSSize) imageSize
{
    self = [super init];
    if(self) {
        // Process a suitable imageSize.
        NSRect frame;
        if (imageSize.width > imageSize.height) {
            CGFloat width = 718;
            frame.size.width = width;
            frame.size.height = width * imageSize.height / imageSize.width;
        } else {
            CGFloat height = 865;
            frame.size.height = height;
            frame.size.width = height * imageSize.width / imageSize.height;
        }
        frame.origin.x = 0;
        frame.origin.y = 865 - frame.size.height;
        
        frameType = 1;
        
        imageFrame = [[NSMutableString alloc] initWithFormat:@"{{%d, %d}, {%d, %d}}", 
                      (int)frame.origin.x, (int)frame.origin.y, (int)frame.size.width, (int)frame.size.height];
        naturalImageSize = [[NSMutableString alloc] initWithFormat:@"{%d, %d}", (int)frame.size.width, (int)frame.size.height];        
        resourceId = [[NSMutableString alloc] init];
        size = [[NSMutableString alloc] initWithFormat:@"{%d, %d}", frame.size.width, frame.size.height];        
        uuid = [[NSMutableString alloc] initWithFormat:@"%d-%d-%d", (unsigned int)time(NULL), (unsigned int)self, (unsigned int)time(NULL)];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInt:frameType forKey:@"frameType"];
    
    [coder encodeObject:imageFrame forKey:@"imageFrame"];
    [coder encodeObject:naturalImageSize forKey:@"naturalImageSize"];
    [coder encodeObject:resourceId forKey:@"resourceId"];
    [coder encodeObject:size forKey:@"size"];
    [coder encodeObject:uuid forKey:@"uuid"];
}

- (void) dealloc
{
    [imageFrame release];
    [naturalImageSize release];
    [resourceId release];
    [size release];
    [uuid release];
    
    [super dealloc];
}

@end
