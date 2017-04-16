ExplosionAnimation.prototype = new Animation();
ExplosionAnimation.prototype.constructor = ExplosionAnimation;

function ExplosionAnimation(sprite, frames, totalTime) {
	this.x = 0;
	this.y = 0;
	this.width = 39;
	this.height = 39;
	this.sprite = window.imageManager.get('bullet-explosion-sprite');
	this.frames = 13;
	this.totalTime = 0.8;
	this.time = 0.0;
}