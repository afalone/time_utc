Dir["./lib/**/*.rb"].each {|file| require file }
require 'tzinfo'
class TimeApi < Sinatra::Base

  configure *%i(staging production development test) do
    enable :logging
    zones = TZInfo::Timezone.all.inject({}){|rez, zone| rez.merge(zone.friendly_identifier(true) => zone) }
    set :zones, zones
  end

  error do
    logger.info env['sinatra.error'].name
  end

  get '/time' do
    @times = [['UTC', Time.now.getgm]]
    cities_param = params.keys.first
    if cities_param
      cities = cities_param.split(',').map(&:strip)
      cities.each do |city|
        next unless settings.zones.has_key?(city)
        @times << [city, settings.zones[city].now]
      end
    end

    haml :'time'
  end
end
