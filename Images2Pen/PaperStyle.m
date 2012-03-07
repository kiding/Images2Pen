#import "PaperStyle.h"

@implementation PaperStyle

- (id) initWithCoder: (NSCoder *) coder
{
    self = [super init];
    if(self)
    {
        paperUUID = [[coder decodeObjectForKey:@"paperUUID"] copy]; // nil
        
        style = [coder decodeIntForKey:@"style"]; // 1
    }
    return self;
}

- (id) init
{
    self = [super init];
    if(self) {
        paperUUID = nil;
        
        style = 1;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:paperUUID forKey:@"paperUUID"];
    
    [coder encodeInt:style forKey:@"style"];
}

- (void) dealloc
{
    if(paperUUID)
        [paperUUID release];
    
    [super dealloc];
}

@end
