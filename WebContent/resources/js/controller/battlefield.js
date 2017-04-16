function Battlefield() {
	this.width = 0;
	this.height = 0;
	this.background = '';
	this.backgroundPattern = null;
	this.player = null;
	this.textures = [];
	this.tanks = [];
	this.turrets = [];
	this.bullets = [];
	this.animations = [];
}

Battlefield.prototype.getWidth = function() {
	return this.width;
}

Battlefield.prototype.setWidth = function(width) {
	this.width = width;
}

Battlefield.prototype.getHeight = function() {
	return this.height;
}

Battlefield.prototype.setHeight = function(height) {
	this.height = height;
}

Battlefield.prototype.getBackground = function() {
	return this.background;
}

Battlefield.prototype.setBackground = function(background) {
	this.background = background;
}

Battlefield.prototype.getPlayer = function() {
	return this.player;
}

Battlefield.prototype.setPlayer = function(player) {
	this.player = player;
}

Battlefield.prototype.getTextures = function() {
	return this.textures;
}

Battlefield.prototype.addTexture = function(texture) {
	this.textures.push(texture);
}

Battlefield.prototype.removeTexture = function(texture) {
	var index = this.textures.indexOf(texture);
	if (index != -1)
		this.textures.splice(index, 1);
}

Battlefield.prototype.getTanks = function() {
	return this.tanks;
}

Battlefield.prototype.addTank = function(tank) {
	this.tanks.push(tank);
}

Battlefield.prototype.removeTank = function(tank) {
	var index = this.tanks.indexOf(tank);
	if (index != -1)
		this.tanks.splice(index, 1);
}

Battlefield.prototype.getTurrets = function() {
	return this.turrets;
}

Battlefield.prototype.addTurret = function(turret) {
	this.turrets.push(turret);
}

Battlefield.prototype.removeTurret = function(turret) {
	var index = this.turrets.indexOf(turret);
	if (index != -1)
		this.turrets.splice(index, 1);
}

Battlefield.prototype.getBullets = function() {
	return this.bullets;
}

Battlefield.prototype.addBullet = function(bullet) {
	this.bullets.push(bullet);
}

Battlefield.prototype.removeBullet = function(bullet) {
	var index = this.bullets.indexOf(bullet);
	if (index != -1)
		this.bullets.splice(index, 1);
}

Battlefield.prototype.getAnimations = function() {
	return this.animations;
}

Battlefield.prototype.addAnimation = function(animation) {
	this.animations.push(animation);
}

Battlefield.prototype.removeAnimation = function(animation) {
	var index = this.animations.indexOf(animation);
	if (index != -1)
		this.animations.splice(index, 1);
}

Battlefield.prototype.update = function(time) {
	var player = this.player;
	if (player != null)
		player.update(time, this);

	var tanks = this.tanks;
	for ( var i in tanks)
		tanks[i].update(time, this);

	var turrets = this.turrets;
	for ( var i in turrets)
		turrets[i].update(time, this);

	var animations = this.animations;
	for ( var i in animations)
		animations[i].update(time);

	this.checkForAnimationsEnd();
	this.updateBullets(time);
	this.checkCollisions();
}

Battlefield.prototype.updateBullets = function(time) {
	var bullets = this.bullets;
	var rangeOut = [];
	for ( var i in bullets) {
		var bullet = bullets[i];
		bullet.update(time);
		if (bullet.getTraveled() > bullet.getRange())
			rangeOut.push(bullet);
	}

	for ( var i in rangeOut)
		this.removeBullet(rangeOut[i]);
}

Battlefield.prototype.checkForAnimationsEnd = function() {
	var animations = this.animations;
	var end = [];
	for ( var i in animations) {
		if (animations[i].isCompleted())
			end.push(animations[i]);
	}

	for ( var i in end)
		this.removeAnimation(end[i]);
}

Battlefield.prototype.checkCollisions = function() {
	this.checkBulletsHits();
}

