# Currency Converter

This sample Android app is made using *Kotlin* and *Clean Architecture*.
The objective is to implement a *Currency Converter* using the [API CurrencyLayer](https://currencylayer.com/documentation)
The app has only two screens: 
   * The Convertion screen
   * The List of all available currencies screen

We are using Gradle as dependency manager and the following dependencies:
   * Retrofit for managing the API requests
   * Realm for persisting offline data (tried room but got some crashes)
   * RxJava for dealing with threads (tried coroutines but got some crashes)
   * JUnit for Unit testing

## Clean Architecture Design Pattern

Clean architecture provides a modular implementation of the features, making code decoupled with this design pattern will help if we need to change technology in future, also helps in code reuse and unit-test writing.

![clean architecture image](pictures/clean-architecture.png)

We can see in the picture below that the project code is structured in packages, following the Clean architecture pattern.
* Se use the "Entity" package, where we store our models, and this package is only Kotlin, not aware of what other data sources or devices and platforms we are using.
* Also, wrapping the models, we have the business user cases, as interactors in a package called "Logic"
* And in the most external layer we have our view related content in a package called "Presentation" and the Database and Networking related classes in another package called Infrastructure"

![project structure image](pictures/structure.png)

## Code details

### Decoupling using interfaces

Using interfaces makes the code decoupled because we don't define big overloaded classes anymore. We first define which are the behaviors of each module and then objects can implement one or more interfaces. For simplicity, I have used interfaces only for the Presentation and Infrastructure layers, but it can also be extended to Interactors in the logic layer.
See below an example of interface for something called ConverterView, which is a piece of UI responsible for converting the currencies:

```java
interface ConverterView {
    fun setOriginalValueText(text: String)
    fun onOriginalCurrencyButtonClick(view : View)
    fun onConvertedCurrencyButtonClick(view: View)
    fun onConvertButtonClick(view: View)
    fun setOriginalCurrencyButtonText(text : String)
    fun setConvertedCurrencyButtonText(text : String)
    fun setConvertedValueText(text : String)
    fun showCurrencyList(requestCode : Int)
    fun showToast(message: String)
}
```


### Dumb Views with single responsability

Our Activities are the Views of the UI. That's all they do. Their responsability is to show things to user and recieve inputs from him/her.
See the code below, extracted from our Activities, how simple their methods became:

```java
    override fun onConvertedCurrencyButtonClick(view: View) {
        converterInteractor?.selectTargetCurrency()
    }

    override fun onConvertButtonClick(view: View) {
        converterInteractor?.convert()
    }

    override fun setOriginalCurrencyButtonText(text: String) {
        originalCurrencyButton.text = text
    }

    override fun setConvertedCurrencyButtonText(text: String) {
        convertedCurrencyButton.text = text
    }

    override fun setConvertedValueText(text : String) {
        convertedValueTextView.text = text
    }

    override fun showCurrencyList(requestCode: Int) {
        startActivityForResult(Intent(this, CurrenciesActivity::class.java), requestCode)
    }

    override fun showToast(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show()
    }

    override fun onDestroy() {
        compositeDisposable.dispose()
        converterInteractor?.onDestroy()
        super.onDestroy()
    }
```

### Testable logic with the Interactors

Decoupling the app logic from the Activities is useful not only because makes it easier to replace layers and methods, but also makes the code more testable. That's what we want to achieve with the Interactors being called in a layer that is different from the Views. Below are some methods written in the Interactors, note how they only do singular things and don't deal with the UI. When any UI action is needed, they call the Views in the presentation layer.

```java
   fun reorderList() {
         if (currentOrder == ORDER_TICKER) orderByName() else orderByTicker()
   }

   fun onCurrencySelected(selectedCurrency: Currency) {
        view.finishWithResultingCurrency(selectedCurrency)
   }

   fun clearSearch() {
        currentQuery = ""
        view.setRecyclerViewArray(ArrayList(database.getCurrencies()))
   }
```

### Unit-Testing the logic

The objective here is not give full code coverage, which would be time-consuming, but only exemplify how we structure the unit tests and mocks to work with the interactors.
Inside the test project we can find those examples. The purpose is to call some methods in the interactors and test their behaviors in terms of processed data or their outputs to other mocked units. We can apply this kind of test in pratically all the app structure given the app is very decoupled and our methods do just few things in their given scope.

![project structure image](pictures/tests.png)

## How the app works

Basically the app presents the user

## The home screen (ConverterActivity)

![project structure image](pictures/convert-done.jpg)

## The currencies list (CurrenciesActivity)


![project structure image](pictures/full-list.jpg)

## Searching for currencies

User can search for currency ticker (symbol) or by name as shown in picture below:

![project structure image](pictures/search.jpg)

## Ordering the search list

The search result (or the entire list) can be ordered by the currency ticker (Symbol) or Name by clicking in the button above the searchbar, as show in the picture below:

![project structure image](pictures/order-ticker.jpg) ![project structure image](pictures/order-name.jpg)

## Error treatment

If the user is offline or if any field is missing when he/she taps "Convert", the user will be presented a "Toast" saying what is missing.
There is also a "Toast" everytime the database is refreshed with live quotes from the API. This occurs, by economy, everytime the ConverterActivity gets created.

![project structure image](pictures/error-treatment.jpg) ![project structure image](pictures/updated-list.jpg)


## Problems faced

### Using room and coroutines

I really tried to make androidx's room for data persistence and coroutines for dealing with async threads. Although my code worked, I had some stability issues when running the app for a couple of seconds. The app suddenly crashed. So I preferred to replce room with Realm and coroutines with Rx (ReactiveX), which were more in my professional confort zone.
Because the app is really made on modules, it was not difficult to replace both. In case we find a good choice in the future, we could try any other solutions, but for the moment it is working fine.

## Troubleshooting

* Sometimes I had problems with the Android Emulator when trying to get the data from api.currencylayer.com. (No address associated with hostname). This is probably because in the free account we cannot call https access, only http. I was able to correctly get the currencies by running on a real Device.

