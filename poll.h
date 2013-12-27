#import <AppKit/NSPasteboard.h>

@interface PasteboardWatcher : NSObject

- (id)initWithPasteboard:(NSPasteboard *)pasteboard;
- (void)timerCallback:(NSTimer *)timer;

@property(retain) NSPasteboard *pasteboard;
@property NSInteger observedChangeCount;

@end
