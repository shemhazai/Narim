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
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:400,700&subset=latin,latin-ext'
	rel='stylesheet' type='text/css'>
<style>
h1, h2, h3, h4, h5, h6 {
	font-family: 'Open Sans', sans-serif;
	border: none;
}

.modal-footer-left {
	float: left;
}

.modal-footer-right {
	float: right;
}

.responsive {
	box-sizing: border-box;
	overflow: auto;
	position: absolute;
}

.canvas-wrapper {
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
}

#canvas {
	padding: 0;
	margin: auto;
	display: block;
	width: 0;
	height: 0;
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	box-sizing: border-box;
}
</style>
</head>
<body>

	<div class="modal fade" id="modalDialog" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title" id="modalTitle"></h4>
				</div>
				<div class="modal-body" id="modalBody"></div>
				<div class="modal-footer">
					<div class="modal-footer-left" id="modalFooter"></div>
					<div class="modal-footer-right">
						<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="responsive canvas-wrapper">
		<canvas id='canvas' width="0" height="0"></canvas>
	</div>

	<script src="${path}/resources/js/jquery-2.1.4.min.js"></script>
	<script src="${path}/resources/js/modernizr.js"></script>
	<script src="${path}/resources/js/bootstrap.min.js"></script>
	<script src="${path}/resources/jscolor/jscolor.js"></script>
	<script src="${path}/resources/js/resource-loader.js"></script>
	<script src="${path}/resources/js/image-manager.js"></script>
	<script src="${path}/resources/js/audio-manager.js"></script>
	<script>
		window.loader = new ResourceLoader();
		window.imageManager = new ImageManager('${path}');
		window.audioManager = new AudioManager('${path}');
	</script>
	<script src="${path}/resources/js/controller/texture.js"></script>
	<script src="${path}/resources/js/type/bullet.js"></script>
	<script src="${path}/resources/js/type/wall.js"></script>
	<script src="${path}/resources/js/type/tree.js"></script>
	<script src="${path}/resources/js/type/house.js"></script>
	<script src="${path}/resources/js/type/vehicle.js"></script>
	<script src="${path}/resources/js/controller/cannon.js"></script>
	<script src="${path}/resources/js/type/turret.js"></script>
	<script src="${path}/resources/js/type/tank.js"></script>
	<script src="${path}/resources/js/type/player.js"></script>
	<script src="${path}/resources/js/controller/animation.js"></script>
	<script src="${path}/resources/js/type/destroy-animation.js"></script>
	<script src="${path}/resources/js/type/explosion-animation.js"></script>
	<script src="${path}/resources/js/parse-battlefield.js"></script>

	<script src="${path}/resources/js/controller/battlefield.js"></script>


	<script>
		$(document)
				.ready(
						function() {

							var canvas = document.getElementById('canvas');
							var context = canvas.getContext('2d');

							var battlefield = new Battlefield();

							var $modalDialog = $('#modalDialog');
							var $modalTitle = $('#modalTitle');
							var $modalBody = $('#modalBody');
							var $modalFooter = $('#modalFooter');

							function isError() {
								var attr = window.location.search.substring(1);
								var index = attr.indexOf('id=');

								if (index == -1)
									return true;

								var id = attr.substring(index + 3, attr.length);

								if (id.length == 0)
									return true;

								if (isNaN(id))
									return true;

								return id < 0;
							}

							if (isError()) {
								$modalTitle.empty();
								$modalBody.empty();
								$modalFooter.empty();

								$modalTitle.append('Błąd');
								$modalBody
										.append('<p>Ups! Nie powinieneś się tu znaleźć... </p>');
								$modalFooter
										.append('<a href="${path}/">Wróć na stronę główną</a>');

								$modalDialog.modal('show');
							} else
								window.loader.setCallback(getJSON);

							function getJSON() {

								var url = window.location.search.substring(1);
								var index = url.lastIndexOf('=');
								var id = url.substring(index + 1);

								$
										.ajax({
											type : "POST",
											url : "${path}/get",
											data : {
												'id' : id
											},
											success : function(data) {
												var board = JSON.parse(data);

												if (board.blank) {
													$modalTitle.empty();
													$modalBody.empty();
													$modalFooter.empty();

													$modalTitle.append('Błąd');
													$modalBody
															.append('<p>Ups! Próbujesz grać na nieistniejącej mapie... </p>');
													$modalFooter
															.append('<a href="${path}/">Wróć na stronę główną</a>');

													$modalDialog.modal('show');
													return;
												}

												battlefield = parseBattlefield(board.json);
												init();
											}
										});
							}

							var requestAnimationFrame;
							var lastTime;
							var mouse = {
								x : 0,
								y : 0
							}

							function init() {
								var width = battlefield.getWidth();
								var height = battlefield.getHeight();

								canvas.setAttribute('height', height);
								canvas.setAttribute('width', width);
								$(canvas).css('width', width);
								$(canvas).css('height', height);

								requestAnimationFrame = getSupportedRequestAnimationFrame();
								lastTime = Date.now();

								var player = battlefield.player;
								if (player != null) {
									$(window).keydown(keyDown);
									$(window).keyup(keyUp);
									$(window).keypress(keyPress);
									$(window).mousemove(mouseMove);
									$(window).mousedown(mouseDown);
									setInterval(function() {
										if (player != null)
											player.aim(getMousePosition());
									}, 1000 / 30);

									$('body').css('cursor', 'crosshair');
								}

								battlefield.onWin = onWin;
								battlefield.onLoose = onLoose;

								main();
							}

							function getSupportedRequestAnimationFrame() {
								return window.requestAnimationFrame
										|| window.webkitRequestAnimationFrame
										|| window.mozRequestAnimationFrame
										|| window.oRequestAnimationFrame
										|| window.msRequestAnimationFrame
										|| function(callback) {
											window.setTimeout(callback,
													1000 / 60);
										};
							}

							function onWin() {
								$('body').css('cursor', 'default');
								$('#canvas').css('cursor', 'crosshair');

								$modalTitle.empty();
								$modalBody.empty();
								$modalFooter.empty();

								$modalTitle.append('Wygrałeś');
								$modalBody
										.append('<p>Brawo... ale może to było za proste? Tak, dobrze myślisz.</p>');
								$modalBody
										.append('<p><a href="${path}/edit?id='
												+ getId()
												+ '">Edytuj tę mapę!</a>');
								$modalFooter
										.append('<a href="${path}/">Wróć na stronę główną</a>');

								$modalDialog.modal('show');
							}

							function onLoose() {
								$('body').css('cursor', 'default');

								$modalTitle.empty();
								$modalBody.empty();
								$modalFooter.empty();

								$modalTitle.append('Przegrałeś');
								$modalBody
										.append('<p>Niestety, musisz jeszcze troszkę poćwiczyć...</p>');
								$modalBody
										.append('<p>Teraz będzie lepiej... <a href="${path}/play?id='
												+ getId()
												+ '">Graj jeszcze raz</a>.');
								$modalFooter
										.append('<a href="${path}/">Wróć na stronę główną</a>');

								$modalDialog.modal('show');
							}

							function getId() {
								var url = window.location.search.substring(1);
								var index = url.lastIndexOf('=');
								return url.substring(index + 1);
							}

							function main() {
								var now = Date.now();
								var dt = (now - lastTime) / 1000.0;

								battlefield.update(dt);
								battlefield.renderAll(canvas);
								battlefield.renderEnergyHint(context);

								lastTime = now;
								requestAnimationFrame(main);
							}

							function keyDown(evt) {
								var code = evt.keyCode;

								var code = evt.keyCode;
								var player = battlefield.player;
								if (player == null)
									return;
								if (code == 37 || code == 65) {

									player.setLeftPressed(true);
									player.setRightPressed(false);
								} else if (code == 38 || code == 87) {
									player.setUpPressed(true);
									player.setDownPressed(false);
								} else if (code == 39 || code == 68) {
									player.setRightPressed(true);
									player.setLeftPressed(false);
								} else if (code == 40 || code == 83) {
									player.setDownPressed(true);
									player.setUpPressed(false);
								}
							}

							function keyUp(evt) {
								var code = evt.keyCode;
								var player = battlefield.player;
								if (player == null)
									return;

								if (code == 37 || code == 65) {
									player.setLeftPressed(false);
								} else if (code == 38 || code == 87) {
									player.setUpPressed(false);
								} else if (code == 39 || code == 68) {
									battlefield.player.setRightPressed(false);
								} else if (code == 40 || code == 83) {
									player.setDownPressed(false);
								}
							}

							function keyPress(evt) {
								var player = battlefield.player;
								if (player == null)
									return;
								if (evt.keyCode == 32 && player.canFire())
									battlefield.addBullet(player.fire());
							}

							function mouseMove(evt) {
								mouse.x = evt.clientX;
								mouse.y = evt.clientY;
							}

							function mouseDown(evt) {
								mouse.x = evt.clientX;
								mouse.y = evt.clientY;

								var player = battlefield.player;
								if (player == null)
									return;

								player.aim(getMousePosition());
								if (player.canFire())
									battlefield.addBullet(player.fire());
							}

							function getMousePosition() {
								var rect = canvas.getBoundingClientRect();
								return {
									x : mouse.x - rect.left,
									y : mouse.y - rect.top
								};
							}

						});
	</script>
</body>
</html>
