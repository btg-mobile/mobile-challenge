package com.example.challengesavio

import android.app.Application
import androidx.room.Room
import com.example.roomdatabase.database.AppDatabase

class MyApplication : Application() {

    companion object{
        var database : AppDatabase? = null
    }

    override fun onCreate() {
        super.onCreate()

//        Room
        database= Room.databaseBuilder(this, AppDatabase::class.java, "my_db").allowMainThreadQueries().build()

    }
}