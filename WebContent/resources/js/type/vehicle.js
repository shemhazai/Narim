Vehicle.prototype = new Texture();
Vehicle.prototype.constructor = Vehicle;

function Vehicle() {
	this.image = null;
}

Vehicle.prototype.setType = function(type) {
	this.type = type;
	var image = window.imageManager.get('vehicle' + type);
	this.width = image.width;
	this.height = image.height;
	this.image = image;
}

Vehicle.prototype.render = function(context) {
	var image = this.image;
	if (!image)
		return;

	context.save();
	context.translate(this.getX(), this.getY());
	context.rotate(this.getAngle());
	context.translate(-this.getWidth() / 2, -this.getHeight() / 2);
	context.drawImage(image, 0, 0, this.getWidth(), this.getHeight());
	context.restore();
}