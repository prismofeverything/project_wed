package particle {
	
	import flash.events.*;
	import flash.display.MovieClip;
	
	import caurina.transitions.*;
	import caurina.transitions.properties.*;

	public class ParticleSystem extends MovieClip {
	
		
		private var _particles:Array = [];
		private var _num_particles:Number;
		
		private var _increment:Number;
		private var _curX:Number = -50;
		private var _curY:Number = 0;
		private var _padding = 50;
		
		public function ParticleSystem(num:Number){
			super();
			_num_particles = num;
			addEventListener(Event.ADDED_TO_STAGE, createChildren);
			DisplayShortcuts.init();
		}
		
		private function createChildren(event:Event):void {
			
			_increment = stage.stageWidth/_num_particles;
			_curX = 0;
			
			for (var i:Number = 0; i < _num_particles; i++){
				
				var item:Particle = new Particle();
				item.alpha = 0;
				_particles.push(item);
				
				trace(stage.stageWidth)
				
				var newX:Number = _curX + _increment;
				var newTime:Number = Math.random()*3 + 1;
				var newDelay:Number = i*.005;
				
				if (newX + _increment + _padding > stage.stageWidth){
					_curX = 0;
					_curY += 100;
					item.showParticle(newTime, newDelay);
					item.moveParticle(0, _curY, newTime, newDelay);
				} else {
					trace(_curX)
					_curX += _increment + _padding;
					item.showParticle(newTime, newDelay);
					item.moveParticle(_curX, _curY, newTime, newDelay);
					_curX++;
				}

				
				addChild(item);
			}
			
		}
		
		
		
		
		public function showParticle():void {
			this.alpha = 1;
		}
		public function hideParticle():void {
			this.alpha = 0;
		}
		
		public function moveParticle(_x:Number, _y:Number, _time:Number):void {
			Tweener.addTween(this, {x:_x, y:_y, time:_time, transition:"easeInOutExpo"});
		}
		
	}

}

