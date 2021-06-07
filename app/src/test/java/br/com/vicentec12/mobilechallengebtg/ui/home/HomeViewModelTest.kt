package br.com.vicentec12.mobilechallengebtg.ui.home

import android.content.Intent
import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.Observer
import br.com.vicentec12.mobilechallengebtg.data.model.Quote
import br.com.vicentec12.mobilechallengebtg.data.source.Result
import br.com.vicentec12.mobilechallengebtg.data.source.data_source.quotes.QuotesRepository
import br.com.vicentec12.mobilechallengebtg.extension.currencyToDouble
import br.com.vicentec12.mobilechallengebtg.ui.util.TestCoroutineRule
import br.com.vicentec12.mobilechallengebtg.util.Event
import kotlinx.coroutines.ExperimentalCoroutinesApi
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.rules.TestRule
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.Mockito
import org.mockito.junit.MockitoJUnitRunner

@ExperimentalCoroutinesApi
@RunWith(MockitoJUnitRunner::class)
class HomeViewModelTest {

    @get:Rule
    val mTestInstantTaskExecutorRule: TestRule = InstantTaskExecutorRule()

    private lateinit var mQuotes: List<Quote>

    @Before
    fun setup() {
        mQuotes = listOf(
            Quote("USDBRL", "USD", 5.05),
            Quote("USDUSD", "USD", 1.0),
            Quote("USDJPY", "USD", 109.55),
            Quote("USDEUR", "USD", 0.82)
        )
    }

    @Test
    fun `when receipt value and currencies give value coverting`() {
        // Act
        val result = convertCurrency(" 100,00", "JPY", "EUR", mQuotes)
        println(String.format("%.2f", result))

        // Assert
        assert(result == 0.74851665905979)
    }

    @Test
    fun `convert currency string to double`() {
        // Act
        val mCurrency = "1.000,00"
        val mValue = mCurrency.currencyToDouble()

        // Assert
        assert(mValue == 1000.0)
    }

    private fun convertCurrency(
        mValue: String?,
        mFromCurrency: String,
        mToAfter: String,
        mQuotes: List<Quote>
    ): Double {
        val mValueDouble = mValue?.currencyToDouble() ?: 0.0
        val mQuotesMap = mutableMapOf<String, Double>()
        var mSource = ""
        mQuotes.forEach { mQuote ->
            if (
                mQuote.code == "${mQuote.source}$mFromCurrency" ||
                mQuote.code == "${mQuote.source}$mToAfter"
            ) {
                mSource = mQuote.source
                mQuotesMap[mQuote.code] = mQuote.value
            }
        }
        return (mValueDouble / (mQuotesMap["$mSource$mFromCurrency"] ?: 1.0) *
                (mQuotesMap["$mSource$mToAfter"] ?: 0.0))
    }

}