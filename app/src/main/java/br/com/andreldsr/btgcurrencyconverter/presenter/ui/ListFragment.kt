package br.com.andreldsr.btgcurrencyconverter.presenter.ui

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.observe
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import br.com.andreldsr.btgcurrencyconverter.R
import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency
import br.com.andreldsr.btgcurrencyconverter.mock.CurrencyMockRepositoryImpl
import br.com.andreldsr.btgcurrencyconverter.presenter.adapter.CurrencyListItemAdapter
import br.com.andreldsr.btgcurrencyconverter.presenter.viewmodel.CurrencyConversionViewModel
import br.com.andreldsr.btgcurrencyconverter.presenter.viewmodel.CurrencyListViewModel
import kotlinx.android.synthetic.main.activity_currency_list.*
import java.util.Observer

class ListFragment : Fragment() {
    val currencyConversionViewModel: CurrencyConversionViewModel by activityViewModels(){
        CurrencyConversionViewModel.ViewModelFactory()
    }
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_currency_list, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val type = arguments?.getString("type")
        lateinit var currency : Currency
        currency = when (type) {
            "from" -> currencyConversionViewModel.currencyFrom.value!!
            "to" -> currencyConversionViewModel.currencyTo.value!!
            else -> Currency(initials = "ERR", name = "Error Selecting Currency")
        }
        currency_selected_item_initials.text = currency.initials
        currency_selected_item_name.text = currency.name

        val viewModel: CurrencyListViewModel = CurrencyListViewModel.ViewModelFactory(
            CurrencyMockRepositoryImpl.build()).create(CurrencyListViewModel::class.java)

        viewModel.currencyLiveData.observe(viewLifecycleOwner) {
            it.let { currencyList ->
                with(currency_list_recycle_view){
                    layoutManager = LinearLayoutManager(this@ListFragment.context, RecyclerView.VERTICAL, false)
                    setHasFixedSize(true)
                    adapter = CurrencyListItemAdapter(currencyList){currency ->
                        when(type){
                            "from" -> currencyConversionViewModel.currencyFrom.value = currency
                            "to" -> currencyConversionViewModel.currencyTo.value = currency
                        }
                        findNavController().popBackStack()
                    }
                }
            }
        }
        viewModel.getCurrencies()
    }
}