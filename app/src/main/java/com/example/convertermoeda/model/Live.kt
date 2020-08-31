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
    @SerializedName("quotes") val quotes: Quotes?
) : Parcelable {
    constructor(source: Parcel) : this(
        source.readValue(Boolean::class.java.classLoader) as Boolean?,
        source.readString(),
        source.readString(),
        source.readValue(Int::class.java.classLoader) as Int?,
        source.readString(),
        source.readParcelable<Quotes>(
            Quotes::class.java.classLoader)
    )

    override fun describeContents() = 0

    override fun writeToParcel(dest: Parcel, flags: Int) = with(dest) {
        writeValue(success)
        writeString(terms)
        writeString(privacy)
        writeValue(timestamp)
        writeString(source)
        writeParcelable(quotes, 0)
    }

    companion object {
        @JvmField
        val CREATOR: Parcelable.Creator<Live> = object : Parcelable.Creator<Live> {
            override fun createFromParcel(source: Parcel): Live =
                Live(source)
            override fun newArray(size: Int): Array<Live?> = arrayOfNulls(size)
        }
    }
}

data class Quotes(
    @SerializedName("USDUSD") val uSDUSD: Int?,
    @SerializedName("USDAUD") val uSDAUD: Double?,
    @SerializedName("USDCAD") val uSDCAD: Double?,
    @SerializedName("USDPLN") val uSDPLN: Double?,
    @SerializedName("USDMXN") val uSDMXN: Double?
) : Parcelable {
    constructor(source: Parcel) : this(
        source.readValue(Int::class.java.classLoader) as Int?,
        source.readValue(Double::class.java.classLoader) as Double?,
        source.readValue(Double::class.java.classLoader) as Double?,
        source.readValue(Double::class.java.classLoader) as Double?,
        source.readValue(Double::class.java.classLoader) as Double?
    )

    override fun describeContents() = 0

    override fun writeToParcel(dest: Parcel, flags: Int) = with(dest) {
        writeValue(uSDUSD)
        writeValue(uSDAUD)
        writeValue(uSDCAD)
        writeValue(uSDPLN)
        writeValue(uSDMXN)
    }

    companion object {
        @JvmField
        val CREATOR: Parcelable.Creator<Quotes> = object : Parcelable.Creator<Quotes> {
            override fun createFromParcel(source: Parcel): Quotes =
                Quotes(source)
            override fun newArray(size: Int): Array<Quotes?> = arrayOfNulls(size)
        }
    }
}