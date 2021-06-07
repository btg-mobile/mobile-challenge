package br.com.vicentec12.mobilechallengebtg.ui.currencies

import android.content.Intent
import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.Observer
import br.com.vicentec12.mobilechallengebtg.data.model.Currency
import br.com.vicentec12.mobilechallengebtg.data.source.Result
import br.com.vicentec12.mobilechallengebtg.data.source.data_source.currencies.CurrenciesRepository
import br.com.vicentec12.mobilechallengebtg.ui.currencies.CurrenciesViewModel.Companion.CHILD_DATA
import br.com.vicentec12.mobilechallengebtg.ui.currencies.CurrenciesViewModel.Companion.CHILD_LOADING
import br.com.vicentec12.mobilechallengebtg.ui.currencies.CurrenciesViewModel.Companion.CHILD_MESSAGE
import br.com.vicentec12.mobilechallengebtg.ui.util.TestCoroutineRule
import kotlinx.coroutines.ExperimentalCoroutinesApi
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.rules.TestRule
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.Mockito.`when`
import org.mockito.Mockito.verify
import org.mockito.junit.MockitoJUnitRunner

@ExperimentalCoroutinesApi
@RunWith(MockitoJUnitRunner::class)
class CurrenciesViewModelTest {

    @get:Rule
    val mTestInstantTaskExecutorRule: TestRule = InstantTaskExecutorRule()

    @get:Rule
    val mTestCoroutineRule = TestCoroutineRule()

    @Mock
    lateinit var mRepository: CurrenciesRepository

    @Mock
    lateinit var mCurrenciesObserver: Observer<List<Currency>>

    @Mock
    lateinit var mViewFlipperObserver: Observer<Int>

    @Mock
    lateinit var mErrorMessageObserver: Observer<Pair<Int, Boolean>>

    private lateinit var mViewModel: CurrenciesViewModel

    private lateinit var mCurrencies: List<Currency>

    @Before
    fun setup() {

        mCurrencies = listOf(
            Currency(1, "BRL", "Braziliam Real"),
            Currency(2, "USD", "Unites States Dollar"),
            Currency(3, "JPY", "Japan Yene"),
            Currency(4, "EUR", "Euro")
        )
        mViewModel = CurrenciesViewModel(mRepository)
        mViewModel.currencies.observeForever(mCurrenciesObserver)
        mViewModel.displayedChild.observeForever(mViewFlipperObserver)
        mViewModel.message.observeForever(mErrorMessageObserver)
    }

    @Test
    fun `when list currencies success show recycler view`() {
        mTestCoroutineRule.runBlockingTest {
            // Arrange
            `when`(mRepository.list()).thenReturn(Result.Success(mCurrencies, 1))

            // Act
            mViewModel.listCurrencies()

            // Assert
            verify(mViewFlipperObserver).onChanged(CHILD_LOADING)
            verify(mCurrenciesObserver).onChanged(mCurrencies)
            verify(mViewFlipperObserver).onChanged(CHILD_DATA)
        }
    }

    @Test
    fun `when list currencies failed show error message with button try again`() {
        mTestCoroutineRule.runBlockingTest {
            // Arrange
            `when`(mRepository.list()).thenReturn(Result.Error(1))

            // Act
            mViewModel.listCurrencies()

            // Assert
            verify(mViewFlipperObserver).onChanged(CHILD_LOADING)
            verify(mErrorMessageObserver).onChanged(Pair(1, true))
            verify(mViewFlipperObserver).onChanged(CHILD_MESSAGE)
        }
    }

    @Test
    fun `test if search contains in currency`() {
        // Act
        val mSearch = "BRa"
        val mContainedList = mCurrencies.filter {
            it.name.toLowerCase().contains(mSearch.toLowerCase()) || it.name.toLowerCase()
                .contains(mSearch.toLowerCase()) || mSearch.isEmpty()
        }

        // Assert
        assert(mContainedList.size == 1)
    }

}