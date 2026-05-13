<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int pCurrentPage = (Integer) request.getAttribute("currentPage");
int pTotalPages = (Integer) request.getAttribute("totalPages");
int pTotalCount = (Integer) request.getAttribute("totalCount");
String pBaseUrl = (String) request.getAttribute("baseUrl");
if (pBaseUrl == null)
	pBaseUrl = "";

// Determine separator character for URL params
String sep = pBaseUrl.contains("?") ? "&" : "?";
%>

<%
if (pTotalPages > 1) {
%>
<div class="pagination-wrapper">

	<%-- Record count info --%>
	<div class="pagination-info">
		Showing page
		<%=pCurrentPage%>
		of
		<%=pTotalPages%>
		&nbsp;·&nbsp;
		<%=pTotalCount%>
		total records
	</div>

	<%-- Pagination controls --%>
	<div class="pagination-controls">

		<%-- Previous button --%>
		<%
		if (pCurrentPage > 1) {
		%>
		<a
			href="${pageContext.request.contextPath}<%= pBaseUrl + sep + "page=" + (pCurrentPage - 1) %>"
			class="page-btn page-prev"> &#8592; Previous </a>
		<%
		} else {
		%>
		<span class="page-btn page-prev disabled"> &#8592; Previous </span>
		<%
		}
		%>

		<%-- Page number buttons --%>
		<div class="page-numbers">
			<%
			for (int i = 1; i <= pTotalPages; i++) {
			%>
			<%
			if (i == pCurrentPage) {
			%>
			<span class="page-num active"><%=i%></span>
			<%
			} else {
			%>
			<a
				href="${pageContext.request.contextPath}<%= pBaseUrl + sep + "page=" + i %>"
				class="page-num"> <%=i%>
			</a>
			<%
			}
			%>
			<%
			}
			%>
		</div>

		<%-- Next button --%>
		<%
		if (pCurrentPage < pTotalPages) {
		%>
		<a
			href="${pageContext.request.contextPath}<%= pBaseUrl + sep + "page=" + (pCurrentPage + 1) %>"
			class="page-btn page-next"> Next &#8594; </a>
		<%
		} else {
		%>
		<span class="page-btn page-next disabled"> Next &#8594; </span>
		<%
		}
		%>

	</div>
</div>
<%
}
%>