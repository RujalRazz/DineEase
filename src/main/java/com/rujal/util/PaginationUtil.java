package com.rujal.util;

public class PaginationUtil {

	// Default items per page
	public static final int ADMIN_PAGE_SIZE = 10;
	public static final int RESTAURANT_PAGE_SIZE = 6;

	public static int parsePage(String pageParam) {
		if (pageParam == null || pageParam.trim().isEmpty()) {
			return 1;
		}
		try {
			int page = Integer.parseInt(pageParam.trim());
			return page < 1 ? 1 : page;
		} catch (NumberFormatException e) {
			return 1;
		}
	}

	/**
	 * Calculates the SQL OFFSET for a given page and page size.
	 */
	public static int getOffset(int page, int pageSize) {
		return (page - 1) * pageSize;
	}

	/**
	 * Calculates the total number of pages.
	 */
	public static int getTotalPages(int totalRecords, int pageSize) {
		if (totalRecords == 0)
			return 1;
		return (int) Math.ceil((double) totalRecords / pageSize);
	}

	/**
	 * Clamps the current page between 1 and totalPages.
	 */
	public static int clampPage(int page, int totalPages) {
		if (page < 1)
			return 1;
		if (page > totalPages)
			return totalPages;
		return page;
	}
}