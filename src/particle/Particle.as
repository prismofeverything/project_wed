package particle {
	
	import flash.events.*;
	import flash.display.MovieClip;
	
	import flash.geom.Point;
	
	import caurina.transitions.*;
	import caurina.transitions.properties.*;

	public class Particle extends MovieClip {
	
		private var _particle:MovieClip;
		
		private var _curDly:Number = 0;
		private var vortex:Number = 50;
		
		public var _startX:Number;
		public var _startY:Number;
		
		private var breathing:Boolean = false;
	
	
		public function Particle(){
			super();
			addEventListener(Event.ADDED_TO_STAGE, createChildren);
			ColorShortcuts.init();
			DisplayShortcuts.init();
		}
		
		private function createChildren(event:Event):void {
			
			
			_particle = new ParticleClip();
			_particle.alpha = 0;
			this.buttonMode = true;
			
			this.alpha = .4;
			this.x = _startX;
			this.y = _startY;
			addChild(_particle);
			
			startBreathing();
			
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
			
			vortex = 50;
			
			this.stopDrag();      	
			removeEventListener(Event.ENTER_FRAME, followMouse);
			removeEventListener(Event.ENTER_FRAME, watchMouse);
			
			hideParticle();
			
			
			startBreathing();
			
		}
		
	
		private function getDist(x1:Number, y1:Number, x2:Number, y2:Number):Number {
		    var dx:Number = x1 - x2;
		    var dy:Number = y1 - y2;
		    var dist:int = Math.sqrt(dx*dx + dy*dy);
		    return dist;
		}
		
		
		private function watchMouse(event:Event):void {
			
			var mouseDist:int = getDist(_particle.mouseX, _particle.mouseY, _particle.x, _particle.y);
		
			vortex++;
			
		    if (mouseDist > vortex) {
				//stopBreathing();
		       	_particle.alpha = .4;
				hideParticle();
				removeEventListener(Event.ENTER_FRAME, followMouse);
		    }else {
				startBreathing();
				this.startDrag();      	
				_particle.alpha = 1;
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
	
			Tweener.addTween(this, {x:location.x, y:location.y, time:.5, delay:Math.random()*1, transition:"easeInOutExpo"});
		}
		
		
		private function breath(event:Event = null):void {
			if (breathing == true){
				var newX = (this.x - 1) + (this.x + Math.random()*2);
				var newY = (this.y - 1) + (this.y + Math.random()*2);
				this.x = newX;
				this.y = newY;
				/*Tweener.addTween(this, {x:newX, y:newY, time:Math.random()*1, transition:"easeNone", onComplete:breath});*/
			}
		}
		
		
		public function showParticle(_time:Number = .5, _dly:Number = 0):void {
			this.alpha = 1;
		}
		public function hideParticle(_time:Number = .5):void {
			//Tweener.addTween(this,{alpha:.2, time:.2});
			this.alpha = .4;
		}
		
		public function moveParticle(_x:Number, _y:Number, _time:Number = 0, _dly:Number = 0):void {
			Tweener.addTween(this, {x:_x, y:_y, _scale:(Math.random()*.5) + .1, time:_time, delay:_dly, transition:"easeInOutExpo"});
		}
		
	}

}

