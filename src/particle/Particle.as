package particle {
	
	import flash.events.*;
	import flash.display.MovieClip;
	
	import caurina.transitions.*;
	import caurina.transitions.properties.*;

	public class Particle extends MovieClip {
	
		private var _particle:MovieClip;
		
		private var _curDly:Number = 0;
		
		public var _startX:Number;
		public var _startY:Number;
		
		private var breathing:Boolean = false;
	
	
		public function Particle(){
			super();
			addEventListener(Event.ADDED_TO_STAGE, createChildren);
			DisplayShortcuts.init();
		}
		
		private function createChildren(event:Event):void {
			
			
			_particle = new ParticleClip();
			this.buttonMode = true;
			
			this.alpha = 0;
			this.x = -(stage.stageWidth) + Math.random()*stage.stageWidth*2;
			this.y = -(stage.stageHeight) + Math.random()*stage.stageHeight*2;
			addChild(_particle);
			
			createEvents();
			
		}
		
		private function createEvents():void {
			addEventListener(MouseEvent.MOUSE_DOWN, dragIt);
			addEventListener(MouseEvent.MOUSE_UP, releaseIt);
		}
		
		
		private function dragIt(event:MouseEvent):void {
			this.startDrag();
		}
		private function releaseIt(event:MouseEvent):void {
			this.stopDrag();
		}
		
		
		
		private function startBreathing(event:Event = null):void {
			breathing = true;
			breath();
		}
		private function stopBreathing(event:Event = null):void {
			Tweener.removeTweens(this, true, true);
			breathing = false;
		}
		
		private function breath(event:Event = null):void {
			var newX = (_startX - 4) + (_startX + Math.random()*8);
			var newY = (_startY - 4) + (_startY + Math.random()*8);
			Tweener.addTween(this, {x:newX, y:newY, time:1, transition:"easeNone", onComplete:breath});
		}
		
		
		public function showParticle(_time:Number = .5, _dly:Number = 0):void {
			Tweener.addTween(this,{alpha:.5, time:_time*4, delay:_dly});
		}
		public function hideParticle(_time:Number = .5):void {
			Tweener.addTween(this,{alpha:0, time:_time});
		}
		
		public function moveParticle(_x:Number, _y:Number, _time:Number = 0, _dly:Number = 0):void {
			Tweener.addTween(this, {x:_x, y:_y, _scale:(Math.random()*.5) + .1, time:_time, delay:_dly, transition:"easeInOutExpo", onComplete:startBreathing});
		}
		
	}

}

