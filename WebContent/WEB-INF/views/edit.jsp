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

/* COMMON */
.selected {
	-webkit-box-shadow: 0px 0px 5px 3px rgba(0, 26, 255, 1) !important;
	-moz-box-shadow: 0px 0px 5px 3px rgba(0, 26, 255, 1) !important;
	box-shadow: 0px 0px 5px 3px rgba(0, 26, 255, 1) !important;
}

h1, h2, h3, h4, h5, h6 {
	font-family: 'Open Sans', sans-serif;
	border: none;
}

html {
	box-sizing: border-box;
}

body {
	width: 100%;
	margin: 0 0;
	padding: 0 0;
	/* Hides scroll bar */
	overflow: hidden;
}

.responsive {
	box-sizing: border-box;
	overflow: auto;
	position: absolute;
}

.left-panel {
	background-color: #eeeeee;
}

.input-group {
	margin-left: 10px;
	margin-bottom: 10px;
	display: block;
}

.input-group label {
	margin-right: 7px;
}

.panel {
	background-color: #eeeeee;
	display: block;
	clear: both;
	border: none;
}

.panel h2 {
	font-size: 2em;
	margin-left: 10px;
	margin-bottom: 15px;
}

.panel small {
	font-size: 0.7em;
	margin-left: 7px;
}

.panel a, .panel img {
	margin-left: 10px;
	margin-bottom: 10px;
	-webkit-box-shadow: 0px 0px 3px 1px rgba(0, 0, 0, 1);
	-moz-box-shadow: 0px 0px 3px 1px rgba(0, 0, 0, 1);
	box-shadow: 0px 0px 3px 1px rgba(0, 0, 0, 1);
	display: block;
	float: left;
	cursor: pointer;
}

.panel ul {
	list-style: none;
	margin: 0 0;
	margin-left: 20px;
	padding: 0 0;
}

.panel li {
	list-style-type: none;
	margin-left: 15px;
	margin-bottom: 7px;
}

.panel li a {
	display: inline;
	float: none;
	color: #000000;
	box-shadow: none;
	clear: both;
}

.panel li button {
	font-size: 1em;
	background-color: rgba(0, 0, 0, 0);
	border: none;
	box-shadow: none;
	margin-right: 10px;
	float: right;
}

.right-panel {
	background-color: #eeeeee;
}

.right-panel label {
	margin-left: 10px;
}

.right-panel input {
	margin-right: 10px;
	width: 35%;
	float: right;
}

@media all and (min-width: 960px) {
	.left-panel {
		width: 20%;
		height: 100%;
		top: 0;
		left: 0;
		border-right: 5px solid #000000;
	}
	.right-panel {
		width: 20%;
		height: 100%;
		top: 0;
		left: 80%;
		border-left: 5px solid #000000;
	}
	.canvas-wrapper {
		width: 60%;
		height: 100%;
		top: 0;
		left: 20%;
	}
}

@media all and (max-width: 959px) {
	.left-panel {
		width: 50%;
		height: 40%;
		top: 60%;
		left: 0;
		border-right: 2px solid #000000;
		border-top: 5px solid #000000;
	}
	.right-panel {
		width: 50%;
		height: 40%;
		top: 60%;
		left: 50%;
		border-left: 2px solid #000000;
		border-top: 5px solid #000000;
	}
	.canvas-wrapper {
		width: 100%;
		height: 60%;
		top: 0;
		left: 0%;
	}
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
}

button.set-as-player {
	margin-top: 7px;
	margin-left: 10px;
}

button.save-map {
	margin-top: 7px;
	margin-left: 35px;
}

.modal-footer-left {
	float: left;
}

.modal-footer-right {
	float: right;
}

