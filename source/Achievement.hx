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
		var daDogDoing:FlxSprite = new FlxSprite(0,50);
		var icon:AchievementIcons = new AchievementIcons("icons");
		var name:FlxText = new FlxText(0,50,0,displayName);
		trace(displayName);
		name.setFormat("VCR OSD Mono", 17, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		var desc:FlxText = new FlxText(0,50,30,displayDesc);
		desc.setFormat("VCR OSD Mono", 17, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		icon.animation.curAnim.curFrame = 1;
		daDogDoing.makeGraphic(120,60,FlxColor.GRAY);
		add(daDogDoing);
		add(icon);
		add(name);
		add(desc);
		new FlxTimer().start(1,function(timer:FlxTimer){
			FlxTween.tween(daDogDoing, {x: FlxG.width + 300},2, {ease: FlxEase.bounceIn});
			FlxTween.tween(icon, {x: FlxG.width + 290},2, {ease: FlxEase.bounceIn});
			FlxTween.tween(name, {x: FlxG.width + 300},2, {ease: FlxEase.bounceIn});
			FlxTween.tween(desc, {x: FlxG.width + 330},2, {ease: FlxEase.bounceIn});
            new FlxTimer().start(4, function(timer:FlxTimer)
                {
                    remove(daDogDoing);
                    remove(icon);
                    remove(name);
                    remove(desc);
                });
		});	
		
	}
	override function update(elapsed:Float)
		{
			super.update(elapsed);
		}
}