Battlefield.prototype.checkBulletsHits = function() {
	var hits = this.getBulletsHits();

	for ( var i in hits)
		this.bulletHit(hits[i]);

	for ( var i in hits)
		this.removeBullet(hits[i][0]);
}

Battlefield.prototype.getBulletsHits = function() {

	var objects = [];
	if (this.player != null)
		objects = objects.concat([ this.player ]);
	objects = objects.concat(this.getTanks());
	objects = objects.concat(this.getTurrets());
	objects = objects.concat(this.getTextures());

	var bullets = this.bullets;
	var hits = [];

	for ( var i in bullets) {
		var bullet = bullets[i];

		for ( var j in objects) {
			var obj = objects[j];

			if (bullet.hasCollision(obj) && obj.getType() > 10) {
				hits.push([ bullet, obj ]);
				break;
			}
		}
	}

	return hits;
}

Battlefield.prototype.bulletHit = function(hit) {
	var bullet = hit[0];
	var obj = hit[1];
	var explosion = new ExplosionAnimation();
	explosion.setX(bullet.x);
	explosion.setY(bullet.y);
	this.addAnimation(explosion);

	if (obj.energy) {
		obj.subtractEnergy(bullet.energy);
		if (obj.energy <= 0)
			this.destroy(obj);
	}

	window.audioManager.playBulletExplosion();
}

Battlefield.prototype.destroy = function(obj) {
	var destroy = new DestroyAnimation();
	destroy.setX(obj.x);
	destroy.setY(obj.y);
	this.addAnimation(destroy);

	if (obj instanceof Player) {
		this.player = null;
		this.onLoose();
	} else if (obj instanceof Tank) {
		this.removeTank(obj);
		if (this.win())
			this.onWin();
	} else {
		this.removeTurret(obj);
		if (this.win())
			this.onWin();
	}

	window.audioManager.playDestroy();
}

Battlefield.prototype.win = function() {
	if (this.tanks.length != 0)
		return false;
	if (this.turrets.length != 0)
		return false;
	return true;
}

Battlefield.prototype.renderAll = function(canvas) {
	var context = canvas.getContext('2d');

	context.clearRect(0, 0, canvas.width, canvas.height);

	if (this.background) {
		var pattern = this.backgroundPattern;
		if (pattern == null) {
			var image = window.imageManager.get(this.background);
			pattern = context.createPattern(image, 'repeat');
		}

		context.fillStyle = pattern;
		context.fillRect(0, 0, canvas.width, canvas.height);
	}

	var textures = this.textures;
	for ( var i in textures)
		textures[i].render(context);

	var turrets = this.turrets;
	for ( var i in turrets)
		turrets[i].render(context);

	var tanks = this.tanks;
	for ( var i in tanks)
		tanks[i].render(context);

	if (this.player != null)
		this.player.render(context);

	var bullets = this.bullets;
	for ( var i in bullets)
		bullets[i].render(context);

	var animations = this.animations;
	for ( var i in animations)
		animations[i].render(context);
}

Battlefield.prototype.renderEnergyHint = function(context) {
	function renderHint(obj) {
		var x = obj.x - obj.width / 2;
		var y = obj.y - obj.height / 2 - 16;

		context.beginPath();
		context.lineWidth = '2';
		context.strokeStyle = '#00ff00';
		context.rect(x, y, obj.width, 6);
		context.stroke();

		var energyPercent = obj.energy / 100;
		context.fillStyle = '#00ff00';
		context.fillRect(x, y, obj.width * energyPercent, 6);

	}

	var turrets = this.turrets;
	for ( var i in turrets)
		renderHint(turrets[i]);

	var tanks = this.tanks;
	for ( var i in tanks)
		renderHint(tanks[i]);

	if (this.player != null)
		renderHint(this.player);

}

Battlefield.prototype.onLoose = function() {

}

Battlefield.prototype.onWin = function() {

}
