<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="pl">
<head>
<title>Narim | Stwórz własną grę!</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${path}/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="${path}/resources/css/bootstrap-theme.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #555555;
}

.board {
	width: 50px;
	height: 50px;
	background-color: yellow;
	border: 2px solid black;
	box-sizing: border-box;
	float: left;
	margin: 3px 3px 3px 3px;
}

.blank {
	background-color: #888888;
}

.modal-footer-left {
	float: left;
}

.modal-footer-right {
	float: right;
}
</style>
</head>
<body>
	<div class="masonry">
		<c:forEach var="board" items="${listBoard}" varStatus="status">
			<c:choose>
				<c:when test="${not board.blank}">
					<a href="${path}/play?id=${board.id}" class="board"></a>
				</c:when>

				<c:otherwise>
					<a href="${path}/create?id=${board.id}" class="board blank"></a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>

	<div class="modal fade" id="modalDialog" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"></h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<div class="modal-footer-left"></div>
					<div class="modal-footer-right">
						<button type="button" class="btn btn-default" id="buttonApprove">Tak</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Nie</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="${path}/resources/js/jquery-2.1.4.min.js"></script>
	<script src="${path}/resources/js/masonry.pkgd.min.js"></script>
	<script src="${path}/resources/js/bootstrap.min.js"></script>
	<script>
		$(document).ready(function() {
			$('.masonry').masonry();

			$('a').click(function(evt) {
				evt.preventDefault();
				var href = $(this).attr('href');
				var index = href.indexOf('id=');
				var idString = href.substring(index + 3, href.length);
				var id = parseInt(idString);

				if (href.indexOf('play') != -1)
					showPlayModal(id);
				else
					showCreateModal(id);

			});

			var $modal = $('#modalDialog');
			var $modalTitle = $('.modal-title');
			var $modalBody = $('.modal-body');
			var $modalButton = $('#buttonApprove');
			var $modalAuthor = $('.modal-footer-left');

			function showPlayModal(id) {

				clearModal();
				$modalTitle.append('Wczytywanie mapy...');
				$modalBody.append('<p>Proszę czekać, gra jest wczytywana.</p>');
				$modal.modal('show');

				$.ajax({
					type : "POST",
					url : "${path}/get",
					data : {
						'id' : id
					},
					success : function(data) {
						var board = JSON.parse(data);

						clearModal();
						$modalTitle.append(board.name);
						$modalBody.append('<p>' + board.description + '</p>');
						$modalBody.append('<h4>Czy chcesz zagrać na tej mapie?</h4>');
						$modalBody.append('<p>Autor: ' + board.author + '</p>');
						var $a = $('<a></a>');
						$a.append('Edytuj');
						var href = '${path}/edit?id=' + id;
						$a.attr('href', href)
						$modalAuthor.append($a);
						$modalButton.click(function() {
							$modal.modal('hide');
							window.location = '${path}/play?id=' + id;
						});

						$modal.modal('show');
					}
				});
			}

			function showCreateModal(id) {
				clearModal();

				$modalTitle.append('Tworzenie nowej mapy');
				$modalBody.append('<p>Czy chcesz utworzyć nową mapę?</p>');
				$modalAuthor.append('<p>ID: ' + id + '</p>');
				$modalButton.click(function() {
					$modal.modal('hide');
					window.location = '${path}/create?id=' + id;
				});

				$modal.modal('show');

			}

			function clearModal() {
				$modalTitle.empty();
				$modalBody.empty();
				$modalAuthor.empty();
			}
		});
	</script>
</body>
</html>
