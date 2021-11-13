import haxe.iterators.StringIterator;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.media.Sound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Achievement extends FlxSpriteGroup {
    public function new(displayName:String,displayDesc:String){
		// this is an absolute abuse of timers.
		super();
		var daDogDoing:FlxSprite = new FlxSprite(-500,50);
		var tex = Paths.getSparrowAtlas("images/achievementUnlock","achievements");
		var icon:AchievementIcons = new AchievementIcons("icons");
		var name:FlxText = new FlxText(-500,50,0,displayName);
		trace(displayName);
		name.setFormat("VCR OSD Mono", 17, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		var desc:FlxText = new FlxText(-500,70,200,displayDesc);
		desc.setFormat("VCR OSD Mono", 15, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		icon.x = -500;
		icon.y = 3;
		daDogDoing.alpha = .7;
		icon.scale.set(0.5,0.5);
		daDogDoing.makeGraphic(250,60,FlxColor.GRAY);
		add(daDogDoing);
		add(icon);
		add(name);
		add(desc);
			FlxTween.tween(daDogDoing, {x: 15},2, {ease: FlxEase.bounceIn});
			FlxTween.tween(icon, {x: -20},2, {ease: FlxEase.bounceIn});
			FlxTween.tween(name, {x: 80},2, {ease: FlxEase.bounceIn});
			FlxTween.tween(desc, {x: 83},2, {ease: FlxEase.bounceIn});
			new FlxTimer().start(2.5, function(timer:FlxTimer){
				FlxTween.tween(icon, {y: -30},.5, {ease: FlxEase.bounceIn});
				new FlxTimer().start(.55, function(timer:FlxTimer){FlxTween.tween(icon, {y: 3},.25, {ease: FlxEase.bounceIn});icon.animation.curAnim.curFrame = 1;});
			});
			new FlxTimer().start(4, function(timer:FlxTimer){
				FlxTween.tween(daDogDoing, {x: -200},2, {ease: FlxEase.bounceIn});
				FlxTween.tween(icon, {x: -200},2, {ease: FlxEase.bounceIn});
				FlxTween.tween(name, {x: -200},2, {ease: FlxEase.bounceIn});
				FlxTween.tween(desc, {x: -200},2, {ease: FlxEase.bounceIn});
					new FlxTimer().start(1, function(timer:FlxTimer)
                {
                    
					remove(daDogDoing);
                    remove(icon);
                    remove(name);
                    remove(desc);
                });
			});
		
	};	
	override function update(elapsed:Float)
		{
			super.update(elapsed);
		}
}