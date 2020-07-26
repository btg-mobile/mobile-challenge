package com.example.myapplication.features.coinsconverterlist

import android.content.Intent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.myapplication.R
import javax.inject.Inject

class CoinsConverterListAdapter
    @Inject constructor(private var activity: CoinsConverterListActivity, private var coinsListKey: ArrayList<String>, private var coinsListValue: ArrayList<String?>) : RecyclerView.Adapter<CoinsConverterListAdapter.ViewHolder>() {

    private var filteredListKey: ArrayList<String>? = null
    private var filteredListValue: ArrayList<String>? = null

    override fun onCreateViewHolder(view: ViewGroup, position: Int): ViewHolder {
        val v = LayoutInflater.from(view.context).inflate(R.layout.adapter_coins_converter_list, view, false)
        return ViewHolder(
            v
        )
    }
    override fun getItemCount(): Int {
        return coinsListKey.size
    }
    override fun onBindViewHolder(view: ViewHolder, position: Int) {
        view.tv_code.text = "Moeda: " + coinsListKey[position]
        view.tv_country.text = "País: " + coinsListValue[position]

        view.coinsItem.setOnClickListener {
            val intent = Intent()
            intent.putExtra("key", coinsListKey[position])
            activity.setResult(2, intent)
            activity.finish()
        }
    }

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val tv_code: TextView = itemView.findViewById(R.id.tv_code)
        val tv_country: TextView = itemView.findViewById(R.id.tv_country)
        val coinsItem: LinearLayout = itemView.findViewById(R.id.coinsItem)
    }
}
