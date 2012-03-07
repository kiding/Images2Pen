#import <Foundation/Foundation.h>
#import "ImagePageLayer.h"

@interface Page : NSObject
{
    NSDate *blankDate;
    
    BOOL fixedUpNaNs;
    
    NSMutableString *name;
    NSMutableArray *pageLayers;
    NSMutableString *size;
    
    int version;
}

@property (readonly) NSMutableString *name;
@property (readonly) NSMutableArray *pageLayers;

- (id) initWithCoder: (NSCoder *) coder;

- (id) init;

- (void)encodeWithCoder:(NSCoder *)coder;

@end
