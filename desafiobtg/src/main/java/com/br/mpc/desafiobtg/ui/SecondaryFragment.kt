package com.br.mpc.desafiobtg.ui

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.widget.doOnTextChanged
import androidx.navigation.fragment.navArgs
import com.br.mpc.desafiobtg.BaseFragment
import com.br.mpc.desafiobtg.R
import com.br.mpc.desafiobtg.StateViewModel
import com.br.mpc.desafiobtg.adapter.CurrenciesAdapter
import com.br.mpc.desafiobtg.utils.INPUT_CURRENCY_TYPE
import com.br.mpc.desafiobtg.utils.toDefaultUpperCase
import com.br.mpc.desafiobtg.utils.transform
import kotlinx.android.synthetic.main.fragment_secondary.*
import kotlinx.android.synthetic.main.layout_currency_item.*
import kotlinx.coroutines.channels.ConflatedBroadcastChannel
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import org.koin.androidx.viewmodel.ext.android.sharedViewModel
import org.koin.androidx.viewmodel.ext.android.viewModel

class SecondaryFragment : BaseFragment() {
    override val viewModel: MainViewModel by sharedViewModel()
    private val args by navArgs<SecondaryFragmentArgs>()
    private val mAdapter = CurrenciesAdapter {
        viewModel.updateCurrency(it, args.currencyType)
        requireActivity().onBackPressed()
    }
    private var searchFor = ""

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_secondary, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        currenciesRecyclerView.adapter = mAdapter

        filterTextInput.editText!!.doOnTextChanged { text, _, _, _ ->
            val searchText = text.toString().trim()
            if (searchText == searchFor) return@doOnTextChanged

            searchFor = searchText

            launch {
                delay(500)
                if (searchText != searchFor) return@launch
                filterBy(text.toString())
            }
        }

        filterTextInput.setEndIconOnClickListener {
            filterTextInput.editText!!.setText("")
        }
    }

    private fun filterBy(search: String) {
        val filteredList =
            viewModel.currencies.value?.filter {
                (it.key + it.value).toDefaultUpperCase().contains(search.toDefaultUpperCase())
            }.transform()
        mAdapter.updateList(filteredList)
    }

    override fun onStart() {
        super.onStart()
        subscribe()
    }

    override fun onResume() {
        super.onResume()
        viewModel.fetchCurrencies()
    }

    override fun onPause() {
        super.onPause()
        mAdapter.updateList(listOf())
    }

    private fun subscribe() {
        with(viewModel) {
            currencies.observe(viewLifecycleOwner) {
                val listOfCurrencies = ArrayList<Pair<String, String>>()
                val currencies = it.toString()
                val treatedCurrencies = currencies.removePrefix("{").removeSuffix("}").split(", ")

                treatedCurrencies.forEach { currency ->
                    val splited = currency.split("=")
                    listOfCurrencies.add(Pair(splited[0], splited[1]))
                }

                mAdapter.updateList(listOfCurrencies)
            }
        }
    }
}