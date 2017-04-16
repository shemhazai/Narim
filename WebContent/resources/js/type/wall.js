Wall.prototype = new Texture();
Wall.prototype.constructor = Wall;

function Wall() {
	this.pattern = null;
}

Wall.prototype.render = function(context) {
	var name = 'wall' + this.type;
	function makePattern() {
		var image = window.imageManager.get(name);
		return context.createPattern(image, 'repeat');
	}

	var pattern = this.pattern;
	if (pattern == null)
		pattern = makePattern();

	context.fillStyle = pattern;
	context.fillRect(this.getX() - this.getWidth() / 2, this.getY() - this.getHeight() / 2, this.getWidth(), this
			.getHeight());
}