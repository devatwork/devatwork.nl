---
title: grunt-contrib-gluejs2
layout: project
abstract: 'A Grunt plugin for GlueJS v2.2+.'
tags: ['gluejs', 'grunt', 'task', 'commonjs', 'browserify']
git: https://github.com/devatwork/grunt-contrib-gluejs2
npm: https://npmjs.org/package/grunt-contrib-gluejs2
travisci: https://travis-ci.org/devatwork/grunt-contrib-gluejs2
---

A Grunt plugin for [GlueJS](http://mixu.net/gluejs/) v2.2+. GlueJS is package Node/CommonJS modules for the browser.

## Getting Started
This plugin requires Grunt `~0.4.1`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-contrib-gluejs2 --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-contrib-gluejs2');
```

## The "gluejs" task

### Overview
In your project's Gruntfile, add a section named `gluejs` to the data object passed into `grunt.initConfig()`.

```js
grunt.initConfig({
	gluejs: {
		options: {
			// Task-specific options go here.
		},
		your_target: {
			// Target-specific file lists and/or options go here.
		}
	}
})
```

### Options

Please consult the documentation of GlueJS for details about all available options at [http://mixu.net/gluejs/](http://mixu.net/gluejs/#api_usage_example). This plugin supports all options of version 2.2.

#### options.banner

Type `String` Default value `''`

The text to use as a banner. Templated strings are perfectly acceptable and encouraged.

#### options.footer

Type `String` Default value `''`

The text to use as a footer. Templated strings are perfectly acceptable and encouraged.

### Usage examples

#### Basic Use
In this example, `grunt gluejs` (or more verbosely, `grunt gluejs:app`) will package recursively every file in the directory `public/scripts` to one single file: `public/app.js`. The package will be available in a browser environement under one single global variable: `App`.

```javascript
// Project configuration.
grunt.initConfig({
	gluejs: {
		app: {
			options: {
				export: 'App'
			},
			src: 'public/scripts/**/*.js',
			dest: 'public/app.js'
		}
	}
});
```

## Release History

* 2014-01-04   v0.1.1   Small fixes.
* 2014-01-04   v0.1.0   Initial NPM release.
* 2014-01-04   v0.0.1   Initial release.

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [Grunt](http://gruntjs.com/).

## Copyright

Copyright (c) 2014 Bert Willems and contributors.

## License

This project is licensed under [MIT](http://www.opensource.org/licenses/mit-license.php "Read more about the MIT license form"). Refer to LICENCE for more information.
