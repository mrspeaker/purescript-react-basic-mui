exports._eqDisplayProp = function(left){ return function(right){ return left === right }};
exports._ordDisplayProp = function(left){ return function(right){ return (left === right) ? 0 : (left > right) ? 1 : -1 }};