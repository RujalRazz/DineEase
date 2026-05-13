package com.rujal.controller;

import com.rujal.dao.CityDao;
import com.rujal.dao.RestaurantDao;
import com.rujal.model.City;
import com.rujal.model.Restaurant;
import com.rujal.util.PaginationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * AdminRestaurantController handles all CRUD operations
 */
@WebServlet("/adminRestaurants")
public class AdminRestaurantController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// DAO instances
	private RestaurantDao restaurantDao = new RestaurantDao();
	private CityDao cityDao = new CityDao();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminRestaurantController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// Check admin session — redirect to login if not authenticated
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("admin") == null) {
			response.sendRedirect(request.getContextPath() + "/admin-login");
			return;
		}

		// ── Pagination ──
		int pageSize = PaginationUtil.ADMIN_PAGE_SIZE;
		int totalCount = restaurantDao.countRestaurants();
		int totalPages = PaginationUtil.getTotalPages(totalCount, pageSize);
		int currentPage = PaginationUtil.clampPage(PaginationUtil.parsePage(request.getParameter("page")), totalPages);
		int offset = PaginationUtil.getOffset(currentPage, pageSize);

		// ── Fetch paginated data ──
		List<Restaurant> restaurants = restaurantDao.getAllRestaurantsPaginated(pageSize, offset);
		List<City> cities = cityDao.getAllCities();
		Map<Integer, String> cityFilterMap = restaurantDao.getDistinctCitiesFromRestaurants();

		// ── Flash messages ──
		String successMessage = (String) session.getAttribute("successMessage");
		String errorMessage = (String) session.getAttribute("errorMessage");
		session.removeAttribute("successMessage");
		session.removeAttribute("errorMessage");

		request.setAttribute("restaurants", restaurants);
		request.setAttribute("cities", cities);
		request.setAttribute("cityFilterMap", cityFilterMap);
		request.setAttribute("successMessage", successMessage);
		request.setAttribute("errorMessage", errorMessage);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("totalPages", totalPages);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("activeAdmin", "restaurants");

		request.getRequestDispatcher("/WEB-INF/pages/admin/adminRestaurants.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// Check admin session
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("admin") == null) {
			response.sendRedirect(request.getContextPath() + "/admin-login");
			return;
		}
		String action = request.getParameter("action");

		if (action == null) {
			response.sendRedirect(request.getContextPath() + "/adminRestaurants");
			return;
		}
		switch (action) {
		case "add":
			handleAdd(request, response);
			break;
		case "edit":
			handleEdit(request, response);
			break;
		case "delete":
			handleDelete(request, response);
			break;
		default:
			response.sendRedirect(request.getContextPath() + "/adminRestaurants");
		}

	}

	private void handleAdd(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		try {
			// Build restaurant from form data
			Restaurant r = buildRestaurantFromRequest(request);

			// Insert into database
			boolean success = restaurantDao.addRestaurant(r);

			if (success) {
				request.getSession().setAttribute("successMessage", "Restaurant added successfully!");
			} else {
				request.getSession().setAttribute("errorMessage", "Failed to add restaurant. Please try again.");
			}
		} catch (Exception e) {
			request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
		}

		response.sendRedirect(request.getContextPath() + "/adminRestaurants");
	}

	private void handleEdit(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		try {
			int restaurantId = Integer.parseInt(request.getParameter("restaurant_id"));

			// Build restaurant from form data
			Restaurant r = buildRestaurantFromRequest(request);
			r.setRestaurantId(restaurantId);

			// Update in database
			boolean success = restaurantDao.updateRestaurant(r);

			if (success) {
				request.getSession().setAttribute("successMessage", "Restaurant updated successfully!");
			} else {
				request.getSession().setAttribute("errorMessage", "Failed to update restaurant. Please try again.");
			}
		} catch (Exception e) {
			request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
		}

		response.sendRedirect(request.getContextPath() + "/adminRestaurants");
	}

	/**
	 * Reads restaurant_id from form, calls DAO to delete from database.
	 */
	private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {

		try {
			int restaurantId = Integer.parseInt(request.getParameter("restaurant_id"));
			boolean success = restaurantDao.deleteRestaurant(restaurantId);

			if (success) {
				request.getSession().setAttribute("successMessage", "Restaurant deleted successfully!");
			} else {
				request.getSession().setAttribute("errorMessage", "Failed to delete restaurant. Please try again.");
			}
		} catch (Exception e) {
			request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
		}

		response.sendRedirect(request.getContextPath() + "/adminRestaurants");
	}

	private Restaurant buildRestaurantFromRequest(HttpServletRequest request) {
		Restaurant r = new Restaurant();
		r.setCityId(Integer.parseInt(request.getParameter("city_id")));
		r.setName(request.getParameter("name"));
		r.setAddress(request.getParameter("address"));
		r.setContact(request.getParameter("contact"));
		r.setDescription(request.getParameter("description"));
		r.setImageUrl(request.getParameter("image_url"));
		r.setRating(Double.parseDouble(request.getParameter("rating")));
		r.setPriceRange(Integer.parseInt(request.getParameter("price_range")));

		// Badge — set to null if "none" selected
		String badge = request.getParameter("badge");
		r.setBadge(badge != null && !badge.equals("none") ? badge : null);

		return r;
	}

}
