package com.example.mobile_challenge.ui.main

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.OnBackPressedDispatcher
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.mobile_challenge.MainActivity
import com.example.mobile_challenge.R
import com.example.mobile_challenge.model.Currency


class SelectionFragment : Fragment(), OnItemClickListener {

  companion object {
    fun newInstance() = SelectionFragment()
  }

  private val viewModel: MainViewModel by activityViewModels()
  private lateinit var root: View
  private lateinit var recyclerView: RecyclerView
  private lateinit var type: String
  private lateinit var code: String
  private lateinit var mainActivity : MainActivity
  private val adapter: CurrencyAdapter by lazy { CurrencyAdapter(ArrayList(), this) }

  override fun onCreateView(
    inflater: LayoutInflater, container: ViewGroup?,
    savedInstanceState: Bundle?
  ): View {
    root = inflater.inflate(R.layout.selection_fragment, container, false)
    recyclerView = root.findViewById(R.id.currency_list)
    mainActivity = activity as MainActivity
    type = arguments?.getString("TYPE")!!
    code = arguments?.getString("CODE")!!
    setupRecyclerView()
    return root
  }

  private fun setupRecyclerView() {
    val layoutManager = LinearLayoutManager(context)
    recyclerView.layoutManager = layoutManager
    recyclerView.adapter = adapter
    setupItemsRecyclerView()
  }

  private fun setupItemsRecyclerView() {
    val list = viewModel.currencyList
    adapter.setItemsAdapter(list)
    val item = list.find { it.currencyCode == code }
    item?.let { currency ->
      recyclerView.scrollToPosition(list.indexOf(currency))
    }
  }

  override fun onItemClicked(item: Currency) {
    mainActivity.showProgressBar(true)
    if (type == "FROM") {
      viewModel.getCurrencyValue(item.currencyCode, "FROM")
    } else {
      viewModel.getCurrencyValue(item.currencyCode, "TO")
    }
    closeFragment()
  }

  private fun closeFragment() {
    val dispatcher: OnBackPressedDispatcher = requireActivity().onBackPressedDispatcher
    dispatcher.onBackPressed()
  }

}
