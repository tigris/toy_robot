# Robot Simulator

## Usage

```ruby
  t = Robot.new
  t.place 0, 0, :east
  t.move
  puts t.report # 1,0,EAST
```

## Testing

If you have rake installed system wide, simply `rake test`. Otherwise `bundle install --path gems && bundle exec rake test`.

## Author

Danial Pearce <git AT tigris DOT id DOT au>
