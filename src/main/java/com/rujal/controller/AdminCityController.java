package com.rujal.controller;

import com.rujal.dao.CityDao;
import com.rujal.model.City;
import com.rujal.util.PaginationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * AdminCityController handles all CRUD operations for Cities
 */
@WebServlet("/adminCities")
public class AdminCityController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CityDao cityDao = new CityDao();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminCityController() {
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
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("admin") == null) {
			response.sendRedirect(request.getContextPath() + "/admin-login");
			return;
		}
		// ── Pagination ──
		int pageSize = PaginationUtil.ADMIN_PAGE_SIZE;
		int totalCount = cityDao.countAllCities();
		int totalPages = PaginationUtil.getTotalPages(totalCount, pageSize);
		int currentPage = PaginationUtil.clampPage(PaginationUtil.parsePage(request.getParameter("page")), totalPages);
		int offset = PaginationUtil.getOffset(currentPage, pageSize);

		List<City> cities = cityDao.getCitiesPaginated(pageSize, offset);

		String successMessage = (String) session.getAttribute("successMessage");
		String errorMessage = (String) session.getAttribute("errorMessage");
		session.removeAttribute("successMessage");
		session.removeAttribute("errorMessage");

		request.setAttribute("cities", cities);
		request.setAttribute("successMessage", successMessage);
		request.setAttribute("errorMessage", errorMessage);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("totalPages", totalPages);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("activeAdmin", "cities");

		request.getRequestDispatcher("/WEB-INF/pages/admin/adminCities.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("admin") == null) {
			response.sendRedirect(request.getContextPath() + "/admin-login");
			return;
		}

		String action = request.getParameter("action");

		if (action == null) {
			response.sendRedirect(request.getContextPath() + "/adminCities");
			return;
		}

		switch (action) {
		case "add":
			handleAdd(request, response);
			break;
		case "update": // Matches the hidden input value in the JSP modal
			handleUpdate(request, response);
			break;
		case "delete":
			handleDelete(request, response);
			break;
		default:
			response.sendRedirect(request.getContextPath() + "/adminCities");
		}
	}

	private void handleAdd(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			// Build city from form data
			City city = buildCityFromRequest(request);

			// Insert into database (CityDao throws Exception on failure/duplicates)
			cityDao.addCity(city);

			request.getSession().setAttribute("successMessage", "City added successfully!");
		} catch (Exception e) {
			request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
		}

		response.sendRedirect(request.getContextPath() + "/adminCities");
	}

	private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			int cityId = Integer.parseInt(request.getParameter("city_id"));

			// Build city from form data
			City city = buildCityFromRequest(request);
			city.setCityId(cityId);

			// Update in database
			cityDao.updateCity(city);

			request.getSession().setAttribute("successMessage", "City updated successfully!");
		} catch (Exception e) {
			request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
		}

		response.sendRedirect(request.getContextPath() + "/adminCities");
	}

	private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			int cityId = Integer.parseInt(request.getParameter("city_id"));

			// Delete from database
			cityDao.deleteCity(cityId);

			request.getSession().setAttribute("successMessage", "City deleted successfully!");
		} catch (Exception e) {
			request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
		}

		response.sendRedirect(request.getContextPath() + "/adminCities");
	}

	private City buildCityFromRequest(HttpServletRequest request) {
		City city = new City();
		city.setCityName(request.getParameter("city_name"));
		city.setCityValue(request.getParameter("city_value"));
		city.setImageUrl(request.getParameter("image_url"));
		return city;
	}

}
