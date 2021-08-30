package com.rafao1991.mobilechallenge.moneyexchange.ui.currencyList

import android.os.Bundle
import android.view.*
import androidx.appcompat.widget.SearchView
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.lifecycle.ViewModelProvider
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
        setHasOptionsMenu(true)
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val list = view.findViewById<RecyclerView>(R.id.list)
        list.layoutManager = LinearLayoutManager(context)
        list.adapter = viewModel.currencyList.value?.currencies?.let {
            CurrencyListRecyclerViewAdapter(
                it,
                true,
                args.currencyType,
                CurrencyListRecyclerViewAdapter.OnClickListener { currency, key ->
                    viewModel.setCurrency(currency, key)
                    this.findNavController().navigate(
                        CurrencyListFragmentDirections.actionCurrencyListFragmentPop())
                }
            )
        }

        val searchBar = view.findViewById<SearchView>(R.id.searchBar)
        searchBar.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                (list.adapter as CurrencyListRecyclerViewAdapter?)?.getFilter()?.filter(query)
                return true
            }

            override fun onQueryTextChange(newText: String?): Boolean {
                (list.adapter as CurrencyListRecyclerViewAdapter?)?.getFilter()?.filter(newText)
                return true
            }
        })
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.overflow_menu, menu)
        super.onCreateOptionsMenu(menu, inflater)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        val asc = item.itemId == R.id.asc
        this.view?.findViewById<RecyclerView>(R.id.list)?.adapter =
            viewModel.currencyList.value?.currencies?.let {
                CurrencyListRecyclerViewAdapter(
                    it,
                    asc,
                    args.currencyType,
                    CurrencyListRecyclerViewAdapter.OnClickListener { currency, key ->
                        viewModel.setCurrency(currency, key)
                        findNavController().navigate(
                            CurrencyListFragmentDirections.actionCurrencyListFragmentPop())
                    }
                )
            }
        return true
    }
}