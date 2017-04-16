function Texture() {
	this.name = '';
	this.angle = 0;
	this.x = 0;
	this.y = 0;
	this.width = 0;
	this.height = 0;
	this.type = 0;
}

Texture.prototype.getName = function() {
	return this.name;
}

Texture.prototype.setName = function(name) {
	this.name = name;
}

Texture.prototype.getAngle = function() {
	return this.angle;
}

Texture.prototype.setAngle = function(angle) {
	this.angle = angle;
}

Texture.prototype.rotateLeft = function(angle) {
	this.angle += angle;
	if (this.angle >= 2 * Math.PI)
		this.angle -= 2 * Math.PI;
	else if (this.angle < 0)
		this.angle += 2 * Math.PI;
}

Texture.prototype.rotateRight = function(angle) {
	this.angle -= angle;
	if (this.angle < 0)
		this.angle += 2 * Math.PI;
	else if (this.angle >= 2 * Math.PI)
		this.angle -= 2 * Math.PI;
}

Texture.prototype.getX = function() {
	return this.x;
}

Texture.prototype.setX = function(x) {
	this.x = x;
}

Texture.prototype.getY = function() {
	return this.y;
}

Texture.prototype.setY = function(y) {
	this.y = y;
}

Texture.prototype.getWidth = function() {
	return this.width;
}

Texture.prototype.setWidth = function(width) {
	this.width = width;
}

Texture.prototype.getHeight = function() {
	return this.height;
}

Texture.prototype.setHeight = function(height) {
	this.height = height;
}

Texture.prototype.getType = function() {
	return this.type;
}

Texture.prototype.setType = function(type) {
	this.type = type;
}

Texture.prototype.ahead = function(distance) {
	var angle = this.angle;
	var dx = distance * Math.sin(angle);
	var dy = -distance * Math.cos(angle);
	this.x += Math.round(dx);
	this.y += Math.round(dy);
}

Texture.prototype.back = function(distance) {
	var angle = this.angle;
	var dx = -distance * Math.sin(angle);
	var dy = distance * Math.cos(angle);
	this.x += Math.round(dx);
	this.y += Math.round(dy);
}

Texture.prototype.rotateTo = function(point) {
	var alfa = Math.atan2(point.y - this.y, point.x - this.x) + Math.PI / 2;
	this.setAngle(alfa);
}

Texture.prototype.hasPoint = function(point) {
	var a = this.angle;
	var PI = Math.PI;
	if (a == 0 || a == PI || a == 2 * PI) {
		var t = {
			x : this.x - this.width / 2,
			y : this.y - this.height / 2,
			w : this.width,
			h : this.height
		};
		var p = point;
		return (p.x > t.x) && (p.x < (t.x + t.w)) && (p.y > t.y) && (p.y < (t.y + t.h));
	} else {
		var radius = this.width / 2;
		var dx = point.x - this.x;
		var dy = point.y - this.y;
		return dx * dx + dy * dy < radius * radius;
	}

}

Texture.prototype.hasCollision = function(other) {
	var t = this;
	var o = other;
	var r1 = (this.width + this.height) / 4;
	var r2 = (other.width + other.height) / 4;
	var dx = t.x - o.x;
	var dy = t.y - o.y;
	var dr = r1 + r2;
	return (dx * dx) + (dy * dy) < (dr * dr);
}

Texture.prototype.update = function(time) {

}

Texture.prototype.render = function(context) {

}

Texture.prototype.toString = function() {
	return 'Texture[angle=' + this.angle + ',x=' + this.x + ',y=' + this.y + ',width=' + this.width + ',height='
			+ this.height + ']';
}
