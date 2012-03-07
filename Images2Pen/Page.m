#import "Page.h"

@implementation Page

@synthesize name, pageLayers;

- (id) initWithCoder: (NSCoder *) coder
{
    self = [super init];
    if(self) {
        blankDate = [coder decodeObjectForKey:@"blankDate"];
        
        fixedUpNaNs = [coder decodeBoolForKey:@"fixedUpNaNs"];
        
        name = [coder decodeObjectForKey:@"name"];
        
        pageLayers = [coder decodeObjectForKey:@"pageLayers"]; // {PageLayer}
        
        size = [coder decodeObjectForKey:@"size"];
        
        version = [coder decodeIntForKey:@"version"];
    }
    return self;
}

- (id) init
{
    self = [super init];
    if(self) {
        blankDate = [[NSDate date] retain];
        
        fixedUpNaNs = YES;
        
        name = [[NSMutableString alloc] initWithFormat:@"%d-%d-%d", (unsigned int)self, (unsigned int)time(NULL), (unsigned int)self];
        pageLayers = [[NSMutableArray alloc] init];
        size = [[NSMutableString alloc] initWithString:@"{718, 865}"];
        
        version = 2;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:blankDate forKey:@"blankDate"];
    
    [coder encodeBool:fixedUpNaNs forKey:@"fixedUpNaNs"];
    
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:pageLayers forKey:@"pageLayers"];
    [coder encodeObject:size forKey:@"size"];
    
    [coder encodeInt:version forKey:@"version"];    
}

- (void)dealloc
{
    [blankDate release];
    
    [name release];
    [pageLayers release];
    [size release];
    
    [super dealloc];
}

@end
