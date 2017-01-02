Automatically mark all Pivotal Tracker stories delivered as accepted, if they've sat unaccepted for more than X days.

### Setup

```
$ export PIVOTAL_TOKEN=...
$ export PIVOTAL_PROJECT_NUMBER=...
$ export PIVOTAL_ACCEPT_AFTER_DAYS=7
$ bundle exec ruby pivotal_auto_accept.rb 
```

Any story (feature or bug) that is currently in the delivered state, that has been in that state for more than X days, will be marked as accepted. A comment will be added to that story to signify that it's been automatically accepted.


### TODO
* remove local git submodule when `tracker_api` is updated
* update script to handle multiple projects



