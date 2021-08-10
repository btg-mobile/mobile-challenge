package br.com.alanminusculi.btgchallenge.data.local

import android.content.Context
import androidx.room.Room

/**
 * Created by Alan Minusculi on 10/08/2021.
 */

class DatabaseHelper {

    companion object {
        private const val dbName = "dados"

        fun getAppDatabase(context: Context): AppDatabase {
            return Room.databaseBuilder(context, AppDatabase::class.java, dbName).build()
        }
    }
}