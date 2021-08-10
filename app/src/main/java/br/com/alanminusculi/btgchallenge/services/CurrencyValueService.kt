package br.com.alanminusculi.btgchallenge.services

import android.content.Context
import br.com.alanminusculi.btgchallenge.data.converters.CurrencyValueConverter
import br.com.alanminusculi.btgchallenge.data.local.DatabaseHelper
import br.com.alanminusculi.btgchallenge.data.local.daos.CurrencyValueDao
import br.com.alanminusculi.btgchallenge.data.local.models.CurrencyValue
import br.com.alanminusculi.btgchallenge.data.remote.api.Api
import br.com.alanminusculi.btgchallenge.data.remote.api.ApiHelper
import br.com.alanminusculi.btgchallenge.data.remote.dtos.LiveDTO
import br.com.alanminusculi.btgchallenge.exceptions.ApiException
import br.com.alanminusculi.btgchallenge.utils.Constants.Companion.USD_PREFIX
import java.io.IOException

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

class CurrencyValueService(applicationContext: Context) {

    private var dao: CurrencyValueDao? = null
    private var api: Api? = null

    init {
        dao = DatabaseHelper.getAppDatabase(applicationContext).getCurrencyValueDao()
        api = ApiHelper.getApi()
    }

    @Throws(ApiException::class)
    fun sync() {
        try {
            val liveDTO: LiveDTO? = api!!.live()!!.execute().body()
            if (liveDTO?.quotes != null) {
                val currencyValues: List<CurrencyValue> = CurrencyValueConverter().dtoToModel(liveDTO)
                dao!!.replaceAll(*currencyValues.toTypedArray())
            }
        } catch (e: IOException) {
            throw ApiException("Não foi possível atualizar a cotação das moedas.")
        }
    }

    //Todas as cotações são calculadas a partir do dólar americano
    fun findOne(query: String): CurrencyValue {
        return dao!!.findOneByCurrency(USD_PREFIX + query)
    }
}