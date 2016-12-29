Automatically mark all Pivotal Tracker stories delivered more than X days ago as accepted.

### Setup

```
$ export PIVOTAL_TOKEN=...
$ export PIVOTAL_PROJECT_NUMBER=...
$ export PIVOTAL_ACCEPT_AFTER_DAYS=7
$ bundle exec ruby pivotal_auto_accept.rb 
```
Any story (feature or bug) that is currently in the delivered state, that has been in that state for more than X days, will be marked as accepted.



