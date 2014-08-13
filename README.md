## Starter Kit for Blocipedia


### To Get Started

- Clone the repo to your local environment (or Vagrant).
- Do a Find and Replace for `BlocipediaStarter` throughout the repo. Replace it with your (camel-cased) app name.
- Bundle install (delete or comment HAML line first, if you'd prefer ERB).
- Edit config/database.yml (replace app and user names with your own).
- Create the relevant databases (`rake db:create`).
- Replace this Readme with a description of your app and its hosted location.


### Includes

- PostgreSQL as database (locally and on production)
- Sass
- Basic Rails asset technologies (Coffeescript, jQuery, etc)
- Debugging tools (Better Errors, Binding Pry)
- Testing tools (RSpec, Factory Girl, Database Cleaner, Capybara)


### Included tests

- Model tests for User, Wiki, and Collaboration. (You have to create the models). The specs just test out the associations. Read through them to get a sense for how your associations might ideally work. Then try to get them to pass.


### Pointers

- Use the model specs as a guide to get your app's model relationships up and running.
- Feel free to comment out particular tests to narrow down the scope of your TDD -- get them to pass one at a time, from the easiest to the hardest.
- Also feel free to abandon the relationships as the specs define them and do your own work. The specs are just there to suggest an ideal solution. If they're more of an obstacle than a help, delete them.
- Commit early, commit often. Branch early, branch often. Try to take out one task at a time, and carefully consider what each task involves before launching into it. 
- Read through [our guide to Has Many Through relationships](https://www.bloc.io/resources/has-many-through) and the complete [Rails guide to Active Record associations](http://guides.rubyonrails.org/association_basics.html), so you know your tools for setting up these complex associations.
- Some options for `has_many` and `belongs_to` that you may want to look into and use: `:source`, `:class_name`, `:foreign_key`, and `:through` (all described in the Rails Guide to associations.