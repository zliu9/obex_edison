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

  if((event == "change" || event == "rename") && filename == "wpa_supplicant.conf") {


    var target = dir + "/" + filename;
    console.log("target: " + target);


    execFile("./wpa_modify.sh", 
             [target], 
             {"cwd" : __dirname}, 
             function(error, stdout, stderr) {

      console.log("finished setup wifi");

      if(error)
        console.log(error);

      console.log(stdout);
      console.log(stderr);
    });
  }
});
