House.prototype = new Texture();
House.prototype.constructor = House;

function House() {
	this.image = null;
}

House.prototype.setType = function(type) {
	this.type = type;
	var image = window.imageManager.get('house' + type);
	this.width = image.width;
	this.height = image.height;
	this.image = image;
}

House.prototype.render = function(context) {
	var image = this.image;
	if (!image)
		return;

	context.save();
	context.translate(this.getX(), this.getY());
	context.translate(-this.getWidth() / 2, -this.getHeight() / 2);
	context.drawImage(image, 0, 0, this.getWidth(), this.getHeight());
	context.restore();
}