package com.rujal.controller;

import com.rujal.dao.CityDao;
import com.rujal.dao.RestaurantDao;
import com.rujal.model.City;
import com.rujal.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
/**
 * RestaurantController handles GET requests for the restaurant listing page.
 * Reads city and price filter params from the URL,
 * fetches filtered data from the database,
 * and passes it to restaurant.jsp for rendering.
 */
@WebServlet("/restaurants")
public class RestaurantController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RestaurantDao restaurantDao = new RestaurantDao();
    private CityDao cityDao = new CityDao();
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RestaurantController() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * Handles GET requests.
     * Reads ?city= and ?price= URL parameters,
     * fetches matching restaurants and all cities,
     * passes them to restaurant.jsp.
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String cityParam  = request.getParameter("city");
        String priceSort  = request.getParameter("price");
        int cityId = 0;
        if (cityParam != null && !cityParam.isEmpty() && !cityParam.equals("all")) {
            try {
                cityId = Integer.parseInt(cityParam);
            } 
            catch (NumberFormatException e) {
            	cityId = 0;
            }
        }
        List<Restaurant> restaurants = restaurantDao.getRestaurants(cityId, priceSort);
        List<City> cities = cityDao.getAllCities();
        request.setAttribute("restaurants", restaurants);
        request.setAttribute("cities", cities);
        request.setAttribute("selectedCity", cityId);
        request.setAttribute("selectedPrice", priceSort != null ? priceSort : "");
        request.getRequestDispatcher("/WEB-INF/pages/restaurant/restaurant.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
