package br.net.easify.currencydroid.view

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.Navigation
import br.net.easify.currencydroid.R
import br.net.easify.currencydroid.database.model.Currency
import br.net.easify.currencydroid.databinding.FragmentHomeBinding
import br.net.easify.currencydroid.util.Constants
import br.net.easify.currencydroid.viewmodel.HomeViewModel

class HomeFragment : Fragment() {

    private lateinit var viewModel: HomeViewModel
    private lateinit var dataBinding: FragmentHomeBinding

    private val bannerTextObserver = Observer<String> {
        if (it.isNotEmpty()) {
            dataBinding.info.visibility = View.VISIBLE
            dataBinding.banner.visibility = View.VISIBLE
            dataBinding.banner.text = it
        } else {
            dataBinding.info.visibility = View.GONE
            dataBinding.banner.visibility = View.GONE
        }
    }

    private val lastUpdateTextObserver = Observer<String> {
        if (it.isNotEmpty()) {
            dataBinding.lastUpdate.visibility = View.VISIBLE
            dataBinding.lastUpdate.text = getString(R.string.last_update) +  ": " + it
        } else {
            dataBinding.lastUpdate.visibility = View.GONE
        }
    }

    private val fromValueObserver = Observer<Currency> {
        dataBinding.fromValue = it
    }

    private val toValueObserver = Observer<Currency> {
        dataBinding.toValue = it
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        dataBinding = DataBindingUtil.inflate(
            inflater,
            R.layout.fragment_home,
            container,
            false
        )

        return dataBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupViewModel()
        setupBanner()
        setupCardListeners()
        checkArguments()
    }

    private fun checkArguments() {
        arguments?.let {
            val id = HomeFragmentArgs.fromBundle(it).currencyId
            val currencyDestination = HomeFragmentArgs.fromBundle(it).currencyDestination
            Log.e("currencyId", id.toString())
            if (id > 0) {
                if (currencyDestination == Constants.currencyDestinationFrom) {
                    viewModel.updateFromCurrency(id)
                } else {
                    viewModel.updateToCurrency(id)
                }
            }
        }
    }

    private fun setupCardListeners() {
        dataBinding.fromCard.setOnClickListener(View.OnClickListener {
            val action = HomeFragmentDirections.actionCurrencies(Constants.currencyDestinationFrom)
            Navigation.findNavController(it).navigate(action)
        })

        dataBinding.toCard.setOnClickListener(View.OnClickListener {
            val action = HomeFragmentDirections.actionCurrencies(Constants.currencyDestinationTo)
            Navigation.findNavController(it).navigate(action)
        })
    }

    private fun setupViewModel() {
        viewModel = ViewModelProviders.of(this).get(HomeViewModel::class.java)
        viewModel.bannerText.observe(viewLifecycleOwner, bannerTextObserver)
        viewModel.lastUpdateText.observe(viewLifecycleOwner, lastUpdateTextObserver)
        viewModel.fromValue.observe(viewLifecycleOwner, fromValueObserver)
        viewModel.toValue.observe(viewLifecycleOwner, toValueObserver)
    }

    private fun setupBanner() {
        dataBinding.banner.isSelected = true
    }
}