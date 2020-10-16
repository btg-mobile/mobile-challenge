package br.net.easify.currencydroid.view

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.Navigation
import androidx.recyclerview.widget.LinearLayoutManager
import br.net.easify.currencydroid.R
import br.net.easify.currencydroid.database.model.Currency
import br.net.easify.currencydroid.databinding.FragmentCurrenciesBinding
import br.net.easify.currencydroid.view.adapters.CurrenciesAdapter
import br.net.easify.currencydroid.viewmodel.CurrenciesViewModel
import kotlinx.android.synthetic.main.fragment_currencies.*

class CurrenciesFragment : Fragment(), CurrenciesAdapter.OnItemClick {
    private lateinit var viewModel: CurrenciesViewModel
    private lateinit var dataBinding: FragmentCurrenciesBinding
    private lateinit var currenciesAdapter: CurrenciesAdapter

    private val currenciesObserver = Observer<List<Currency>> {
        currenciesAdapter.updateData(it)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        (activity as AppCompatActivity?)!!.supportActionBar!!.show()
        (activity as AppCompatActivity?)!!.supportActionBar!!.title = getString(R.string.cancel)

        (activity as AppCompatActivity?)!!.supportActionBar!!.show()
        dataBinding = DataBindingUtil.inflate(
            inflater,
            R.layout.fragment_currencies,
            container,
            false
        )

        return dataBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        setupViewModel()
        setupRecyclerView()
    }

    private fun setupRecyclerView() {
        currenciesAdapter =
            CurrenciesAdapter(this, arrayListOf())

        dataBinding.currencies.apply {
            layoutManager = LinearLayoutManager(context)
            adapter = currenciesAdapter
        }
    }

    private fun setupViewModel() {
        viewModel = ViewModelProviders.of(this).get(CurrenciesViewModel::class.java)
        viewModel.currencies.observe(viewLifecycleOwner, currenciesObserver)
    }

    override fun onItemClick(currency: Currency) {
        val action = CurrenciesFragmentDirections.actionHome()
        Navigation.findNavController(currencies).navigate(action)
    }
}