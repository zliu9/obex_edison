#!/usr/bin/node
var fs = require('fs');
var exec = require('child_process').exec;
var execFile = require('child_process').execFile;

var dir = '.';

if(process.argv.length > 2)
  dir = process.argv[2];

console.log('watching ' + dir);

fs.watch(dir, function (event, filename) {

  console.log('event is: ' + event);
 
  if (filename) {
    console.log('filename provided: ' + filename);
  } else {
    console.log('filename not provided');
  }

  if(event == "change" || event == "rename") {

    var cmd = __dirname + "/" + filename + ".sh";
    console.log("check script " + cmd);

    if(fs.existsSync(cmd)) {

      var target = dir + "/" + filename;
      console.log("target: " + target);


      execFile(cmd, 
               [target], 
               {"cwd" : __dirname}, 
               function(error, stdout, stderr) {

        if(error){
          console.log(cmd + " error");
          console.log(error);
        } else {
          console.log(cmd + " OK");
        }
        console.log(stdout);
        console.log(stderr);
      });
    } else {
      console.log(cmd + " doesn't exist");
    }
  } 
});
