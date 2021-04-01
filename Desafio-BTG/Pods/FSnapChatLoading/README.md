# FSnapChatLoading
A loading tool similar to that in Snap Chat

## Requirements

- iOS 9.0+
- Swift 4.2+


# Setup
Add `pod 'FSnapChatLoading'` to your Podfile

Run `pod install`

# How to use
1. Create an instance of `FSnapChatLoadingView`

    `let loadingView = FSnapChatLoadingView()`
    
    Usually this would be a property of your view controller.
    
2. Show the view with

    `loadingView.show(view: view, color: UIColor.yellow)`
    
3. Hide the view with

    `loadingView.hide()`
    
    
# Options

`loadingView.setColorBackground(color: .clear)`

`loadingView.setBackgroundBlurEffect()`


## Author

Faisal AL-Otaibi, @faisal_bz


## License

FSnapChatLoading is available under the MIT license. See the LICENSE file for more info.
