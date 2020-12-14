import SwiftUI
import Combine

var screenHeight = UIScreen.main.bounds.height

struct CurrencyConversionView: View {
 var currencies: [String: String] = ["":""]
 @ObservedObject var viewModel: CurrencyConversionViewModel

 @State var fromInput = ""
 @State var currencyFrom: String = "USD"
 @State var currencyTo: String = "USD"
 @State var exchangeResult: String = "0.0"

  var body: some View {
    NavigationView {
      ZStack {
        Color.init("color_primary_background").edgesIgnoringSafeArea(.all)
        if viewModel.state.isLoading {
          loadingIndicator
        } else {
          VStack(alignment: .leading) {
          VStack(spacing: screenHeight/3) {
              HStack(alignment: .center, spacing: 26) {
                NavigationLink(destination: AvailableCurrencies(currencies: viewModel.state.currencies, currencyItem: $currencyFrom)) {
                  CurrecyButton(currencyItem: $currencyFrom)
                }
                VStack() {
                  CurrencyInput(model: CurrencyInputModel(txt: $fromInput))
                  Divider()
                   .frame(height: 1)
                   .padding(.horizontal, 30)
                   .background(Color.white)
                }
              }
              VStack() {
                HStack(alignment: .center) {
                  NavigationLink(destination: AvailableCurrencies(currencies: viewModel.state.currencies, currencyItem: $currencyTo)) {
                    CurrecyButton(currencyItem: $currencyTo)
                  }
                  Spacer()
                  Text(String(exchangeResult))
                    .font(.title3)
                    .lineLimit(1)
                    .lineSpacing(50)
                    .foregroundColor(Color.white)
                    .frame(width: 150, height: 100, alignment: .trailing)
                }
              }
            }
            .padding(16)
            Spacer()
            Button(action: {
              exchangeResult = String(format: "%.2f",
                                     Calculator(exanges: viewModel.state.exangeRates)
                                        .exanges(valueToConvert: (Double(fromInput) ?? 0.0)/100,
                                                currecyToConvert: currencyTo,
                                                currencyFromConvert: currencyFrom)
              )
            }) {
              Text("Calculate")
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.system(size: 18))
                .padding()
                .foregroundColor(.white)
            }
            .padding(12)
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.white)
          }
        }
      }
      .toolbar {
        ToolbarItem(placement: .principal) { Text("Currency Layer").foregroundColor(Color.white) }
      }
    }
  }
  
  private var loadingIndicator: some View {
    ActivityIndicator(isAnimating: .constant(true), style: .large, color: .gray)
      .frame(maxWidth: .infinity, alignment: .center)
  }
}

struct CurrecyButton: View {
  @Binding var currencyItem: String
  var body: some View {
    HStack {
      Image("ic_arrow_down")
        .resizable()
        .foregroundColor(Color.white)
        .frame(width: 15, height: 15)

      Text(currencyItem)
        .foregroundColor(Color.white)

    }
  }
}

