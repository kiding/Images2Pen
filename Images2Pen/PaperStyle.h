#import <Foundation/Foundation.h>

@interface PaperStyle : NSObject
{
    NSString *paperUUID;
    
    int style;
}

- (id) initWithCoder: (NSCoder *) coder;

- (id) init;

- (void)encodeWithCoder:(NSCoder *)coder;

@end
