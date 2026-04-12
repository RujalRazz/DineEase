package com.rujal.model;

public class City {
	private int cityId;
    private String cityName;
    private String restaurantCount;
    private String imageUrl;
    private String cityValue;
    
    public City() {
    	
    }
    
    public City(int cityId, String cityName, String restaurantCount, String imageUrl, String cityValue) {
    	this.cityId = cityId;
    	this.cityName = cityName;
    	this.restaurantCount = restaurantCount;
    	this.imageUrl = imageUrl;
    	this.cityValue = cityValue;
    }

	public int getCityId() {
		return cityId;
	}

	public void setCityId(int cityId) {
		this.cityId = cityId;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getRestaurantCount() {
		return restaurantCount;
	}

	public void setRestaurantCount(String restaurantCount) {
		this.restaurantCount = restaurantCount;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getCityValue() {
		return cityValue;
	}

	public void setCityValue(String cityValue) {
		this.cityValue = cityValue;
	}
    
    
}