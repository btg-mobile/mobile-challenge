package com.btg.converter.data.local

import androidx.room.TypeConverter
import com.btg.converter.data.local.entity.DbQuote
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

class DataConverter {

    @TypeConverter
    fun fromDbQuoteList(value: List<DbQuote>): String {
        val gson = Gson()
        val type = object : TypeToken<List<DbQuote>>() {}.type
        return gson.toJson(value, type)
    }

    @TypeConverter
    fun toDbQuoteList(value: String): List<DbQuote> {
        val gson = Gson()
        val type = object : TypeToken<List<DbQuote>>() {}.type
        return gson.fromJson(value, type)
    }
}
