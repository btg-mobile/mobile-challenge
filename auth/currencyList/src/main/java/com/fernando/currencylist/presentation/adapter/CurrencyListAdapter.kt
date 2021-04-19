package com.fernando.currencylist.presentation.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.fernando.currencylist.R
import com.fernando.currencylist.model.CurrencyViewItem

class CurrencyListAdapter(private val currencyList: List<CurrencyViewItem>) :
    RecyclerView.Adapter<CurrencyListAdapter.ViewHolder>() {

    inner class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val initialsView = view.findViewById<TextView>(R.id.initials)
        val countryNameView = view.findViewById<TextView>(R.id.country)
    }

    override fun onCreateViewHolder(viewGroup: ViewGroup, viewType: Int) = ViewHolder(
        LayoutInflater.from(viewGroup.context)
            .inflate(R.layout.item_currency_list, viewGroup, false)
    )


    override fun onBindViewHolder(viewHolder: ViewHolder, position: Int) {
        with(viewHolder) {
            initialsView.text = currencyList[position].initials
            countryNameView.text = currencyList[position].countryName
        }
    }

    override fun getItemCount() = currencyList.size
}