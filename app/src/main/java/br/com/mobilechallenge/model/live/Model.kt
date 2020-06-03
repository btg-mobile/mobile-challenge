package br.com.mobilechallenge.model.live

import java.text.MessageFormat

import br.com.mobilechallenge.model.PriceDAO
import br.com.mobilechallenge.model.bean.ListBean
import br.com.mobilechallenge.model.bean.LiveBean
import br.com.mobilechallenge.model.enums.Endpoints

import org.json.JSONObject

import com.android.volley.RequestQueue

import br.com.mobilechallenge.presenter.live.MVP
import br.com.mobilechallenge.utils.Constantes
import br.com.mobilechallenge.utils.Utils
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley

class Model(private val presenter: MVP.Presenter): MVP.Model {
    private lateinit var requestQueue: RequestQueue

    override fun retrieveData(codeFrom: ListBean?, codeTo: ListBean?, amount: Double) {
        presenter.showProgressBar(true)
        if (Utils.isInternetConnect(presenter.context)) {
            val currencies = "${codeFrom?.code},${codeTo?.code}"
            val wsEndpoint: String = Endpoints.LIVE.endpoint()
            val uri: String = MessageFormat.format(wsEndpoint, Constantes.accessKey, currencies)
            val baseUrl: String = Constantes.baseURL + uri
            val requestQueue: RequestQueue = Volley.newRequestQueue(presenter.context)

            val request = JsonObjectRequest(
                Request.Method.GET,
                baseUrl,
                null,
                Response.Listener {
                    val quotes = JSONObject(it.getString("quotes"))
                    val valueFrom: Double = quotes.getDouble("USD${codeFrom?.code}")
                    val valueTo: Double = quotes.getDouble("USD${codeTo?.code}")
                    val calcFrom: Double = amount * valueFrom
                    val calcTo: Double = calcFrom * valueTo

                    saveLive(0, codeFrom?.id, codeFrom?.code, valueFrom)
                    saveLive(0, codeTo?.id, codeTo?.code, valueTo)

                    presenter.resultCalc(calcTo)
                    presenter.showProgressBar(false)
                },
                null
            )

            requestQueue.add(request)
        }
        else {
            val repository = PriceDAO(presenter.context)
            val itemFrom: LiveBean? = repository.get(codeFrom?.id)
            val itemTo: LiveBean?   = repository.get(codeTo?.id)

            repository.close()

            val calcFrom: Double = amount * itemFrom!!.price
            val calcTo: Double   = calcFrom * itemTo!!.price

            presenter.resultCalc(calcTo)
            presenter.showProgressBar(false)
        }
    }

    private fun saveLive(id: Int, idCurrencies: Int?, code: String?, price: Double) {
        val bean = LiveBean(id, idCurrencies, code, price)
        val repository = PriceDAO(presenter.context)
            repository.save(bean)
            repository.close()
    }
}