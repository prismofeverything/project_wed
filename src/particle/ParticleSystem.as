package particle {
	
	import flash.events.*;
	import flash.display.MovieClip;
	
	import caurina.transitions.*;
	import caurina.transitions.properties.*;

	public class ParticleSystem extends MovieClip {
	
		
		public var _particles:Array = [];
		
		private var _num_particles:Number;
		
		private var _increment:Number;
		private var _curX:Number = 0;
		private var _curY:Number = -100;
		private var _padding = 20;
		
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
				_particles.push(item);
								
				item.alpha = 0;
				
				var newX:Number = _curX + _increment;
				var newTime:Number = Math.random()*3 + 1;
				var newDelay:Number = i*.005;
				
				if (newX + _increment + _padding > stage.stageWidth){
					_curX = 0;
					_curY += 20;
					item.showParticle(newTime, newDelay);
					item.moveParticle(0, _curY, newTime, newDelay);
					item._startX = 0;
					item._startY = _curY;
				} else {
					trace(_curX)
					_curX += _increment + _padding;
					item.showParticle(newTime, newDelay);
					item.moveParticle(_curX, _curY, newTime, newDelay);
					_curX++;
					item._startX = _curX;
					item._startY = _curY;
				}

				addChild(item);
				
			}
			
		}
		
		
	}

}

