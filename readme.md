# Student Tracker

## Local Setup

    $ git clone https://github.com/wdidc/student_tracker
    $ cd student_tracker
    $ bundle install
    $ rake db:create
    $ rake db:migrate
    $ figaro install

To store sensitive information, add client ids and secrets to `config/application.yml`. 

You will need to get the client id and client secret by registering a new developer application at https://github.com/settings/applications/new

Here is a sample `config/application.yml` file:

```
github_client_id: "your github client id here"
github_client_secret: "your github client secret here"
```