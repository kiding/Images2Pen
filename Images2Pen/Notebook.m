#import "Notebook.h"

@implementation Notebook

@synthesize pageNames, title;

- (id) initWithCoder: (NSCoder *) coder
{
    self = [super init];
    if(self) {
        blankPages = [[coder decodeObjectForKey:@"blankPages"] retain]; // {}
        
        changeCount = [coder decodeIntForKey:@"changeCount"]; // 0
        coverColor = [coder decodeIntForKey:@"coverColor"]; // 0
        
        created = [[coder decodeObjectForKey:@"created"] retain]; // NSDate date
        creatingDeviceId = [[coder decodeObjectForKey:@"creatingDeviceId"] retain]; // HASH FOR DEVICE SHA1
        
        editingPageName = [[coder decodeObjectForKey:@"editingPageName"] retain]; // nil
        imported = [[coder decodeObjectForKey:@"imported"] retain]; // nil
        
        modified = [[coder decodeObjectForKey:@"modified"] retain]; // NSDate date
        name = [[coder decodeObjectForKey:@"name"] retain]; // HASH FOR SELF
        originalName = [[coder decodeObjectForKey:@"originalName"] retain]; // 왜 name이랑 같지
        
        pageDataIsCooked = [coder decodeBoolForKey:@"pageDataIsCooked"]; // NO
        
        pageNames = [[coder decodeObjectForKey:@"pageNames"] retain]; // {page1Name, page2Name, ...}
        pagePaperStyles = [[coder decodeObjectForKey:@"pagePaperStyles"] retain]; // {}
        
        paperStyle = [[coder decodeObjectForKey:@"paperStyle"] retain]; // PaperStyle class
        
        title = [[coder decodeObjectForKey:@"title"] retain]; // @"..."
        
        versionMajor = [coder decodeIntForKey:@"versionMajor"]; // 1
        versionMinor = [coder decodeIntForKey:@"versionMinor"]; // 0
    }
    return self;
}

- (id) init
{
    self = [super init];
    if(self) {
        blankPages = [[NSMutableSet alloc] init]; // {}
        
        changeCount = 1; // 1
        coverColor = 0; // 0
        
        created = [[NSDate date] retain]; // NSDate date
//        creatingDeviceId = [[NSMutableString alloc] initWithString:@"fd6139ec61e41071d06280374d70a54b52af3f74"]; // HASH FOR DEVICE SHA1
        creatingDeviceId = [[NSMutableString alloc] initWithString:@"2757d5a2addfe995f38bc4bafb9039c259824a1d"]; // HASH FOR DEVICE SHA1
        
        editingPageName = nil; // nil
        imported = nil; // nil
        
        modified = [[NSDate date] retain]; // NSDate date
//        name = [@"03CE6A63-FB4C-4AF1-8D3F-D6355FCFF790" retain]; // HASH FOR SELF
        name = [[NSMutableString alloc] initWithFormat:@"%d-%d-%d", (unsigned int)self, (unsigned int)time(NULL), (unsigned int)self];
        originalName = [[NSString alloc] initWithString:name]; // 왜 name이랑 같지
        
        pageDataIsCooked = NO; // NO
        
        pageNames = [[NSMutableArray alloc] init]; // {page1Name, page2Name, ...}
        pagePaperStyles = [[NSMutableDictionary alloc] init]; // {}
        
        paperStyle = [[PaperStyle alloc] init]; // PaperStyle class
        
        title = [[NSMutableString alloc] initWithString:@"Penultimate"]; // @"..."
        
        versionMajor = 1; // 1
        versionMinor = 0; // 0        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:blankPages forKey:@"blankPages"];

    [coder encodeInt:changeCount forKey:@"changeCount"];
    [coder encodeInt:coverColor forKey:@"coverColor"];

    [coder encodeObject:created forKey:@"created"];
    [coder encodeObject:creatingDeviceId forKey:@"creatingDeviceId"];

    [coder encodeObject:editingPageName forKey:@"editingPageName"];
    [coder encodeObject:imported forKey:@"imported"];

    [coder encodeObject:modified forKey:@"modified"];
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:originalName forKey:@"originalName"];

    [coder encodeBool:pageDataIsCooked forKey:@"pageDataIsCooked"];

    [coder encodeObject:pageNames forKey:@"pageNames"];
    [coder encodeObject:pagePaperStyles forKey:@"pagePaperStyles"];

    [coder encodeObject:paperStyle forKey:@"paperStyle"];

    [coder encodeObject:title forKey:@"title"];

    [coder encodeInt:versionMajor forKey:@"versionMajor"];
    [coder encodeInt:versionMinor forKey:@"versionMinor"];
}

- (void) dealloc
{
    [blankPages release];
    
    [created release];
    [creatingDeviceId release];
    
    [modified release];
    
    [name release];
    [originalName release];
    
    [pageNames release];
    [pagePaperStyles release];
    
    [title release];
    
    [super dealloc];
}

@end
