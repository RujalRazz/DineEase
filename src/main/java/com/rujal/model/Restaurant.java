package com.rujal.model;

/**
 * Restaurant model maps the restaurants table in the database.
 */

public class Restaurant {
	private int restaurantId;
	private int cityId;
	private String name;
	private String address;
	private String contact;
	private String description;
	private String imageUrl;
	private double rating;
	private int priceRange;
	private String badge;

	public Restaurant(int restaurantId, int cityId, String name, String address, String contact, String description,
			String imageUrl, double rating, int priceRange, String badge) {
		this.restaurantId = restaurantId;
		this.cityId = cityId;
		this.name = name;
		this.address = address;
		this.contact = contact;
		this.description = description;
		this.imageUrl = imageUrl;
		this.rating = rating;
		this.priceRange = priceRange;
		this.badge = badge;
	}

	public Restaurant() {
		// TODO Auto-generated constructor stub
	}

	public int getRestaurantId() {
		return restaurantId;
	}

	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}

	public int getCityId() {
		return cityId;
	}

	public void setCityId(int cityId) {
		this.cityId = cityId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	public int getPriceRange() {
		return priceRange;
	}

	public void setPriceRange(int priceRange) {
		this.priceRange = priceRange;
	}

	public String getBadge() {
		return badge;
	}

	public void setBadge(String badge) {
		this.badge = badge;
	}
}