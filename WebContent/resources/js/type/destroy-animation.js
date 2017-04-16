DestroyAnimation.prototype = new Animation();
DestroyAnimation.prototype.constructor = DestroyAnimation;

function DestroyAnimation() {
	this.x = 0;
	this.y = 0;
	this.width = 128;
	this.height = 128;
	this.sprite = window.imageManager.get('destroy-sprite');
	this.frames = 16;
	this.totalTime = 1.6;
	this.time = 0.0;
}