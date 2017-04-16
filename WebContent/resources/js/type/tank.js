Tank.prototype = new Cannon();
Tank.prototype.constructor = Tank;

function Tank() {
	this.width = 52;
	this.height = 64;
	this.angle = 0;
	this.turretAngle = 0;
	this.bodyColor = [ 255, 0, 0 ];
	this.gunColor = [ 0, 255, 0 ];
	this.radarColor = [ 0, 0, 255 ];
	this.movementSpeed = 200;
	this.rotationSpeed = Math.PI / 3 * 2;
	this.energy = 100;
	this.bulletEnergy = 18;
	this.range = 450;

	var im = window.imageManager;
	this.bodyPattern = im.get('tank-body');
	this.gunPattern = im.get('tank-gun');
	this.radarPattern = im.get('tank-radar');

	this.bodyImage = this.bodyPattern;
	this.gunImage = this.gunPattern;
	this.radarImage = this.radarPattern;
}

Tank.prototype.getTurretAngle = function() {
	return this.turretAngle;
}

Tank.prototype.setTurretAngle = function(turretAngle) {
	this.turretAngle = turretAngle;
}

Tank.prototype.getBodyColor = function() {
	return this.bodyColor;
}

Tank.prototype.setBodyColor = function(bodyColor) {
	this.bodyColor = bodyColor;
	var img = this.prepareBodyImage();
	var tank = this;
	img.onload = function() {
		tank.bodyImage = img;
	}
}

Tank.prototype.getGunColor = function() {
	return this.gunColor;
}

Tank.prototype.setGunColor = function(gunColor) {
	this.gunColor = gunColor;
	var img = this.prepareGunImage();
	var tank = this;
	img.onload = function() {
		tank.gunImage = img;
	}
}

Tank.prototype.getRadarColor = function() {
	return this.radarColor;
}

Tank.prototype.setRadarColor = function(radarColor) {
	this.radarColor = radarColor;
	var img = this.prepareRadarImage();
	var tank = this;
	img.onload = function() {
		tank.radarImage = img;
	}
}

Tank.prototype.aim = function(point) {
	var alfa = Math.atan2(point.y - this.y, point.x - this.x) + Math.PI / 2;
	this.setTurretAngle(alfa);
}

Tank.prototype.fire = function() {
	var length = this.height / 1.8;
	var angle = this.turretAngle;
	var x = this.x + length * Math.sin(angle);
	var y = this.y - length * Math.cos(angle);

	var bullet = new Bullet();
	bullet.setOwner(this);
	bullet.setX(x);
	bullet.setY(y);
	bullet.setAngle(angle);
	bullet.setEnergy(this.bulletEnergy);

	this.setLastFireTime(Date.now());
	window.audioManager.playShoot();

	return bullet;
}

Tank.prototype.prepareImage = function(image, oldColor, newColor) {
	var im = window.imageManager;
	return im.swapImageColor(image, oldColor, newColor);
}

Tank.prototype.prepareBodyImage = function() {
	return this.prepareImage(this.bodyPattern, [ 255, 0, 0 ], this.bodyColor);
}

Tank.prototype.prepareGunImage = function() {
	return this.prepareImage(this.gunPattern, [ 0, 255, 0 ], this.gunColor);
}

Tank.prototype.prepareRadarImage = function() {
	return this.prepareImage(this.radarPattern, [ 0, 0, 255 ], this.radarColor);
}

Tank.prototype.update = function(time, battlefield) {
	var player = battlefield.player;
	if (player == null)
		return;

	var t = this;
	function inRange() {
		var x = t.x - player.x;
		var y = t.y - player.y;
		var r = t.range;
		return Math.sqrt((x * x) + (y * y)) < r;
	}

	function getAngle() {
		var x = player.x - t.x;
		var y = player.y - t.y;
		return Math.atan2(y, x) + Math.PI / 2;
	}

	if (inRange()) {
		t.setTurretAngle(getAngle());
		if (t.canFire())
			battlefield.addBullet(t.fire());
	}
}

Tank.prototype.render = function(context) {

	context.save();
	context.translate(this.getX(), this.getY());
	context.rotate(this.getAngle());
	context.translate(-this.getWidth() / 2, -this.getHeight() / 2);
	context.drawImage(this.bodyImage, 0, 0, this.getWidth(), this.getHeight());
	context.restore();

	context.save();
	context.translate(this.getX(), this.getY());
	context.rotate(this.getTurretAngle());
	context.translate(-this.getWidth() / 2, -this.getHeight() / 3 * 2);
	context.drawImage(this.gunImage, 0, 0, this.getWidth(), this.getHeight());
	context.drawImage(this.radarImage, 0, 0, this.getWidth(), this.getHeight());
	context.restore();

}