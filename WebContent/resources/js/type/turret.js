Turret.prototype = new Cannon();
Turret.prototype.constructor = Turret;

function Turret() {
	this.range = 480; // default small turret range
	this.angle = 0;
	this.image = null;
	this.bulletEnergy = 9;
	this.fireInterval = 0.65;
	this.energy = 100;
}

Turret.prototype.setType = function(type) {
	this.type = type;
	var image = window.imageManager.get('turret' + type);
	this.image = image;
	this.width = image.width;
	this.height = image.height;

	if (type == 42) {
		this.range = 650;
		this.bulletEnergy = 23;
		this.fireInterval = 1.7;
	}
}

Turret.prototype.aim = function(point) {
	this.rotateTo(point);
}

Turret.prototype.fire = function() {
	var length = this.height / 1.8;
	var angle = this.angle;
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

Turret.prototype.update = function(time, battlefield) {
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
		t.setAngle(getAngle());
		if (t.canFire())
			battlefield.addBullet(t.fire());
	}
}

Turret.prototype.render = function(context) {
	if (this.type == 0)
		return;

	context.save();
	context.translate(this.getX(), this.getY());
	context.rotate(this.getAngle());
	context.translate(-this.getWidth() / 2, -this.getHeight() / 2);
	context.drawImage(this.image, 0, 0, this.getWidth(), this.getHeight());
	context.restore();
}