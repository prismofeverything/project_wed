package app {
	
	import flash.events.*;
	import flash.events.ProgressEvent;
	
	import flash.display.MovieClip;
	
	import caurina.transitions.*;
	import caurina.transitions.properties.*;
	
	import flash.net.URLRequest;
	import flash.display.Loader;
	

	public class Main extends MovieClip {
		
		private var _fluid:MovieClip;
		
		
		public function Main(){
			super();
			addEventListener(Event.ADDED_TO_STAGE, createChildren);
			DisplayShortcuts.init();
		}
		
		private function createChildren(event:Event):void {
			
			_fluid = new MovieClip();
			addChild(_fluid);
			
			var fluidLoader:Loader = new Loader();
			var fluidRequest:URLRequest = new URLRequest("FluidSolverHD.swf");
			
			fluidLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			fluidLoader.load(fluidRequest);

		}
		
		private function onCompleteHandler(event:Event){
			_fluid.addChild(event.target.content)
		}
		

	}

}

