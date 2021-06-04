package com.example.exchange.utils

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.exchange.R
import com.example.exchange.model.Coin

class CoinAdapter(private val listCoins: List<Coin>) : RecyclerView.Adapter<CoinAdapter.ViewHolder>() {

    inner class ViewHolder(listItemView: View) : RecyclerView.ViewHolder(listItemView) {
        val abbreviation: TextView = itemView.findViewById(R.id.textview_abbreviation)
        val description: TextView = itemView.findViewById(R.id.textview_description)

    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CoinAdapter.ViewHolder {
        return ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.list_coin, parent, false))
    }

    override fun onBindViewHolder(viewHolder: CoinAdapter.ViewHolder, position: Int) {
        val coin: Coin = listCoins[position]

        viewHolder.abbreviation.text = coin.abbreviation
        viewHolder.description.text = coin.description
    }

    override fun getItemCount(): Int {
        return listCoins.size
    }
}