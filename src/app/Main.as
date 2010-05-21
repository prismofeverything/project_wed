package app {
	
	import flash.events.*;
	import flash.events.ProgressEvent;
	
	import flash.display.MovieClip;
	
	import caurina.transitions.*;
	import caurina.transitions.properties.*;
	
	import flash.net.URLRequest;
	import flash.display.Loader;
	
	import particle.*;

	public class Main extends MovieClip {
		
		private var _particleSystem:ParticleSystem;
		
		public function Main(){
			super();
			addEventListener(Event.ADDED_TO_STAGE, createChildren);
			DisplayShortcuts.init();
		}
		
		private function createChildren(event:Event):void {
			_particleSystem = new ParticleSystem(90);
			addChild(_particleSystem);
		}

	}

}

