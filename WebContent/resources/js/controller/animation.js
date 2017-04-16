Animation.prototype = new Texture();
Animation.prototype.constructor = Animation;

function Animation() {
	this.x = 0;
	this.y = 0;
	this.width = 0;
	this.height = 0;
	this.sprite = null;
	this.frames = null;
	this.totalTime = null;
	this.time = 0.0;
}

Animation.prototype.getSprite = function() {
	return this.sprite;
}

Animation.prototype.setSprite = function(sprite) {
	this.sprite = sprite;
}

Animation.prototype.getFrames = function() {
	return this.frames;
}

Animation.prototype.setFrames = function(frames) {
	this.frame = frames;
}

Animation.prototype.getTotalTime = function() {
	return this.totalTime;
}

Animation.prototype.setTotalTime = function(totalTime) {
	this.totalTime = totalTime;
}

Animation.prototype.getTime = function() {
	return this.time;
}

Animation.prototype.setTime = function(time) {
	this.time = time;
}

Animation.prototype.getFrameIndex = function() {
	return Math.floor(this.time / this.totalTime * this.frames);
}

Animation.prototype.update = function(time) {
	this.time += time;
}

Animation.prototype.render = function(context) {
	var animation = this;
	context.save();
	context.translate(animation.x, animation.y);
	context.rotate(animation.angle);
	context.translate(-animation.width / 2, -animation.height / 2);
	context.drawImage(animation.getSprite(), animation.getFrameIndex() * animation.width, 0, animation.width,
			animation.height, 0, 0, animation.width, animation.height);
	context.restore();
}

Animation.prototype.isCompleted = function() {
	return this.time >= this.totalTime;
}
