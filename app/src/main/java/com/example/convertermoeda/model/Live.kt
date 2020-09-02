package com.example.convertermoeda.model

import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName

data class Live(
    @SerializedName("success") val success: Boolean?,
    @SerializedName("terms") val terms: String?,
    @SerializedName("privacy") val privacy: String?,
    @SerializedName("timestamp") val timestamp: Int?,
    @SerializedName("source") val source: String?,
    @SerializedName("quotes") val quotes: HashMap<String, String>?
) : Parcelable {
    constructor(source: Parcel) : this(
        source.readValue(Boolean::class.java.classLoader) as Boolean?,
        source.readString(),
        source.readString(),
        source.readValue(Int::class.java.classLoader) as Int?,
        source.readString(),
        source.readSerializable() as HashMap<String, String>?
    )

    override fun describeContents() = 0

    override fun writeToParcel(dest: Parcel, flags: Int) = with(dest) {
        writeValue(success)
        writeString(terms)
        writeString(privacy)
        writeValue(timestamp)
        writeString(source)
        writeSerializable(quotes)
    }

    companion object {
        @JvmField
        val CREATOR: Parcelable.Creator<Live> = object : Parcelable.Creator<Live> {
            override fun createFromParcel(source: Parcel): Live = Live(source)
            override fun newArray(size: Int): Array<Live?> = arrayOfNulls(size)
        }
    }
}