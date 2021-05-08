## CONVERT COINS

Uses shared preferences to keep user last convert choice
Use SQLite
Use dark Theme


The application will not work without a private key.

    1) generate one on https://currencylayer.com/
    2) past it inside native-lib.cpp changing <YOUR_API_KEY_HERE> with the right value
    3) run  git update-index --assume-unchanged app/src/main/cpp/native-lib.cpp

# references
- currency layer: https://currencylayer.com/documentation
- cpp api_key: https://www.codementor.io/blog/kotlin-apikeys-7o0g54qk5b
- recycler view: https://www.raywenderlich.com/1560485-android-recyclerview-tutorial-with-kotlin
- extensions: https://antonioleiva.com/kotlin-android-extensions/
- RecyclerView Empty Observer: https://stackoverflow.com/a/43953603/10526869
- Scroll view to bottom without loosing focus: https://stackoverflow.com/a/34866634/10526869
- View tags: https://stackoverflow.com/a/15021758/10526869
- ImageButton: https://developer.android.com/reference/android/widget/ImageButton
- Data binding:
    https://developer.android.com/topic/libraries/data-binding/index.html#includes
    https://developer.android.com/topic/libraries/view-binding#activities