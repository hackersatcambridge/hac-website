// Currently a dummy file to add entry points for the various static assets we have
// If you want to add a new JS or CSS entry point, do it in gulpfile.js and not here
var req = require.context('./images', true, /^.*$/);
req.keys().forEach(function(key){
    req(key);
});
