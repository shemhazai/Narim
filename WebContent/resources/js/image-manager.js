function ImageManager(path) {
	var load = function(src) {
		return window.loader.loadImage(path + src);
	}

	this['background1'] = load('/resources/img/background1.png');
	this['background2'] = load('/resources/img/background2.png');
	this['background3'] = load('/resources/img/background3.png');
	this['background4'] = load('/resources/img/background4.png');
	this['background5'] = load('/resources/img/background5.png');
	this['wall01'] = load('/resources/img/wall01.png');
	this['wall02'] = load('/resources/img/wall02.png');
	this['wall03'] = load('/resources/img/wall03.png');
	this['wall04'] = load('/resources/img/wall04.png');
	this['tree11'] = load('/resources/img/tree11.png');
	this['tree12'] = load('/resources/img/tree12.png');
	this['tree13'] = load('/resources/img/tree13.png');
	this['tree14'] = load('/resources/img/tree14.png');
	this['tree15'] = load('/resources/img/tree15.png');
	this['tree16'] = load('/resources/img/tree16.png');
	this['tree17'] = load('/resources/img/tree17.png');
	this['tree18'] = load('/resources/img/tree18.png');
	this['tree19'] = load('/resources/img/tree19.png');
	this['house21'] = load('/resources/img/house21.png');
	this['house22'] = load('/resources/img/house22.png');
	this['house23'] = load('/resources/img/house23.png');
	this['house24'] = load('/resources/img/house24.png');
	this['vehicle31'] = load('/resources/img/vehicle31.png');
	this['vehicle32'] = load('/resources/img/vehicle32.png');
	this['vehicle33'] = load('/resources/img/vehicle33.png');
	this['turret41'] = load('/resources/img/turret41.png');
	this['turret42'] = load('/resources/img/turret42.png');
	this['tank51'] = load('/resources/img/tank51.png');
	this['tank-body'] = load('/resources/img/tank-body.png');
	this['tank-gun'] = load('/resources/img/tank-gun.png');
	this['tank-radar'] = load('/resources/img/tank-radar.png');
	this['bullet'] = load('/resources/img/bullet.png');
	this['bullet-explosion-sprite'] = load('/resources/img/bullet-explosion-sprite.png');
	this['destroy-sprite'] = load('/resources/img/destroy-sprite.png');
}

ImageManager.prototype.get = function(src) {
	return this[src];
}

ImageManager.prototype.getAll = function(pattern) {
	var array = [];
	var keys = Object.keys(this);
	for ( var i in keys) {
		var key = keys[i];
		if (key.indexOf(pattern) != -1)
			array.push(this[key]);
	}
	return array;
}

ImageManager.prototype.swapImageColor = function(image, oldColor, newColor) {
	var canvas = document.createElement('canvas');
	var context = canvas.getContext('2d');
	canvas.setAttribute('width', image.width);
	canvas.setAttribute('height', image.height);
	context.drawImage(image, 0, 0);

	var imageData = context.getImageData(0, 0, image.width, image.height);
	for (var i = 0; i < imageData.data.length; i += 4) {
		if (imageData.data[i] == oldColor[0] && imageData.data[i + 1] == oldColor[1]
				&& imageData.data[i + 2] == oldColor[2]) {
			imageData.data[i] = newColor[0];
			imageData.data[i + 1] = newColor[1];
			imageData.data[i + 2] = newColor[2];
		}
	}
	context.putImageData(imageData, 0, 0);

	var newImage = new Image();
	newImage.src = canvas.toDataURL();

	return newImage;
}
