# mozenda

*mozenda* is a ruby gem for interacting with [mozenda](https://www.mozenda.com/) via their [api](https://www.mozenda.com/api).

## Installation

Add this line to your application's Gemfile:

    gem 'mozenda'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mozenda

## Usage

*mozenda* requires a WebServiceKey to be configured.  The following code configures *mozenda* (*config/initializers* is a good place for this).
```ruby
Mozenda.configuration do |config|
  config.web_service_key = "your-mozenda-web-service-key"
end
```

To add single item to Collection:
```ruby
collection_id = 1046
collection = Mozenda::Model::Collection.new(collection_id)
collection.add_item({
  "Field1" => "qq",
  "Field3" => 123
})
```

To add many items to Collection from XML file:
```ruby
path_to_xml_file = Pathname.new("./bulk_test.xml").realpath.to_s
collection_id = 1046
collection = Mozenda::Model::Collection.new(collection_id)
collection.add_items_from_file(path_to_xml_file)
```

To clear Collection:
```ruby
collection_id = 1046
collection = Mozenda::Model::Collection.new(collection_id)
collection.clear
```

To simple run Agent:
```ruby
agent_id = 1050
agent = Mozenda::Model::Agent.new(agent_id)
agent.run
```
  
To run Agent with optional params:
```ruby
agent_id = 1050
agent = Mozenda::Model::Agent.new(agent_id)
agent.run({
  "MyParam1" => 123,
  "my-other-param" => "imba!"
})
```
  
To run Agent with Job.StatusUrl:
```ruby
agent_id = 1050
agent = Mozenda::Model::Agent.new(agent_id)
optional_params = {:foo => 123, :bar => "xyz"}
agent.run(optional_params, {
  :status_url => "http://localhost:3000/some/path",
  :replacement_values => [:job_id, :job_status, :job_ended]
})
```
  
To get Agent info:
```ruby
agent_id = 1050
agent = Mozenda::Model::Agent.new(agent_id)
agent_get_response = agent.get
agent_get_response.to_h
agent_get_response.to_xml
```

To simple publish Collection:
```ruby
collection_id = 1055
collection = Mozenda::Model::Collection.new(collection_id)
collection_publish_response = collection.publish
collection_publish_response.to_h
collection_publish_response.to_xml
```

To publish Collection with some status URL & replacement values:
```ruby
collection_id = 1055
collection = Mozenda::Model::Collection.new(collection_id)
params = {
  :status_url => "http://my-app.com/-mozen-on-publish-url?my_param=123&other_param=foo",
  :replacement_values => [:job_id, :job_status, :job_created, :job_ended]
}
collection_publish_response = collection.publish(params)
collection_publish_response.to_h
collection_publish_response.to_xml
```

Replacement values (defined in Mozenda::REPLACEMENT_VALUES) for Collection.Publish and/or Agent.Run:
```ruby
Mozenda::REPLACEMENT_VALUES = {
  agent_id: "AgentID",
  agent_name: "Agent.Name",
  agent_description: "Agent.Description",
  agent_domain: "Agent.Domain",
  job_id: "JobID",
  job_status: "Job.Status",
  job_created: "Job.Created",
  job_ended: "Job.Ended",
  job_name: "Job.Name",
  job_description: "Job.Description"
}
```

To generate XML file for bulk Collection.AddItem:
```ruby
data = [
  {
    'Name' => "Bob",
    "Age" => 12
  },
  {
    'Name' => "Ed",
    "Age" => 99
  },
  {
    'Name' => "Kate",
    "Age" => 23
  }
]
xml_generator = Mozenda::XmlGenerator.new(data)
xml = xml_generator.generate
```

result XML:
```xml
<?xml version="1.0" encoding="utf-8"?>
<ItemList>
  <Item>
    <Name>Bob</Name>
    <Age>12</Age>
  </Item>
  <Item>
    <Name>Ed</Name>
    <Age>99</Age>
  </Item>
  <Item>
    <Name>Kate</Name>
    <Age>23</Age>
  </Item>
</ItemList>
```

To get Job details:
```ruby
job_id = "7E08EB1F-DDA6-4459-BBDA-3F88B4AB7B7C"
job_get_response = Mozenda::Model::Job.get(job_id)
job_get_response.job_id # => "7E08EB1F-DDA6-4459-BBDA-3F88B4AB7B7C"
job_get_response.state # => "Done"
job_get_response.error? # => false
```

To pause running Job:
```ruby
job_id = "E656D634-C63F-46D9-AFB5-C9AE1F1F2A9E"
job_pause_response = Mozenda::Model::Job.pause(job_id)
job_pause_response.to_xml
job_resume_response.to_h
```

To resume Job that is in a Paused or Error state:
```ruby
job_id = "7E08EB1F-DDA6-4459-BBDA-3F88B4AB7B7C"
job_resume_response = Mozenda::Model::Job.resume(job_id)
job_resume_response.to_xml
job_resume_response.to_h
```

To cancel Job that is in a Paused or Error state:
```ruby
job_id = "7E08EB1F-DDA6-4459-BBDA-3F88B4AB7B7C"
job_cancel_response = Mozenda::Model::Job.cancel(job_id)
job_resume_response.to_xml
job_resume_response.to_h
```


## TODO
* Implement requests-per-minute limit.
* Implement other Mozenda services

## License

This software is relased under the [MIT license](LICENSE.md).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
