#import <Foundation/Foundation.h>
#import "PaperStyle.h"

@interface Notebook : NSObject
{
    NSMutableSet *blankPages;
    
    int changeCount;
    int coverColor;
    
    NSDate *created;
    NSMutableString *creatingDeviceId;
    
    id editingPageName;
    id imported;
    
    NSMutableString *modified;
    NSMutableString *name;
    NSString *originalName;
    
    BOOL pageDataIsCooked;
    
    NSMutableArray *pageNames;
    NSMutableDictionary *pagePaperStyles;
    
    PaperStyle *paperStyle;
    
    NSMutableString *title;
    
    int versionMajor;
    int versionMinor;
}

@property (readonly) NSMutableArray *pageNames;
@property (readonly) NSMutableString *title;

- (id) initWithCoder: (NSCoder *) coder;

- (id) init;

- (void)encodeWithCoder:(NSCoder *)coder;

@end
