package particle {
	
	import flash.events.*;
	import flash.display.MovieClip;
	
	import caurina.transitions.*;
	import caurina.transitions.properties.*;

	public class Particle extends MovieClip {
	
		private var _particle:MovieClip;
	
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
		
		
		public function showParticle(_time:Number = .5, _dly:Number = 0):void {
			Tweener.addTween(this,{alpha:.5, time:_time*4, delay:_dly});
		}
		public function hideParticle(_time:Number = .5):void {
			Tweener.addTween(this,{alpha:0, time:_time});
		}
		
		public function moveParticle(_x:Number, _y:Number, _time:Number = 0, _dly:Number = 0):void {
			Tweener.addTween(this, {x:_x, y:_y, _scale:Math.random()*1, time:_time, delay:_dly, transition:"easeInOutExpo"});
		}
		
	}

}

