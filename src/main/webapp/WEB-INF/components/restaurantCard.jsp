<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="restaurant-card" id="restaurant-card-template"
	style="display: none">


	<div class="card-img-wrap">
		<img src="" alt="" class="rc-img"> <span
			class="card-badge rc-badge" style="display: none"></span>
	</div>

	<div class="card-body">
		<div class="card-top">
			<div class="card-name rc-name"></div>
			<div class="card-rating rc-rating"></div>
		</div>
		<div class="card-address">
			<span class="card-icon">&#128205;</span> <span class="rc-address"></span>
		</div>
		<div class="card-contact">
			<span class="card-icon">&#128222;</span> <span class="rc-contact"></span>
		</div>
		<div class="price-dots">
			<div class="price-dot rc-dot-1"></div>
			<div class="price-dot rc-dot-2"></div>
			<div class="price-dot rc-dot-3"></div>
		</div>
		<div class="card-btns">
			<a href="#" class="btn-outline rc-menu">View Menu</a> <a href="#"
				class="btn-solid rc-book">Book Table</a>
		</div>
	</div>
</div>

