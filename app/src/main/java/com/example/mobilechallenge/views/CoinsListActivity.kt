package com.example.mobilechallenge.views

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.mobilechallenge.R
import com.example.mobilechallenge.adapters.CoinsListAdapter
import com.example.mobilechallenge.models.CoinsListResponse
import com.example.mobilechallenge.services.RetrofitInitializer
import com.example.mobilechallenge.utils.Constants
import com.google.android.material.dialog.MaterialAlertDialogBuilder
import kotlinx.android.synthetic.main.activity_coins_list.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class CoinsListActivity : AppCompatActivity(), CoinsListAdapter.CoinItemOnClickListener {

    private lateinit var mAdapter: CoinsListAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_coins_list)

        pb_coins_loading.visibility = View.VISIBLE
        rv_coins_list.visibility = View.GONE

        mAdapter = CoinsListAdapter(this, this)
        getCoinsList()
    }

    private fun getCoinsList() {
        val service = RetrofitInitializer().getRemoteServices()
        val call = service.coinsList(Constants.ACCESS_KEY)

        call.enqueue(object : Callback<CoinsListResponse> {
            override fun onFailure(call: Call<CoinsListResponse>, t: Throwable) {
                MaterialAlertDialogBuilder(this@CoinsListActivity)
                    .setTitle("Atenção")
                    .setMessage("Houve um problema. Tente novamente em instantes.")
                    .setPositiveButton("OK", null)
                    .show()
            }

            override fun onResponse(call: Call<CoinsListResponse>, response: Response<CoinsListResponse>) {
                response.let {
                    if (it.isSuccessful) {
                        val keys = ArrayList<String>()
                        val values = ArrayList<String>()

                        for (key in it.body()?.currencies!!.keys) {
                            keys.add(key)
                            values.add(it.body()?.currencies!![key]!!)
                        }

                        mAdapter.addCoinsList(keys, values)
                        rv_coins_list.adapter = mAdapter
                        rv_coins_list.layoutManager =
                            LinearLayoutManager(this@CoinsListActivity, RecyclerView.VERTICAL, false)

                        pb_coins_loading.visibility = View.GONE
                        rv_coins_list.visibility = View.VISIBLE
                    }
                }
            }

        })
    }

    override fun onClick(coinCode: String) {
        val intent = Intent(this, MainActivity::class.java)
        intent.putExtra(Constants.COIN_CODE_EXTRA, coinCode)
        setResult(Activity.RESULT_OK, intent)
        finish()
    }
}
