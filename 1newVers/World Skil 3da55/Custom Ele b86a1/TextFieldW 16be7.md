# TextFieldWithHandlingInput

```swift
import Combine
import SwiftUI
...
.keyboardType(.numberPad)
.onReceive(Just(text)) { newValue in 
	text = filterFunc(text)
	// some extra logic
}
```