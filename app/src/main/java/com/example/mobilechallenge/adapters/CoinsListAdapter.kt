package com.example.mobilechallenge.adapters

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.mobilechallenge.R
import kotlinx.android.synthetic.main.coin_list_item.view.*

class CoinsListAdapter(private val context: Context, private var listener: CoinItemOnClickListener) :
    RecyclerView.Adapter<CoinsListAdapter.CoinViewHolder>() {

    private val mCoinsKeyList = ArrayList<String>()
    private val mCoinsValueList = ArrayList<String>()

    interface CoinItemOnClickListener {

        fun onClick(coinCode: String)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CoinViewHolder =
        CoinViewHolder(LayoutInflater.from(context).inflate(R.layout.coin_list_item, parent, false))

    override fun getItemCount(): Int = mCoinsKeyList.size

    override fun onBindViewHolder(holder: CoinViewHolder, position: Int) {
        holder.coinCode.text = mCoinsKeyList[position]
        holder.coinName.text = mCoinsValueList[position]
        holder.coinItemDivider.visibility = if (mCoinsKeyList.lastIndex == position) View.GONE else View.VISIBLE
    }

    fun addCoinsList(coinsKeyList: ArrayList<String>, coinsValueList: ArrayList<String>) {
        mCoinsKeyList.addAll(coinsKeyList)
        mCoinsValueList.addAll(coinsValueList)
        notifyDataSetChanged()
    }

    inner class CoinViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView), View.OnClickListener {
        val coinContent: LinearLayout = itemView.ll_coin_item_content
        val coinCode: TextView = itemView.tv_coin_code
        val coinName: TextView = itemView.tv_coin_name
        val coinItemDivider: View = itemView.v_coin_divider

        init {
            coinContent.setOnClickListener(this)
        }

        override fun onClick(v: View?) {
            listener.onClick(mCoinsKeyList[adapterPosition])
        }
    }
}