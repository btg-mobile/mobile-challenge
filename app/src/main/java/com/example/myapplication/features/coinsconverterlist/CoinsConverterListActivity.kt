package com.example.myapplication.features.coinsconverterlist

import android.view.View
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.myapplication.R
import com.example.myapplication.core.extension.hidePogressBar
import com.example.myapplication.core.extension.showAlertDialog
import com.example.myapplication.core.extension.showProgressBar
import com.example.myapplication.core.plataform.BaseActivity
import com.example.myapplication.core.plataform.Constants
import com.example.myapplication.core.plataform.Internet
import com.example.myapplication.core.repository.CoinsConverterListRepository

class CoinsConverterListActivity : BaseActivity(), CoinsConverterInterface {

    private var recyclerView: RecyclerView?=null
    private var rootView: View?=null

    override fun setLayout() {
        setContentView(R.layout.activity_converter_coins_list)
        setHomeAsUp()
    }

    override fun setObjects() {
        recyclerView = findViewById(R.id.recycler_view)
        rootView = window.decorView.rootView
        showProgressBar(view = rootView!!)
        loadList()
    }

    private fun loadList(){
        if(Internet().isInternetAvailable(this)) {
            val url = Constants.urlList
            val coinsConverterRepository = CoinsConverterListRepository(context = this, url = url)
            coinsConverterRepository.startRequest(this)
        }else{
            rootView?.let { hidePogressBar(it) }
            showAlertDialog(this, getString(R.string.title_failed_to_show_data))
        }
    }

    override fun onValidateRequestSuccess(result: CoinsConverterListResult) {
        rootView?.let { hidePogressBar(it) }
        val mapSorted = result.currencies.toSortedMap()
        val coinsKey = ArrayList(mapSorted.keys)
        val coinsValue = ArrayList(mapSorted.values)

        val llm = LinearLayoutManager(this)
        llm.orientation = LinearLayoutManager.VERTICAL
        recyclerView?.layoutManager = llm
        val adapter = CoinsConverterListAdapter(activity = this, coinsListKey = coinsKey, coinsListValue = coinsValue)
        recyclerView!!.isClickable = true
        recyclerView?.adapter = adapter
    }

    override fun onValidateRequestFail(message: String?, error: Boolean) {
        showAlertDialog(this, getString(R.string.title_failed_to_show_data))
    }
}