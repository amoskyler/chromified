## Getting Started
- modify ```src/chrome.sh``` with your own chrome profiles
	 - Profiles on OSX found in ```~/Library/Application\ Support/Google/Chrome/```
- ```chmod 755 src/chrome.sh```
- ```cp src/chrome.sh /local/bin/chrome```

## Commands
```-u me``` or ```--user me``` : open the user folder associated with me (me is arbitrary )

```-n``` or ```--incognito``` : open incognito

```-w example.com``` or ```--website example.com``` : open example.com

```-a --someflag=false``` or ```--arbitrary --someflag=false``` : passes arbitrary options to chrome binary _Note:_ Does not chain currently