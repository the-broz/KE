package;

import sys.ssl.Key;
import flixel.addons.editors.ogmo.FlxOgmo3Loader.DecalData;
import haxe.Timer;
import haxe.CallStack.StackItem;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;


#if windows
import Discord.DiscordClient;
#end

using StringTools;

class AchievementsState extends MusicBeatState
{
	var songs:Array<String> = ["So Close","DOOM Slayer","Freaky On A Friday","engineer gaming","skill issue","Funkin God!"];
    var descs:Array<String> = ["Die within 5 seconds of the song ending.","Beat the week on DOOM mode.","Play the game on a friday.","engineer gaming.", "skill issue :/","you most likely play osu! or something."];

	var selector:FlxText;
	var curSelected:Int = 0;
	var curDifficulty:Int = 1;

	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;
    var descCrap:FlxText;
	var heldFrames:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<AchievementIcons> = [];
	override function create()
	{
		
			if (FlxG.sound.music != null)
			{
				if (!FlxG.sound.music.playing)
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}

		 #if windows
		 // Updating Discord Rich Presence
		 DiscordClient.changePresence("Viewing Achievements", null);
		 #end

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

		// LOAD MUSIC

		// LOAD CHARACTERS

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{


			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i], true, false, true);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);

			var icon:AchievementIcons = new AchievementIcons("icons");
			icon.sprTracker = songText;

            if (i == 0 && FlxG.save.data.close == true){
                icon.animation.curAnim.curFrame = 1;
            }
            if (i == 1 && FlxG.save.data.trueend == true){
                icon.animation.curAnim.curFrame = 1;
            }
            if (i == 2 && FlxG.save.data.friday == true){
                icon.animation.curAnim.curFrame = 1;
            }
			if (i == 3 && FlxG.save.data.gaming == true){
				icon.animation.curAnim.curFrame = 1;
			}
			if (i == 4 && FlxG.save.data.skills == true){
				icon.animation.curAnim.curFrame = 1;
			}
			if (i == 5 && FlxG.save.data.god == false){
				icon.animation.curAnim.curFrame = 1;
			}

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}


		changeSelection();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */
         descCrap = new FlxText(5, FlxG.height + 40, 0, "a", 15);
         descCrap.scrollFactor.set();
         descCrap.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
         add(descCrap);
         FlxTween.tween(descCrap,{y: FlxG.height - 25},2,{ease: FlxEase.elasticInOut});
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

        descCrap.text = descs[curSelected] + " | HOLD [PERIOD] TO RESET THIS ACHIEVEMENT";
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}
		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuSubState());
		}
		if (FlxG.keys.pressed.PERIOD){
			trace("HELD FOR: "+heldFrames);
			heldFrames++;
			if (heldFrames >= 400){
				if (songs[curSelected] == "So Close"){
					FlxG.save.data.close = false;
				}
				if (songs[curSelected] == "DOOM Slayer"){
					FlxG.save.data.trueend = false;
				}
				if (songs[curSelected] == "Freaky On A Friday"){
					FlxG.save.data.friday = false;
				}
				if (songs[curSelected] == "engineer gaming"){
					FlxG.save.data.gaming = false;
				}
				if (songs[curSelected] == "skill issue"){
					FlxG.save.data.skills = false;
				}
				iconArray[curSelected].animation.curAnim.curFrame = 0;
			}
		}else{
				heldFrames = 0;
			}

		for (i in 0...iconArray.length)
			{
				if (i == 0 && FlxG.save.data.close == true){
					iconArray[i].animation.curAnim.curFrame = 1;
				}
				if (i == 1 && FlxG.save.data.trueend == true){
					iconArray[i].animation.curAnim.curFrame = 1;
				}
				if (i == 2 && FlxG.save.data.friday == true){
					iconArray[i].animation.curAnim.curFrame = 1;
				}
				if (i == 3 && FlxG.save.data.gaming == true){
					iconArray[i].animation.curAnim.curFrame = 1;
				}
				if (i == 4 && FlxG.save.data.skills == true){
					iconArray[i].animation.curAnim.curFrame = 1;
				}
			}

		if (accepted)
		{
			if(iconArray[curSelected].animation.curAnim.curFrame == 1)
				{
					trace('achivement: unlocked!!!');
					
				}else{
					if(songs[curSelected] == "engineer gaming" && FlxG.save.data.gaming == false){
						FlxG.save.data.gaming = true;
						FlxG.sound.play(Paths.sound('gaming','achievements'));
			
			var a:Achievement = new Achievement("engineer gaming","engineer gaming");
			add(a);
					}else{
					camera.shake(0.035, 0.2);
					}
				}
		}
	}

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end

		// NGio.logEvent('Fresh');
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;
		var bullShit:Int = 0;
  
		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}