Cannon.prototype = new Texture();
Cannon.prototype.constructor = Cannon;

function Cannon() {
	this.energy = 100;
	this.lastFireTime = 0;
	this.fireInterval = 1;
}

Cannon.prototype.getEnergy = function() {
	return this.energy;
}

Cannon.prototype.setEnergy = function(energy) {
	this.energy = energy;
}

Cannon.prototype.subtractEnergy = function(energy) {
	this.energy -= energy;
}

Cannon.prototype.addEnergy = function(energy) {
	this.energy += energy;
}

Cannon.prototype.getLastFireTime = function() {
	return this.lastFireTime;
}

Cannon.prototype.setLastFireTime = function(lastFireTime) {
	this.lastFireTime = lastFireTime;
}

Cannon.prototype.canFire = function() {
	var now = Date.now();
	var dt = (now - this.lastFireTime) / 1000.0;
	return dt > this.fireInterval;
}

Cannon.prototype.aim = function(point) {

}

Cannon.prototype.fire = function() {

}

Cannon.prototype.render = function(context) {

}