#mapDescription {
	display: block;
}
</style>
</head>
<body>

	<div class="responsive left-panel">
		<div class="panel">
			<h2>Rozmiar mapy</h2>
			<div class="input-group">
				<label for="canvasWidth" title="Podaj szerokość mapy.">
					Szerokość mapy:</label> <input name="canvasWidth" type="number" min="1"
					step="1" placeholder="szerokość" title="Podaj szerokość mapy."
					autocomplete="off" required>
			</div>
			<div class="input-group">
				<label for="canvasHeight" title="Podaj wysokość mapy.">
					Wysokość mapy:</label> <input name="canvasHeight" type="number" min="1"
					step="1" placeholder="szerokość" title="Podaj wysokość mapy."
					autocomplete="off" required>
			</div>
		</div>
	</div>
	<div class="responsive right-panel">
		<div class="panel save-panel">
			<button class="btn btn-default save-map">Zapisz mapę!</button>
		</div>
		<div class="panel selected-object"></div>
		<div class="object-list"></div>
	</div>
	<div class="responsive canvas-wrapper">
		<canvas id='canvas' width="0" height="0"></canvas>
	</div>

	<div class="modal fade" id="modalDialog" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Zapisywanie mapy</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="mapName" title="Wpisz nazwę mapy.">Nazwa mapy:</label>
						<input id="mapName" class="form-control" type="text"
							title="Wpisz nazwę mapy." maxlength="16" autocomplete="off">
					</div>

					<div class="form-group">
						<label for="mapDescription" title="Wpisz opis mapy.">Opis
							mapy:</label>
						<textarea rows="6" id="mapDescription" class="form-control"
							title="Wpisz opis mapy." maxlength="256"></textarea>
					</div>

					<div class="form-group">
						<label for="mapAuthor" title="Wpisz swoją nazwę.">Autor:</label> <input
							id="mapAuthor" class="form-control" type="text" maxlength="32"
							title="Wpisz swoją nazwę." autocomplete="off">
					</div>

				</div>
				<div class="modal-footer">
					<div class="modal-footer-left"></div>
					<div class="modal-footer-right">
						<button type="button" class="btn btn-default" id="buttonApprove">Zapisz</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Anuluj</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="infoModalDialog" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title" id="infoModalTitle"></h4>
				</div>
				<div class="modal-body" id="infoModalBody"></div>
				<div class="modal-footer">
					<div class="modal-footer-left" id="infoAuthor"></div>
					<div class="modal-footer-right">
						<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
					</div>
				</div>
			</div>
		</div>
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
	<script src="${path}/resources/js/parse-battlefield.js"></script>

	<script src="${path}/resources/js/controller/battlefield.js"></script>
	<script>
		$(document)
				.ready(
						function() {
							window.loader = new ResourceLoader();
							window.imageManager = new ImageManager('${path}');

							var canvas = document.getElementById('canvas');
							var context = canvas.getContext('2d');

							var battlefield = new Battlefield();
							var selectedObject = null;
							var dragging = false;

							var option = "${option}";

							function isError() {
								var attr = window.location.search.substring(1);
								var index = attr.indexOf('id=');

								if (index == -1)
									return true;

								var id = attr.substring(index + 3, attr.length);

								if (isNaN(id))
									return true;

								if (id < 0)
									return true;

								return option != 'create' && option != 'edit';
							}

							var $infoModalDialog = $('#infoModalDialog');
							var $infoModalTitle = $('#infoModalTitle');
							var $infoModalBody = $('#infoModalBody');
							var $infoAuthor = $('#infoAuthor');

							if (isError()) {
								$('.left-panel').hide();
								$('.right-panel').hide();

								$infoModalTitle.empty();
								$infoModalBody.empty();
								$infoAuthor.empty();

								$infoModalTitle.append('Błąd');
								$infoModalBody.append('<p>Ups! Nie powinieneś się tu znaleźć... </p>');
								$infoAuthor.append('<a href="${path}">Wróć na stronę główną.</a>');

								$infoModalDialog.modal('show');
							} else if (option == 'create')
								window.loader.setCallback(checkMap);
							else if (option == 'edit')
								window.loader.setCallback(loadMap);
							else
								alert('To nie powinno się zdarzyć!');

							function loadMap() {
								loadBoard(onload);

								function onload(board) {
									if (board.blank) {
										$('.left-panel').hide();
										$('.right-panel').hide();

										$infoModalTitle.empty();
										$infoModalBody.empty();
										$infoAuthor.empty();

										$infoModalTitle.append('Błąd');
										$infoModalBody.append('<p>Ups! Próbujesz edytować nieistniejącą mapę... </p>');
										$infoAuthor.append('<a href="${path}">Wróć na stronę główną.</a>');

										$infoModalDialog.modal('show');
										return;
									}

									battlefield = parseBattlefield(board.json);

									$('input[name="canvasWidth"]').val(battlefield.width);
									canvas.setAttribute('width', battlefield.width);
									$(canvas).css('width', battlefield.width);

									$('input[name="canvasHeight"]').val(battlefield.height);
									canvas.setAttribute('height', battlefield.height);
									$(canvas).css('height', battlefield.height);

									init();
								}
							}

							function checkMap() {

								loadBoard(onload);

								function onload(board) {
									if (!board.blank) {
										$('.left-panel').hide();
										$('.right-panel').hide();

										$infoModalTitle.empty();
										$infoModalBody.empty();
										$infoAuthor.empty();

										$infoModalTitle.append('Błąd');
										$infoModalBody
												.append('<p>Ups! Próbujesz tworzyć mapę, która już istnieje... </p>');
										$infoAuthor.append('<a href="${path}/edit?id=' + getId()
												+ '">Przejdź do edycji mapy.</a>');

										$infoModalDialog.modal('show');
									} else
										init();

								}
							}

							function loadBoard(onload) {
								$.ajax({
									type : "POST",
									url : "${path}/get",
									data : {
										'id' : getId(),
									},
									success : function(data) {
										var board = JSON.parse(data);
										onload(board);
									}
								});
							}

							function getId() {
								var url = window.location.search.substring(1);
								var index = url.lastIndexOf('=');
								return url.substring(index + 1);
							}

							function init() {
								addObjectsToLeftPanel();
								addHandlers();
								update();
								requestAnimationFrame = getSupportedRequestAnimationFrame();
								main();
							}

							function addObjectsToLeftPanel() {
								addBackgroundObjects();
								addWallObjects();
								addTreeObjects();
								addHouseObjects();
								addVehicleObjects();
								addEnemyObjects();
							}

							function addBackgroundObjects() {
								var div = $('<div></div>');
								div.addClass('panel');
								div.append('<h2>Tło mapy</h2>');

								var im = window.imageManager;
								var images = im.getAll('background');

								for ( var i in images) {
									var image = images[i];
									var $object = $('<img>');
									$object.attr('src', image.src);
									$object.attr('width', 50);
									$object.attr('height', 50);
									$object.click(function() {
										$('.panel .selected').removeClass('selected');
										$(this).addClass('selected');
										var src = $(this).attr('src');
										var index = src.lastIndexOf('/');
										var name = src.substring(index + 1, src.length - 4);
										battlefield.setBackground(name);
									});

									var src = image.src;
									var bg = battlefield.background;
									if (bg.length > 0 && src.indexOf(bg) != -1)
										$object.addClass('selected');
									div.append($object);
								}

								$('.left-panel').append(div);
							}

							function addWallObjects() {
								var div = createPanel('Materiały', 'wall', false);
								$('.left-panel').append(div);
							}

							function addHouseObjects() {
								var div = createPanel('Budynki', 'house', true);
								$('.left-panel').append(div);
							}

							function addTreeObjects() {
								var div = createPanel('Drzewa', 'tree', true);
								$('.left-panel').append(div);
							}

							function addVehicleObjects() {
								var div = createPanel('Pojazdy', 'vehicle', true);
								$('.left-panel').append(div);
							}

							function addEnemyObjects() {
								var div = createPanel('Enemies', 'turret', true);

								var im = window.imageManager;
								var image = im.get('tank51');

								var $object = $('<img>');
								var url = 'url(' + image.src + ')';

								$object.attr('src', image.src);
								$object.attr('width', 50);
								$object.attr('height', 50);

								$object.mousedown(function(evt) {
									evt.preventDefault();

									var im = window.imageManager;
									var type = 51;
									var name = 'tank' + type;
									var image = im.get(name);

									var object = new Tank();

									object.setX(Math.round(canvas.width / 2));
									object.setY(Math.round(canvas.height / 2));
									object.setWidth(Math.round(image.width));
									object.setHeight(Math.round(image.height));
									object.setType(type);

									battlefield.addTank(object);

									update();
								});
								div.append($object);

								$('.left-panel').append(div);
							}

							function createPanel(title, content, imageSizeBased) {
								var div = $('<div></div>');
								div.addClass('panel');
								div.append('<h2>' + title + '</h2>');

								var im = window.imageManager;
								var images = im.getAll(content);

								for ( var i in images) {
									var image = images[i];
									var $object = $('<img>');
									var url = 'url(' + image.src + ')';

									$object.attr('src', image.src);
									$object.attr('width', 50);
									$object.attr('height', 50);

									$object.mousedown(function(evt) {
										evt.preventDefault();

										var src = $(this).attr('src');
										var index = src.lastIndexOf('.');
										var type = src.substring(index - 2, index);

										var im = window.imageManager;
										var name = content + type;
										var image = im.get(name);

										var object;

										if (type < 10)
											object = new Wall();
										else if (type < 20)
											object = new Tree();
										else if (type < 30)
											object = new House();
										else if (type < 40)
											object = new Vehicle();
										else if (type < 50)
											object = new Turret;
										else
											object = new Tank();

										object.setX(Math.round(canvas.width / 2));
										object.setY(Math.round(canvas.height / 2));

										object.setType(type);

										if (type > 10) {
											object.setWidth(Math.round(image.width));
											object.setHeight(Math.round(image.height));
										} else {
											object.setWidth(Math.round(canvas.width / 5));
											object.setHeight(Math.round(canvas.height / 5));
										}

										if (type <= 40)
											battlefield.addTexture(object);
										else if (type <= 50)
											battlefield.addTurret(object);
										else if (type <= 60)
											battlefield.addTank(object);
										else if (type <= 70)
											battlefield.setPlayer(object);

										update();
									});
									div.append($object);
								}

								return div;
							}

							function addHandlers() {
								$('input[name="canvasWidth"]').change(function() {
									var width = $(this).val();
									battlefield.setWidth(width);
									canvas.setAttribute('width', width);
									$(canvas).css('width', width);
									update();
								});

								$('input[name="canvasHeight"]').change(function() {
									var height = $(this).val();
									battlefield.setHeight(height);
									canvas.setAttribute('height', height);
									$(canvas).css('height', height);
									update();
								});

								function start(evt) {
									var point;

									if (evt.offsetX) {
										point = {
											x : evt.offsetX,
											y : evt.offsetY
										};
									} else {
										var $canvasOffset = $('#canvas').offset();
										point = {
											x : evt.pageX - $canvasOffset.left,
											y : evt.pageY - $canvasOffset.top
										};
									}

									var objects = [];
									if (battlefield.getPlayer())
										objects = objects.concat([ battlefield.getPlayer() ]);
									objects = objects.concat(getFlippedArray(battlefield.getTanks()));
									objects = objects.concat(getFlippedArray(battlefield.getTurrets()));
									objects = objects.concat(getFlippedArray(battlefield.getTextures()));

									function getTarget() {
										for ( var i in objects) {
											var object = objects[i];
											if (object.hasPoint(point))
												return object;
										}
										return null;
									}

									selectedObject = getTarget();
									if (selectedObject != null)
										dragging = true;
									else
										dragging = false;
									update();

								}

								function end(evt) {
									dragging = false;
								}

								function move(evt) {
									var point;

									if (evt.offsetX) {
										point = {
											x : evt.offsetX,
											y : evt.offsetY
										};
									} else {
										var $canvasOffset = $('#canvas').offset();
										point = {
											x : evt.pageX - $canvasOffset.left,
											y : evt.pageY - $canvasOffset.top
										};
									}

									var objects = battlefield.getTextures();
									objects = objects.concat(battlefield.getTanks());
									objects = objects.concat(battlefield.getTurrets());
									if (battlefield.getPlayer())
										objects = objects.concat([ battlefield.getPlayer() ]);

									function getTarget() {
										for ( var i in objects) {
											var object = objects[i];
											if (object.hasPoint(point))
												return object;
										}
										return null;
									}

									if (getTarget() == null)
										$(canvas).css('cursor', 'default');
									else
										$(canvas).css('cursor', 'pointer');

									if (dragging) {
										selectedObject.setX(point.x);
										selectedObject.setY(point.y);
										update();
									}

								}

								$(canvas).mousedown(start);
								$(canvas).mouseup(end);
								$(canvas).mousemove(move);

								$('.save-map')
										.click(
												function() {
													var $modal = $('#modalDialog');
													var $modalButton = $('#buttonApprove');

													$modalButton
															.click(function() {
																$modal.modal('hide');
																var url = window.location.search.substring(1);
																var index = url.lastIndexOf('=');

																var id = url.substring(index + 1);
																var mapName = $('#mapName').val();
																var mapAuthor = $('#mapAuthor').val();
																var mapDescription = $('#mapDescription').val();
																var json = JSON.stringify(battlefield);

																$infoModalTitle.empty();
																$infoModalTitle.append('Trwa zapisywanie...');
																$infoModalBody.empty();
																$infoModalBody
																		.append('<p>Trwa zapisywanie mapy w bazie danych. Proszę czekać.</p>');

																$
																		.ajax({
																			type : "POST",
																			url : "${path}/update",
																			data : {
																				'id' : id,
																				'name' : mapName,
																				'author' : mapAuthor,
																				'description' : mapDescription,
																				'json' : json
																			},
																			success : function(data) {
																				$infoModalTitle.empty();
																				$infoModalTitle
																						.append('Zapisano pomyślnie');
																				$infoModalBody.empty();
																				$infoModalBody
																						.append('<p>Przygotowana przez Ciebie mapa została zapisana w bazie danych.'
																								+ ' Możesz na niej zagrać pod <a href="${path}/play?id='
																								+ id
																								+ '">tym adresem</a>.');
																			}
																		});
																$infoModalDialog.modal('show');
															});

													$modal.modal('show');
												});
							}

							function update() {
								updateObjectList();
								updateSelected();
							}

							function render() {
								battlefield.renderAll(canvas, window.imageManager);
								if (selectedObject != null) {
									context.strokeStyle = 'rgba(0, 198, 255, 0.4)';

									if (selectedObject.getType() < 10) {
										var w = selectedObject.getWidth();
										var h = selectedObject.getHeight();
										var x = selectedObject.getX() - w / 2 - 5;
										var y = selectedObject.getY() - h / 2 - 5;

										context.beginPath();
										context.rect(x, y, w + 10, h + 10);
										context.stroke();
									} else {
										var x = selectedObject.getX();
										var y = selectedObject.getY();
										var w = selectedObject.getWidth() / 2;
										var h = selectedObject.getHeight() / 2;
										var radius = Math.sqrt(w * w + h * h);

										context.beginPath();
										context.arc(x, y, radius, 0, 2 * Math.PI, false);
										context.lineWidth = 5;
										context.stroke();
									}

								}
							}

							function getFlippedArray(arr) {
								var n = [];
								for (var i = arr.length - 1; i >= 0; i--)
									n.push(arr[i]);
								return n;
							}

							var requestAnimationFrame;

							function getSupportedRequestAnimationFrame() {
								return window.requestAnimationFrame || window.webkitRequestAnimationFrame
										|| window.mozRequestAnimationFrame || window.oRequestAnimationFrame
										|| window.msRequestAnimationFrame || function(callback) {
											window.setTimeout(callback, 1000 / 60);
										};
							}

							function main() {
								render();
								requestAnimationFrame(main);
							}

							function updateObjectList() {
								var $div = $('.object-list');
								$div.empty();

								function createList(title, objectLabel, objects, src) {
									var $panel = $('<div></div>');
									$panel.addClass('panel');

									$panel.append('<h2>' + title + '</h2>');
									var $list = $('<ul></ul>');

									for ( var i in objects) {
										var object = objects[i];
										var $listItem = $('<li></li>');

										var label = parseLabel(object);

										var $a = $('<a></a>');
										$a.text(label);
										$a.attr('href', src);
										$a.attr('title', 'Edytuj obiekt');
										$a.click(function(evt) {
											evt.preventDefault();
											var href = $(this).attr('href');
											var text = $(this).text();
											var startIndex = text.indexOf('[');

											var obj;
											if (startIndex == -1) {
												obj = battlefield[href];
											} else {
												var endIndex = text.indexOf(']');
												var number = text.substring(startIndex + 1, endIndex);
												obj = battlefield[href][number];
											}

											selectedObject = obj;
											update();
										});
										$listItem.append($a);

										var $button = $('<button></button>');
										$button.attr('type', 'button');
										$button.attr('src', src);
										$button.attr('href', label);
										$button.attr('title', 'Usuń obiekt');
										$button.append('&times;');

										$button.click(function(evt) {
											var src = $(this).attr('src');
											var text = $(this).attr('href');
											var startIndex = text.indexOf('[');

											var obj;

											if (startIndex == -1) {
												obj = battlefield[src];
												battlefield[src] = null;
											} else {
												var endIndex = text.indexOf(']');
												var number = text.substring(startIndex + 1, endIndex);
												obj = battlefield[src][number];
												var type = obj.getType();
												if (type < 40)
													battlefield.removeTexture(obj);
												else if (type < 50)
													battlefield.removeTurret(obj);
												else if (type < 60)
													battlefield.removeTank(obj);
											}

											if (obj == selectedObject)
												selectedObject = null;

											update();
										});
										$listItem.append($button);

										$list.append($listItem);
									}
									$panel.append($list);
									return $panel;
								}

								var player = battlefield.getPlayer();
								if (player) {
									var $panel = createList('Gracz', 'Gracz', [ player ], 'player');
									$div.append($panel);
								}

								var tanks = battlefield.getTanks();
								if (tanks.length != 0) {
									var $panel = createList('Czołgi', 'Czołg', tanks, 'tanks');
									$div.append($panel);
								}

								var turrets = battlefield.getTurrets();
								if (turrets.length != 0) {
									var $panel = createList('Działa', 'Działo', turrets, 'turrets');
									$div.append($panel);
								}

								var textures = battlefield.getTextures();
								if (textures.length != 0) {
									var $panel = createList('Tekstury', 'Tekstura', textures, 'textures');
									$div.append($panel);
								}
							}

							function updateSelected() {
								var $div = $('.selected-object');
								$div.empty();

								var object = selectedObject;

								if (object == null)
									return;

								var label = parseLabel(object);

								var $h2 = $('<h2></h2>');
								$h2.append('Zmień obiekt: ');
								$div.append($h2);

								var $small = $('<small></small>');
								$small.text(label);
								$h2.append($small)

								function createInputGroup(labelOptions, label, inputOptions) {

									function setAttributes(element, options) {
										var keys = Object.keys(options);
										for ( var i in keys) {
											var key = keys[i];
											var value = options[key];
											element.attr(key, value);
										}
									}

									var $inputGroup = $('<div></div>');
									$inputGroup.addClass('input-group');

									var $label = $('<label></label>');
									$label.append(label);
									setAttributes($label, labelOptions);
									$inputGroup.append($label);

									var $input = $('<input>');
									setAttributes($input, inputOptions);
									$inputGroup.append($input);

									return $inputGroup;
								}

								var type = object.getType();

								if (type > 40) {
									var $name = createInputGroup({
										'for' : 'selectedObjectName',
										'title' : 'Podaj nazwę obiektu.'
									}, 'Nazwa:', {
										'name' : 'selectedObjectName',
										'type' : 'text',
										'placeholder' : 'nazwa',
										'title' : 'Podaj nazwę obiektu.',
										'autocomplete' : 'off',
									});

									var $nameInput = $name.find('input');
									$nameInput.val(object.getName());
									$nameInput.change(function() {
										var name = $(this).val();
										object.setName(name);
										update();
									});

									$div.append($name);
								}

								var $x = createInputGroup({
									'for' : 'selectedObjectX',
									'title' : 'Podaj współrzędną x obiektu.'
								}, 'X:', {
									'name' : 'selectedObjectX',
									'type' : 'number',
									'min' : '0',
									'step' : '1',
									'placeholder' : 'x',
									'title' : 'Podaj współrzędną x obiektu.',
									'autocomplete' : 'off',
								});

								var $xInput = $x.find('input');
								$xInput.val(object.getX());
								$xInput.change(function() {
									var x = parseInt($(this).val());
									object.setX(x);
									update();
								});

								$div.append($x);

								var $y = createInputGroup({
									'for' : 'selectedObjectY',
									'title' : 'Podaj współrzędną y obiektu.'
								}, 'Y:', {
									'name' : 'selectedObjectY',
									'type' : 'number',
									'min' : '0',
									'step' : '1',
									'placeholder' : 'y',
									'title' : 'Podaj współrzędną y obiektu.',
									'autocomplete' : 'off',
								});

								var $yInput = $y.find('input');
								$yInput.val(object.getY());
								$yInput.change(function() {
									var y = parseInt($(this).val());
									object.setY(y);
									update();
								});

								$div.append($y);

								if (type < 10) {
									var $width = createInputGroup({
										'for' : 'selectedObjectWidth',
										'title' : 'Podaj szerokość obiektu.'
									}, 'Szerokość:', {
										'name' : 'selectedObjectWidth',
										'type' : 'number',
										'min' : '0',
										'step' : '1',
										'placeholder' : 'szerokość',
										'title' : 'Podaj szerokość obiektu.',
										'autocomplete' : 'off',
									});

									var $widthInput = $width.find('input');
									$widthInput.val(object.getWidth());
									$widthInput.change(function() {
										var width = parseInt($(this).val());
										object.setWidth(width);
										update();
									});

									$div.append($width);

									var $height = createInputGroup({
										'for' : 'selectedObjectHeight',
										'title' : 'Podaj wysokość obiektu.'
									}, 'Wysokość:', {
										'name' : 'selectedObjectHeight',
										'type' : 'number',
										'min' : '0',
										'step' : '1',
										'placeholder' : 'wysokość',
										'title' : 'Podaj wysokość obiektu.',
										'autocomplete' : 'off',
									});

									var $heightInput = $height.find('input');
									$heightInput.val(object.getHeight());
									$heightInput.change(function() {
										var height = parseInt($(this).val());
										object.setHeight(height);
										update();
									});

									$div.append($height);
								}

								if (type > 30) {
									var $angle = createInputGroup({
										'for' : 'selectedObjectAngle',
										'title' : 'Podaj rotację obiektu w stopniach.'
									}, 'Rotacja:', {
										'name' : 'selectedObjectAngle',
										'type' : 'number',
										'min' : '0',
										'max' : '360',
										'step' : '1',
										'placeholder' : 'rotacja',
										'title' : 'Podaj rotację obiektu w stopniach.',
										'autocomplete' : 'off',
									});

									var $angleInput = $angle.find('input');
									var degrees = Math.round(object.getAngle() * 180 / Math.PI);
									$angleInput.val(degrees);
									$angleInput.change(function() {
										var angleDegrees = $(this).val();
										var angleRadians = angleDegrees * Math.PI / 180;
										object.setAngle(angleRadians);
										update();
									});

									$div.append($angle);
								}

								if (type > 50) {

									function addTurretAngleField() {
										var $turretAngle = createInputGroup({
											'for' : 'selectedObjectTurretAngle',
											'title' : 'Podaj rotację lufy w stopniach.'
										}, 'Rotacja lufy:', {
											'name' : 'selectedObjectTurretAngle',
											'type' : 'number',
											'min' : '0',
											'max' : '360',
											'step' : '1',
											'placeholder' : 'rotacja lufy',
											'title' : 'Podaj rotację lufy w stopniach.',
											'autocomplete' : 'off',
										});

										var $turretAngleInput = $turretAngle.find('input');
										var degrees = Math.round(object.getTurretAngle() * 180 / Math.PI);
										$turretAngleInput.val(degrees);
										$turretAngleInput.change(function() {
											var angleDegrees = $(this).val();
											var angleRadians = angleDegrees * Math.PI / 180;
											object.setTurretAngle(angleRadians);
											update();
										});

										$div.append($turretAngle);
									}

									function addBodyColorField() {
										var $bodyColor = createInputGroup({
											'for' : 'selectedObjectBodyColor',
											'title' : 'Podaj kolor pancerza czołgu.'
										}, 'Kolor pancerza:', {
											'name' : 'selectedObjectBodyColor',
											'class' : 'color',
											'readonly' : 'readonly',
											'placeholder' : 'kolor pancerza',
											'title' : 'Podaj kolor pancarza czołgu',
											'autocomplete' : 'off',
										});

										var $bodyColorInput = $bodyColor.find('input');
										var color = object.getBodyColor();
										var colorHex = color[0].toString(16) + color[1].toString(16)
												+ color[2].toString(16);
										$bodyColorInput.val(colorHex);
										$bodyColorInput.change(function() {
											var color = $(this).val();
											if (color.length != 6)
												return;

											var red = color.substring(0, 2);
											var green = color.substring(2, 4);
											var blue = color.substring(4, 6);

											var redDecimal = parseInt(red, 16);
											var greenDecimal = parseInt(green, 16);
											var blueDecimal = parseInt(blue, 16);
											object.setBodyColor([ redDecimal, greenDecimal, blueDecimal ]);

											battlefield.renderAll(canvas, window.imageManager);
										});

										$div.append($bodyColor);
									}

									function addGunColorField() {
										var $gunColor = createInputGroup({
											'for' : 'selectedObjectGunColor',
											'title' : 'Podaj kolor lufy czołgu.'
										}, 'Kolor lufy:', {
											'name' : 'selectedObjectlufyColor',
											'class' : 'color',
											'readonly' : 'readonly',
											'placeholder' : 'kolor lufy',
											'title' : 'Podaj kolor lufy czołgu.',
											'autocomplete' : 'off',
										});

										var $gunColorInput = $gunColor.find('input');
										var color = object.getGunColor();
										var colorHex = color[0].toString(16) + color[1].toString(16)
												+ color[2].toString(16);
										$gunColorInput.val(colorHex);
										$gunColorInput.change(function() {
											var color = $(this).val();
											if (color.length != 6)
												return;

											var red = color.substring(0, 2);
											var green = color.substring(2, 4);
											var blue = color.substring(4, 6);

											var redDecimal = parseInt(red, 16);
											var greenDecimal = parseInt(green, 16);
											var blueDecimal = parseInt(blue, 16);
											object.setGunColor([ redDecimal, greenDecimal, blueDecimal ]);

											battlefield.renderAll(canvas, window.imageManager);
										});

										$div.append($gunColor);
									}

									function addRadarColorField() {
										var $radarColor = createInputGroup({
											'for' : 'selectedObjectRadarColor',
											'title' : 'Podaj kolor radaru czołgu.'
										}, 'Kolor radaru:', {
											'name' : 'selectedObjectRadarColor',
											'class' : 'color',
											'readonly' : 'readonly',
											'placeholder' : 'kolor radaru',
											'title' : 'Podaj kolor radaru czołgu.',
											'autocomplete' : 'off',
										});

										var $radarColorInput = $radarColor.find('input');
										var color = object.getRadarColor();
										var colorHex = color[0].toString(16) + color[1].toString(16)
												+ color[2].toString(16);
										$radarColorInput.val(colorHex);
										$radarColorInput.change(function() {
											var color = $(this).val();
											if (color.length != 6)
												return;

											var red = color.substring(0, 2);
											var green = color.substring(2, 4);
											var blue = color.substring(4, 6);

											var redDecimal = parseInt(red, 16);
											var greenDecimal = parseInt(green, 16);
											var blueDecimal = parseInt(blue, 16);
											object.setRadarColor([ redDecimal, greenDecimal, blueDecimal ]);

											battlefield.renderAll(canvas, window.imageManager);
										});

										$div.append($radarColor);
									}

									function addSetAsPlayerField() {
										var $inputGroup = $('<div></div>');
										$inputGroup.addClass('input-group');

										var $button = $('<button></button>');
										$button.addClass('btn');
										$button.addClass('btn-default');
										$button.addClass('set-as-player');
										$button.append('Ustaw gracza!');
										$button.click(function() {
											battlefield.removeTank(selectedObject);
											battlefield.setPlayer(selectedObject);
											selectedObject.setType('61');
											update();
										});
										$inputGroup.append($button);

										$div.append($inputGroup);
									}

									addTurretAngleField();
									addBodyColorField();
									addGunColorField();
									addRadarColorField();
									if (type < 60)
										addSetAsPlayerField();
									jscolor.init();
								}
							}

							function parseLabel(object) {
								var type = object.getType();
								if (type < 40)
									return 'Tekstura[' + battlefield.getTextures().indexOf(object) + ']';
								else if (type < 50)
									return 'Działo[' + battlefield.getTurrets().indexOf(object) + ']: '
											+ object.getName();
								else if (type < 60)
									return 'Czołg[' + battlefield.getTanks().indexOf(object) + ']: ' + object.getName();
								return 'Gracz: ' + object.getName();
							}
						});
	</script>
</body>
</html>
