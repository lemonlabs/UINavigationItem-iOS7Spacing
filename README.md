UINavigationItem-iOS7Spacing
============================

Category to fix iOS 7 UINavigationItem spacing.

leftBarButtonItem position on iOS 5/6

![iOS 6 default](ios6-default.png)


leftBarButtonItem position on iOS 7

![iOS 7 default](ios7-default.png)


Fixed leftBarButtonItem position on iOS 7

![iOS 7 fixed](ios7-fixed.png)

You do not have to do anything else, except include this category in your *-Prefix.pch file:

```
#ifdef __OBJC__
    #import <UIKit/UIKit.h>
    #import <Foundation/Foundation.h>
    #import "UINavigationItem+iOS7Spacing.h"
#endif
```

Fully tested on iOS 6/7.