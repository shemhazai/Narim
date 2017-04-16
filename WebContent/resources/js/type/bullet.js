Bullet.prototype = new Texture();
Bullet.prototype.constructor = Bullet;

function Bullet() {
	this.width = 8;
	this.height = 8;
	this.owner = null;
	this.range = 450;
	this.traveled = 0;
	this.speed = 400;
	this.energy = 15;

	this.image = window.imageManager.get('bullet');
}

Bullet.prototype.getOwner = function() {
	return this.owner;
}

Bullet.prototype.setOwner = function(owner) {
	this.owner = owner;
}

Bullet.prototype.getRange = function() {
	return this.range;
}

Bullet.prototype.setRange = function(range) {
	this.range = range;
}

Bullet.prototype.getTraveled = function() {
	return this.traveled;
}

Bullet.prototype.setTraveled = function(traveled) {
	this.traveled = traveled;
}

Bullet.prototype.addTraveled = function(traveled) {
	this.traveled += traveled;
}

Bullet.prototype.getSpeed = function() {
	return this.speed;
}

Bullet.prototype.setSpeed = function(speed) {
	this.speed = speed;
}

Bullet.prototype.getEnergy = function() {
	return this.energy;
}

Bullet.prototype.setEnergy = function(energy) {
	this.energy = energy;
}

Bullet.prototype.update = function(time) {
	var distance = time * this.speed;
	this.ahead(distance);
	this.addTraveled(distance);
}

Bullet.prototype.render = function(context) {
	context.save();
	context.translate(this.getX(), this.getY());
	context.rotate(this.getAngle());
	context.translate(-this.getWidth() / 2, -this.getHeight() / 2);
	context.drawImage(this.image, 0, 0, this.getWidth(), this.getHeight());
	context.restore();
}
