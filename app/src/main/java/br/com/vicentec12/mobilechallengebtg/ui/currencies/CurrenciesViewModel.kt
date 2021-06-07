package br.com.vicentec12.mobilechallengebtg.ui.currencies

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import br.com.vicentec12.mobilechallengebtg.R
import br.com.vicentec12.mobilechallengebtg.data.model.Currency
import br.com.vicentec12.mobilechallengebtg.data.source.Result
import br.com.vicentec12.mobilechallengebtg.data.source.data_source.currencies.CurrenciesDataSource
import br.com.vicentec12.mobilechallengebtg.di.ActivityScope
import kotlinx.coroutines.launch
import java.util.*
import javax.inject.Inject
import kotlin.collections.ArrayList

@ActivityScope
class CurrenciesViewModel @Inject constructor(
    private val mRepository: CurrenciesDataSource
) : ViewModel() {

    private val _currencies = MutableLiveData<List<Currency>>()
    val currencies: LiveData<List<Currency>>
        get() = _currencies

    private val _message = MutableLiveData<Pair<Int, Boolean>>()
    val message: LiveData<Pair<Int, Boolean>>
        get() = _message

    private val _displayedChild = MutableLiveData<Int>()
    val displayedChild: LiveData<Int>
        get() = _displayedChild

    val sortBy = MutableLiveData(0)

    val searchText = MutableLiveData("")

    val isSearchExpanded = MutableLiveData(false)

    private val _currenciesBackup = MutableLiveData<List<Currency>?>()

    fun listCurrencies() = viewModelScope.launch {
        if (_currencies.value == null) {
            _displayedChild.value = CHILD_LOADING
            when (val result = mRepository.list()) {
                is Result.Success -> {
                    _currencies.value = result.data!!
                    _displayedChild.value = CHILD_DATA
                }
                is Result.Error -> {
                    _message.value = result.message to true
                    _displayedChild.value = CHILD_MESSAGE
                }
            }
        }
    }

    fun sortBy() {
        _currencies.value?.apply {
            val mSortedList = ArrayList(this)
            mSortedList.sortBy {
                if (sortBy.value == ORDER_BY_CODE) it.code else it.name
            }
            _currencies.value = mSortedList
        }
    }

    fun search(mSearch: String) {
        if (_currenciesBackup.value == null)
            _currenciesBackup.value = _currencies.value
        _currenciesBackup.value?.apply {
            searchText.value = mSearch
            val mSearchedList = this.filter {
                it.code.toLowerCase(Locale.ROOT).contains(mSearch.toLowerCase(Locale.ROOT)) ||
                        it.name.toLowerCase(Locale.ROOT)
                            .contains(mSearch.toLowerCase(Locale.ROOT)) || mSearch.isEmpty()
            }
            if (mSearchedList.isNotEmpty()) {
                _currencies.value = mSearchedList
                _displayedChild.value = CHILD_DATA
            } else {
                _message.value = R.string.message_error_search to false
                _displayedChild.value = CHILD_MESSAGE
            }
        }
        if (mSearch.isEmpty())
            _currenciesBackup.value = null
    }

    companion object {

        const val CHILD_LOADING = 0
        const val CHILD_DATA = 1
        const val CHILD_MESSAGE = 2

        const val ORDER_BY_CODE = 0

    }

}