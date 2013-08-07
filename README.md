ZenCMS
=========

ZenCMS is a simple and robust content management system for developers, designers and their clients. It features:

  - Flexible schema for defining content types
  - Liquid templating engine for quick and readable templates
  - Revision history
  - Inline editing
  - Easy form creation
  - Based on Foundation and mobile friendly out of the box

Why?
----------

You're building a website. You need to display information on this website. 

Let's say you're building website for a brewery. They need to show information about their various brews and upcoming events. The information associated with a beer and event page are very different.

You can define **types**. In our case, `beer` and `event`. You can add **attributes** to each type, for beers: Name(string), description(text), alcohol content(float) and a product image. Each instance of a type is called an **entity** and can be created and modified through the admin panel or with forms for users.

Now we need to show off your client's libations. We can link a template or **layout** to our beer type. Then, we can semantically show off their ales and dynamically generate pages:
```html
<h1>{{ beer.name }}</h1>
<p>{{ beer.description }}</p>
<small>{{ beer.alcohol_content }}</small>
```
Our client also wants to creating groupings of their suds. We can do this through **collections** which can be defined by rules, *e.g. beers w/ > 6% alcohol content* or by manually selecting them, *e.g. staff picks*. We can show off collections too:
```html    
<ul>
{% for beer in staff_picks %}
  <li><a href='{{ beer.url }}'>{{ beer.name }}</a></li>
{% endfor %}
</ul>
```

Oh and we also need to setup a bunch of static **pages** such as a contact page, home page, etc... That's easy, we can do it with HTML, HAML or Markdown. If our client needs to make changes, they can do it inline and without ever looking at code.

Sometimes our client has events that feature particular brewskis and we want to display those on the event pages. We can link types with 1-1 or 1-N **relationships**.

Every website is different and naturally their content should be modeled differently. You should be able to define what types of content you are going to display and what attributes make up each content type. It is probably good practice to think of and build content sites this way. Oh, and it can do the generic stuff too, like be a blog or photo gallery.

Other CMS solutions don't abstract or simplify this enough, and/or they provide custom fields that are neither typed nor helpful and require hacky workarounds as well as touching the internals of the CMS. 

How?
----------

This project is currently a Rails 4 and MongoDB application. It will run on Heroku or your local machine. A gem or one click install solution is in the works, but until then:

Clone this repo, install gems, start the server and start building!
```bash    
git clone https://github.com/cmpolis/zencms
cd zencms
bundle install
rails s --port 4321
# Open a browser and go to localhost:4321
```

Who?
----------

Project created by [@ChrisPolis](http://twitter.com/ChrisPolis) and released under the [MIT License](http://www.opensource.org/licenses/MIT).
