package com.example.convertermoeda.model

import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName

data class ListMoeda(
    @SerializedName("success") val success: Boolean?,
    @SerializedName("terms") val terms: String?,
    @SerializedName("privacy") val privacy: String?,
    @SerializedName("currencies") val currencies: HashMap<String, String>?
) : Parcelable {
    constructor(source: Parcel) : this(
        source.readValue(Boolean::class.java.classLoader) as Boolean?,
        source.readString(),
        source.readString(),
        source.readSerializable() as HashMap<String, String>?
    )

    override fun describeContents() = 0

    override fun writeToParcel(dest: Parcel, flags: Int) = with(dest) {
        writeValue(success)
        writeString(terms)
        writeString(privacy)
        writeSerializable(currencies)
    }

    companion object {
        @JvmField
        val CREATOR: Parcelable.Creator<ListMoeda> = object : Parcelable.Creator<ListMoeda> {
            override fun createFromParcel(source: Parcel): ListMoeda = ListMoeda(source)
            override fun newArray(size: Int): Array<ListMoeda?> = arrayOfNulls(size)
        }
    }
}

