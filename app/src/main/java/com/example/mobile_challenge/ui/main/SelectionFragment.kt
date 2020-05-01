package com.example.mobile_challenge.ui.main

import android.graphics.Color
import android.os.Bundle
import android.view.*
import android.widget.EditText
import android.widget.ImageView
import androidx.activity.OnBackPressedDispatcher
import androidx.appcompat.widget.SearchView
import androidx.core.content.ContextCompat
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
    setHasOptionsMenu(true)
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

  override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
    searchBarFilter(menu, inflater)
    super.onCreateOptionsMenu(menu, inflater)
  }

  private fun searchBarFilter(menu: Menu, inflater: MenuInflater) {
    inflater.inflate(R.menu.search, menu)
    val searchItem = menu.findItem(R.id.action_search)
    val searchView = searchItem.actionView as SearchView
    searchView.setBackgroundColor(Color.WHITE)
    searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
      override fun onQueryTextSubmit(query: String?): Boolean {
        return true
      }

      override fun onQueryTextChange(newText: String?): Boolean {
        setOnQueryTextChange(newText)
        return false
      }
    })
    val editText = searchView.findViewById<EditText>(androidx.appcompat.R.id.search_src_text)
    editText.setHintTextColor(Color.LTGRAY)
    editText.setTextColor(ContextCompat.getColor(context!!, R.color.colorPrimaryDark))
    val cleanIcon = searchView.findViewById<ImageView>(androidx.appcompat.R.id.search_close_btn)
    cleanIcon.setColorFilter(ContextCompat.getColor(context!!, R.color.colorPrimaryDark))
  }

  fun setOnQueryTextChange(newText: String?) {
    adapter.filter.filter(newText)
  }

}
