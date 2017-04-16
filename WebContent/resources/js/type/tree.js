Tree.prototype = new Texture();
Tree.prototype.constructor = Tree;

function Tree() {
	this.image = null;
}

Tree.prototype.setType = function(type) {
	this.type = type;
	var image = window.imageManager.get('tree' + type);
	this.width = image.width;
	this.height = image.height;
	this.image = image;
}

Tree.prototype.render = function(context) {
	var image = this.image;
	if (!image)
		return;

	context.save();
	context.translate(this.getX(), this.getY());
	context.translate(-this.getWidth() / 2, -this.getHeight() / 2);
	context.drawImage(image, 0, 0, this.getWidth(), this.getHeight());
	context.restore();
}