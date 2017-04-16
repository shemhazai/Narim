function AudioManager(path) {
	this.supportedAudioExtension = this.getSupportedAudioExtension();

	var sae = this.supportedAudioExtension;
	var load = function(src) {
		src = path + src + sae;
		return window.loader.loadAudio(src);
	}

	this['shoot1'] = load('/resources/audio/shoot');
	this['shoot2'] = load('/resources/audio/shoot');
	this['shoot3'] = load('/resources/audio/shoot');
	this['shoot4'] = load('/resources/audio/shoot');
	this['shoot5'] = load('/resources/audio/shoot');
	this['shoot6'] = load('/resources/audio/shoot');
	this['shoot7'] = load('/resources/audio/shoot');
	this['shoot8'] = load('/resources/audio/shoot');
	this['shoot9'] = load('/resources/audio/shoot');
	this['shoot10'] = load('/resources/audio/shoot');

	this['bullet-explosion1'] = load('/resources/audio/bullet-explosion');
	this['bullet-explosion2'] = load('/resources/audio/bullet-explosion');
	this['bullet-explosion3'] = load('/resources/audio/bullet-explosion');
	this['bullet-explosion4'] = load('/resources/audio/bullet-explosion');
	this['bullet-explosion5'] = load('/resources/audio/bullet-explosion');
	this['bullet-explosion6'] = load('/resources/audio/bullet-explosion');
	this['bullet-explosion7'] = load('/resources/audio/bullet-explosion');
	this['bullet-explosion8'] = load('/resources/audio/bullet-explosion');
	this['bullet-explosion9'] = load('/resources/audio/bullet-explosion');
	this['bullet-explosion10'] = load('/resources/audio/bullet-explosion');
	
	
	this['destroy1'] = load('/resources/audio/destroy');
	this['destroy2'] = load('/resources/audio/destroy');
	this['destroy3'] = load('/resources/audio/destroy');
	
	this.extendAudio(this.getAll('shoot'));
	this.extendAudio(this.getAll('bullet-explosion'));
	this.extendAudio(this.getAll('destroy'));

}

AudioManager.prototype.playShoot = function() {
	var audios = this.getAll('shoot');
	this.play(audios);
}

AudioManager.prototype.playBulletExplosion = function() {
	var audios = this.getAll('bullet-explosion');
	this.play(audios);
}

AudioManager.prototype.playDestroy = function() {
	var audios = this.getAll('destroy');
	this.play(audios);
}

AudioManager.prototype.extendAudio = function(audios) {
	for (var i = 0; i < audios.length; i++) {
		var audio = audios[i];

		audio.isPlaying = function() {
			return this.currentTime != 0;
		}

		audio.onended = function() {
			this.currentTime = 0;
		}
	}
}

AudioManager.prototype.play = function(audios) {
	var freePlayer = this.findFreePlayer(audios);
	if (freePlayer != null)
		freePlayer.play();
}

AudioManager.prototype.findFreePlayer = function(audios) {
	for (var i = 0; i < audios.length; i++) {
		var audio = audios[i];
		if (!audio.isPlaying())
			return audio;
	}
	return null;
}

AudioManager.prototype.getSupportedAudioExtension = function() {
	if (Modernizr.audio.ogg)
		return '.ogg';
	if (Modernizr.audio.m4a)
		return '.m4a';
	if (modernizr.audio.mp3)
		return '.mp3';
	return '.wav';

}

AudioManager.prototype.getAll = function(pattern) {
	var array = [];
	var keys = Object.keys(this);
	for ( var i in keys) {
		var key = keys[i];
		if (key.indexOf(pattern) != -1)
			array.push(this[key]);
	}
	return array;
}
