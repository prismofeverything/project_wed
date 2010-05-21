package particle {
	
	import flash.events.*;
	import flash.display.MovieClip;
	
	import flash.geom.Point;
	
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
			_particle.alpha = 0;
			this.buttonMode = true;
			
			this.alpha = .2;
			this.x = _startX;
			this.y = _startY;
			addChild(_particle);
			
			createEvents();
			
		}
		
		private function createEvents():void {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, dragIt);
			stage.addEventListener(MouseEvent.MOUSE_UP, releaseIt);
		}
		
		
		private function dragIt(event:MouseEvent):void {
			addEventListener(Event.ENTER_FRAME, watchMouse);
		}
		private function releaseIt(event:MouseEvent):void {
			removeEventListener(Event.ENTER_FRAME, followMouse);
			removeEventListener(Event.ENTER_FRAME, watchMouse);
			hideParticle();
			var newX = (_startX - 4) + (_startX + Math.random()*8);
			var newY = (_startY - 4) + (_startY + Math.random()*8);
			Tweener.addTween(this, {x:newX, y:newY, time:1, transition:"easeNone", delay:Math.random()*5, onComplete:breath});
		}
		
	
		private function getDist(x1:Number, y1:Number, x2:Number, y2:Number):Number {
		    var dx:Number = x1 - x2;
		    var dy:Number = y1 - y2;
		    var dist:int = Math.sqrt(dx*dx + dy*dy);
		    return dist;
		}
		
		
		private function watchMouse(event:Event):void {
			
			var mouseDist:int = getDist(_particle.mouseX, _particle.mouseY, _particle.x, _particle.y);
			
		    if (mouseDist > 200) {
				stopBreathing();
		       	_particle.alpha = .2;
				hideParticle();
				removeEventListener(Event.ENTER_FRAME, followMouse);
		    }else {
				startBreathing();
				this.startDrag();      	
				_particle.alpha = .8;
				showParticle();
				addEventListener(Event.ENTER_FRAME, followMouse);
		    }

		}
		
		
		
		private function startBreathing(event:Event = null):void {
			breathing = true;
			breath();
		}
		private function stopBreathing(event:Event = null):void {
			breathing = false;
		}
		
		
		
		private function followMouse(event:Event):void {
	
			var location = new Point();
	     	location.x = stage.mouseX;
	     	location.y = stage.mouseY;
	
	     	this.localToGlobal(location);
	
			Tweener.addTween(this, {x:location.x, y:location.y, time:Math.random()*5, delay:Math.random()*5, transition:"easeInOutExpo"});
		}
		
		
		private function breath(event:Event = null):void {
			if (breathing == true){
				var newX = (_startX - 4) + (_startX + Math.random()*8);
				var newY = (_startY - 4) + (_startY + Math.random()*8);
				Tweener.addTween(this, {x:newX, y:newY, time:1, transition:"easeNone", onComplete:breath});
			}
		}
		
		
		public function showParticle(_time:Number = .5, _dly:Number = 0):void {
			this.alpha = 1;
		}
		public function hideParticle(_time:Number = .5):void {
			Tweener.addTween(this,{alpha:.2, time:.2});
		}
		
		public function moveParticle(_x:Number, _y:Number, _time:Number = 0, _dly:Number = 0):void {
			Tweener.addTween(this, {x:_x, y:_y, _scale:(Math.random()*.5) + .1, time:_time, delay:_dly, transition:"easeInOutExpo"});
		}
		
	}

}

