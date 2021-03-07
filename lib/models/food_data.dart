// To parse this JSON data, do
//
//     final foodData = foodDataFromJson(jsonString);

import 'dart:convert';

List<FoodData> foodDataFromJson(String str) => List<FoodData>.from(json.decode(str).map((x) => FoodData.fromJson(x)));

String foodDataToJson(List<FoodData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodData {
    FoodData({
        this.id,
        this.foodAmountGr,
        this.locationId,
        this.longitude,
        this.latitude,
        this.prediction,
    });

    int id;
    double foodAmountGr;
    int locationId;
    double longitude;
    double latitude;
    double prediction;

    factory FoodData.fromJson(Map<String, dynamic> json) => FoodData(
        id: json["id"],
        foodAmountGr: json["Food_Amount_gr"],
        locationId: json["Location_Id"],
        longitude: json["Longitude"].toDouble(),
        latitude: json["Latitude"].toDouble(),
        prediction: json["Prediction"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Food_Amount_gr": foodAmountGr,
        "Location_Id": locationId,
        "Longitude": longitude,
        "Latitude": latitude,
        "Prediction": prediction,
    };
}
