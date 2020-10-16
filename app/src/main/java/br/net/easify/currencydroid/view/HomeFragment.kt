package br.net.easify.currencydroid.view

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import br.net.easify.currencydroid.R
import br.net.easify.currencydroid.viewmodel.HomeViewModel
import kotlinx.android.synthetic.main.fragment_home.*


class HomeFragment : Fragment() {

    private lateinit var viewModel: HomeViewModel

    private val bannerTextObserver = Observer<String> {
        if (it.isNotEmpty()) {
            info.visibility = View.VISIBLE
            banner.visibility = View.VISIBLE
            banner.text = it
        } else {
            info.visibility = View.GONE
            banner.visibility = View.GONE
        }
    }

    private val lastUpdateTextObserver = Observer<String> {
        if (it.isNotEmpty()) {
            lastUpdate.visibility = View.VISIBLE
            lastUpdate.text = "LAST UPDATE: " + it
        } else {
            lastUpdate.visibility = View.GONE
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        viewModel = ViewModelProviders.of(this).get(HomeViewModel::class.java)

        return inflater.inflate(R.layout.fragment_home, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel.bannerText.observe(viewLifecycleOwner, bannerTextObserver)
        viewModel.lastUpdateText.observe(viewLifecycleOwner, lastUpdateTextObserver)

        banner.isSelected = true
    }

}