//  = [  "AED":"United Arab Emirates Dirham",
//            "AFN":"Afghan Afghani",
//            "ALL":"Albanian Lek",
//            "AMD":"Armenian Dram",
//            "ANG":"Netherlands Antillean Guilder",
//            "AOA":"Angolan Kwanza",
//            "ARS":"Argentine Peso",
//            "AUD":"Australian Dollar",
//            "AWG":"Aruban Florin",
//            "AZN":"Azerbaijani Manat",
//            "BAM":"Bosnia-Herzegovina Convertible Mark",
//            "BBD":"Barbadian Dollar",
//            "BDT":"Bangladeshi Taka",
//            "BGN":"Bulgarian Lev",
//            "BHD":"Bahraini Dinar",
//            "BIF":"Burundian Franc",
//            "BMD":"Bermudan Dollar",
//            "BND":"Brunei Dollar",
//            "BOB":"Bolivian Boliviano",
//            "BRL":"Brazilian Real",
//            "BSD":"Bahamian Dollar",
//            "BTC":"Bitcoin",
//            "BTN":"Bhutanese Ngultrum",
//            "BWP":"Botswanan Pula",
//            "BYN":"New Belarusian Ruble",
//            "BYR":"Belarusian Ruble",
//            "BZD":"Belize Dollar",
//            "CAD":"Canadian Dollar",
//            "CDF":"Congolese Franc",
//            "CHF":"Swiss Franc",
//            "CLF":"Chilean Unit of Account (UF)",
//            "CLP":"Chilean Peso",
//            "CNY":"Chinese Yuan",
//            "COP":"Colombian Peso",
//            "CRC":"Costa Rican Col\u{00f3}n",
//            "CUC":"Cuban Convertible Peso",
//            "CUP":"Cuban Peso",
//            "CVE":"Cape Verdean Escudo",
//            "CZK":"Czech Republic Koruna",
//            "DJF":"Djiboutian Franc",
//            "DKK":"Danish Krone",
//            "DOP":"Dominican Peso",
//            "DZD":"Algerian Dinar",
//            "EGP":"Egyptian Pound",
//            "ERN":"Eritrean Nakfa",
//            "ETB":"Ethiopian Birr",
//            "EUR":"Euro",
//            "FJD":"Fijian Dollar",
//            "FKP":"Falkland Islands Pound",
//            "GBP":"British Pound Sterling",
//            "GEL":"Georgian Lari",
//            "GGP":"Guernsey Pound",
//            "GHS":"Ghanaian Cedi",
//            "GIP":"Gibraltar Pound",
//            "GMD":"Gambian Dalasi",
//            "GNF":"Guinean Franc",
//            "GTQ":"Guatemalan Quetzal",
//            "GYD":"Guyanaese Dollar",
//            "HKD":"Hong Kong Dollar",
//            "HNL":"Honduran Lempira",
//            "HRK":"Croatian Kuna",
//            "HTG":"Haitian Gourde",
//            "HUF":"Hungarian Forint",
//            "IDR":"Indonesian Rupiah",
//            "ILS":"Israeli New Sheqel",
//            "IMP":"Manx pound",
//            "INR":"Indian Rupee",
//            "IQD":"Iraqi Dinar",
//            "IRR":"Iranian Rial",
//            "ISK":"Icelandic Kr\u{00f3}na",
//            "JEP":"Jersey Pound",
//            "JMD":"Jamaican Dollar",
//            "JOD":"Jordanian Dinar",
//            "JPY":"Japanese Yen",
//            "KES":"Kenyan Shilling",
//            "KGS":"Kyrgystani Som",
//            "KHR":"Cambodian Riel",
//            "KMF":"Comorian Franc",
//            "KPW":"North Korean Won",
//            "KRW":"South Korean Won",
//            "KWD":"Kuwaiti Dinar",
//            "KYD":"Cayman Islands Dollar",
//            "KZT":"Kazakhstani Tenge",
//            "LAK":"Laotian Kip",
//            "LBP":"Lebanese Pound",
//            "LKR":"Sri Lankan Rupee",
//            "LRD":"Liberian Dollar",
//            "LSL":"Lesotho Loti",
//            "LTL":"Lithuanian Litas",
//            "LVL":"Latvian Lats",
//            "LYD":"Libyan Dinar",
//            "MAD":"Moroccan Dirham",
//            "MDL":"Moldovan Leu",
//            "MGA":"Malagasy Ariary",
//            "MKD":"Macedonian Denar",
//            "MMK":"Myanma Kyat",
//            "MNT":"Mongolian Tugrik",
//            "MOP":"Macanese Pataca",
//            "MRO":"Mauritanian Ouguiya",
//            "MUR":"Mauritian Rupee",
//            "MVR":"Maldivian Rufiyaa",
//            "MWK":"Malawian Kwacha",
//            "MXN":"Mexican Peso",
//            "MYR":"Malaysian Ringgit",
//            "MZN":"Mozambican Metical",
//            "NAD":"Namibian Dollar",
//            "NGN":"Nigerian Naira",
//            "NIO":"Nicaraguan C\u{00f3}rdoba",
//            "NOK":"Norwegian Krone",
//            "NPR":"Nepalese Rupee",
//            "NZD":"New Zealand Dollar",
//            "OMR":"Omani Rial",
//            "PAB":"Panamanian Balboa",
//            "PEN":"Peruvian Nuevo Sol",
//            "PGK":"Papua New Guinean Kina",
//            "PHP":"Philippine Peso",
//            "PKR":"Pakistani Rupee",
//            "PLN":"Polish Zloty",
//            "PYG":"Paraguayan Guarani",
//            "QAR":"Qatari Rial",
//            "RON":"Romanian Leu",
//            "RSD":"Serbian Dinar",
//            "RUB":"Russian Ruble",
//            "RWF":"Rwandan Franc",
//            "SAR":"Saudi Riyal",
//            "SBD":"Solomon Islands Dollar",
//            "SCR":"Seychellois Rupee",
//            "SDG":"Sudanese Pound",
//            "SEK":"Swedish Krona",
//            "SGD":"Singapore Dollar",
//            "SHP":"Saint Helena Pound",
//            "SLL":"Sierra Leonean Leone",
//            "SOS":"Somali Shilling",
//            "SRD":"Surinamese Dollar",
//            "STD":"S\u{00e3}o Tom\u{00e9} and Pr\u{00}edncipe Dobra",
//            "SVC":"Salvadoran Col\u{00f3}n",
//            "SYP":"Syrian Pound",
//            "SZL":"Swazi Lilangeni",
//            "THB":"Thai Baht",
//            "TJS":"Tajikistani Somoni",
//            "TMT":"Turkmenistani Manat",
//            "TND":"Tunisian Dinar",
//            "TOP":"Tongan Pa\u{02}bbanga",
//            "TRY":"Turkish Lira",
//            "TTD":"Trinidad and Tobago Dollar",
//            "TWD":"New Taiwan Dollar",
//            "TZS":"Tanzanian Shilling",
//            "UAH":"Ukrainian Hryvnia",
//            "UGX":"Ugandan Shilling",
//            "USD":"United States Dollar",
//            "UYU":"Uruguayan Peso",
//            "UZS":"Uzbekistan Som",
//            "VEF":"Venezuelan Bol\u{00}edvar Fuerte",
//            "VND":"Vietnamese Dong",
//            "VUV":"Vanuatu Vatu",
//            "WST":"Samoan Tala",
//            "XAF":"CFA Franc BEAC",
//            "XAG":"Silver (troy ounce)",
//            "XAU":"Gold (troy ounce)",
//            "XCD":"East Caribbean Dollar",
//            "XDR":"Special Drawing Rights",
//            "XOF":"CFA Franc BCEAO",
//            "XPF":"CFP Franc",
//            "YER":"Yemeni Rial",
//            "ZAR":"South African Rand",
//            "ZMK":"Zambian Kwacha (pre-2013)",
//            "ZMW":"Zambian Kwacha",
//            "ZWL":"Zimbabwean Dollar"]
