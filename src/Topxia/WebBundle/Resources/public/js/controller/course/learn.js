define(function(require, exports, module) {

    var LessonDashboard = require('../lesson/lesson-dashboard2');

    exports.run = function() {
        
        var dashboard = new LessonDashboard({
            element: '#lesson-dashboard'
        }).render();

    };

});