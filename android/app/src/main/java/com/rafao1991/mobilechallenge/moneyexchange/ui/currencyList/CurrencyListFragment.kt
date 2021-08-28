package com.rafao1991.mobilechallenge.moneyexchange.ui.currencyList

import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.findNavController
import androidx.navigation.fragment.findNavController
import androidx.navigation.fragment.navArgs
import com.rafao1991.mobilechallenge.moneyexchange.R
import com.rafao1991.mobilechallenge.moneyexchange.ui.main.MainViewModel

class CurrencyListFragment : Fragment() {

    private val args: CurrencyListFragmentArgs by navArgs()

    private lateinit var viewModel: MainViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        viewModel = ViewModelProvider(requireActivity()).get(MainViewModel::class.java)
        val view = inflater.inflate(R.layout.fragment_currency_list_adapter, container, false)

        if (view is RecyclerView) {
            with(view) {
                layoutManager = LinearLayoutManager(context)
                adapter = viewModel.currencyList.value?.currencies?.let {
                    CurrencyListRecyclerViewAdapter(
                        it,
                        args.currencyType,
                        CurrencyListRecyclerViewAdapter.OnClickListener { currency, key ->
                            viewModel.setCurrency(currency, key)
                            this.findNavController().navigate(
                                CurrencyListFragmentDirections.actionCurrencyListFragmentPop())
                        }
                    )
                }
            }
        }

        setHasOptionsMenu(true)
        return view
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.overflow_menu, menu)
        super.onCreateOptionsMenu(menu, inflater)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        this.view?.findViewById<RecyclerView>(R.id.list)?.adapter = CurrencyListRecyclerViewAdapter(
            viewModel.sort(item.itemId == R.id.asc)?.toMap() as Map<String, String>,
            args.currencyType,
            CurrencyListRecyclerViewAdapter.OnClickListener { currency, key ->
                viewModel.setCurrency(currency, key)
                findNavController().navigate(
                    CurrencyListFragmentDirections.actionCurrencyListFragmentPop())
            }
        )
        return true
    }
}