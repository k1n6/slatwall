/// <reference path='../../../typings/hibachiTypescript.d.ts' />
/// <reference path='../../../typings/tsd.d.ts' />
class SWDirective{
	public static Factory(){
		var directive = (
			$compile
		)=>new SWDirective(
			$compile
		);
		directive.$inject = [
			'$compile'
		];
		return directive;
	}
    //@ngInject
	constructor(
		$compile
	){
		return {
			restrict: 'AE',
			//replace:true,
			scope:{
				variables:"=", //{key:value}
				directiveTemplate:"="
			},
			controllerAs: "swDirective",
			link: function(scope, element, attrs) {

		        var template = '<' + scope.directiveTemplate + ' ';
				
				
		        if(angular.isDefined(scope.variables)){
			        angular.forEach(scope.variables, function(value,key){
						if(!angular.isString(value)){
							template += ' ' + key + '="swDirective.' + 'variables.' + key + '" ';
						} else { 
			        		template += ' ' + key + '="' + value + '" ';
						}
			        });
			    }

		        template += '>';
		        template += '</'+scope.directiveTemplate+'>';

		        // Render the template.
		        element.html($compile(template)(scope));
		    }
		};
	}
}
export{
	SWDirective
}