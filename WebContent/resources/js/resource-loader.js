function ResourceLoader() {
	this.loaded = 0;
	this.toLoad = 0;
	this.callback = function() {
		alert('Resource loaded.');
	};
	this.ready = false;
}

ResourceLoader.prototype.loadImage = function(src) {
	window.loader.toLoad++;
	var image = new Image();
	image.onload = window.loader.resourceLoaded;
	image.src = src;
	return image;
}

ResourceLoader.prototype.loadAudio = function(src) {
	window.loader.toLoad++;
	var audio = new Audio();
	audio.oncanplaythrough = window.loader.resourceLoaded;
	audio.src = src;
	return audio;
}

ResourceLoader.prototype.resourceLoaded = function() {
	var loader = window.loader;
	loader.loaded++;

	if (loader.ready && loader.loaded == loader.toLoad)
		loader.callback();
}

ResourceLoader.prototype.getCallback = function() {
	return window.loader.callback;
}

ResourceLoader.prototype.setCallback = function(callback) {
	window.loader.callback = callback;
	window.loader.ready = true;
}
