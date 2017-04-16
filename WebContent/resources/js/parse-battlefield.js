function parseBattlefield(json) {
	var battlefield = new Battlefield();
	var obj = JSON.parse(json);

	battlefield.setWidth(Number(obj.width));
	battlefield.setHeight(Number(obj.height));
	battlefield.setBackground(obj.background);
	
	var player = new Player();
	parseTank(player, obj.player);
	battlefield.setPlayer(player);
	
	for (var i = 0; i < obj.tanks.length; i++) {
		var tank = new Tank();
		parseTank(tank, obj.tanks[i]);
		battlefield.addTank(tank);
	}
	
	for (var i = 0; i < obj.textures.length; i++) {
		var type = obj.textures[i].type;
		var texture;
		
		if (type < 10) texture = new Wall();
		else if (type < 20) texture = new Tree();
		else if (type < 30) texture = new House();
		else if (type < 40) texture = new Vehicle();
		
		parseTexture(texture, obj.textures[i]);
		battlefield.addTexture(texture);
	}
	
	for (var i = 0; i < obj.turrets.length; i++) {
		var turret = new Turret();
		parseCannon(turret, obj.turrets[i]);
		battlefield.addTurret(turret);
	}
	

	return battlefield;
}


function parseTank(tank, obj) {
	parseCannon(tank, obj);
	tank.setTurretAngle(obj.turretAngle);
	tank.setBodyColor(obj.bodyColor);
	tank.setGunColor(obj.gunColor);
	tank.setRadarColor(obj.radarColor);
}

function parseCannon(canon, obj) {
	parseTexture(canon, obj);
}

function parseTexture(texture, obj) {
	texture.setName(obj.name);
	texture.setAngle(Number(obj.angle));
	texture.setX(Number(obj.x));
	texture.setY(Number(obj.y));
	texture.setWidth(Number(obj.width));
	texture.setHeight(Number(obj.height));
	texture.setType(obj.type);
}
/* this.player = null; this.textures = []; this.tanks = []; this.turrets =
 * []; this.bullets = []; this.animations = [];
 */