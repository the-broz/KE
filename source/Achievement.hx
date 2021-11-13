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
		// THIS IS GARBAGE. IM SORRY.
		super();
		var daDogDoing:FlxSprite = new FlxSprite(-500,50);
		var icon:AchievementIcons = new AchievementIcons("icons");
		var name:FlxText = new FlxText(-500,50,0,displayName);
		trace(displayName);
		name.setFormat("VCR OSD Mono", 17, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		var desc:FlxText = new FlxText(-500,70,200,displayDesc);
		desc.setFormat("VCR OSD Mono", 17, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		icon.x = -500;
		icon.y = 50;
		icon.animation.curAnim.curFrame = 1;
		icon.frameHeight = 25;
		icon.frameWidth = 25;
		daDogDoing.makeGraphic(200,60,FlxColor.GRAY);
		add(daDogDoing);
		add(icon);
		add(name);
		add(desc);
			FlxTween.tween(daDogDoing, {x: 15},2, {ease: FlxEase.bounceIn});
			FlxTween.tween(icon, {x: 10},2, {ease: FlxEase.bounceIn});
			FlxTween.tween(name, {x: 30},2, {ease: FlxEase.bounceIn});
			FlxTween.tween(desc, {x: 33},2, {ease: FlxEase.bounceIn});
            new FlxTimer().start(4, function(timer:FlxTimer)
                {
                    remove(daDogDoing);
                    remove(icon);
                    remove(name);
                    remove(desc);
                });
	};	
	override function update(elapsed:Float)
		{
			super.update(elapsed);
		}
}