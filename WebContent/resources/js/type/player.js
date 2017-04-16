Player.prototype = new Tank();
Player.prototype.constructor = Player;

function Player() {

	this.left = false;
	this.up = false;
	this.right = false;
	this.down = false;
}

Player.prototype.isLeftPressed = function() {
	return this.left;
}

Player.prototype.setLeftPressed = function(left) {
	this.left = left;
}

Player.prototype.isUpPressed = function() {
	return this.up;
}

Player.prototype.setUpPressed = function(up) {
	this.up = up;
}

Player.prototype.isRightPressed = function() {
	return this.right;
}

Player.prototype.setRightPressed = function(right) {
	this.right = right;
}

Player.prototype.isDownPressed = function() {
	return this.down;
}

Player.prototype.setDownPressed = function(down) {
	this.down = down;
}

Player.prototype.update = function(time, battlefield) {
	var lastPosition = {
		x : this.x,
		y : this.y
	};

	if (this.left)
		this.rotateRight(time * this.rotationSpeed);
	else if (this.right)
		this.rotateLeft(time * this.rotationSpeed);

	if (this.up)
		this.ahead(time * this.movementSpeed);
	else if (this.down)
		this.back(time * this.movementSpeed);

	function collide(player) {
		if (player.x < 0 || player.y < 0 || player.x > battlefield.width || player.y > battlefield.height)
			return true;

		var objects = battlefield.getTanks();
		objects = objects.concat(battlefield.getTurrets());
		objects = objects.concat(battlefield.getTextures());

		for ( var i in objects) {
			var obj = objects[i];
			if (obj.type > 10 && obj.hasCollision(player))
				return true;
		}

		return false;
	}

	if (collide(this)) {
		this.x = lastPosition.x;
		this.y = lastPosition.y;
	}
}