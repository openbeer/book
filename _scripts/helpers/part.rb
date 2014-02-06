# encoding: utf-8

##########################
# part helpers


#####
# todo: find a better name for ender_toc_countries ??


def render_toc_countries( countries, opts={} )
  buf = ''
  countries.each do |country|
  
    #<!-- fix: add to models -> countries_w_breweries_or_beers ?? -->
    # <!-- todo: use helper e.g. has_beers_or_breweries? or similar  ?? -->
    beers_count     = country.beers.count
    breweries_count = country.breweries.count
    
    next if beers_count == 0 && breweries_count == 0
    
    buf << link_to_country( country, opts )
    buf << " - "
    buf << "_#{beers_count} Beers, #{breweries_count} Breweries_{:.count}"
    buf << "  <br>"
    buf << "\n"
  end
  buf
end


def render_cities( cities )
  #### <!-- add/fix: cities_w_breweries collection!!! -->
  buf = ''
  cities.each do |city|
    # note: skip cities without breweries
    buf << render_city( city )   if city.breweries.count > 0
  end
  buf
end


def render_breweries( breweries )
  buf = ''
  breweries.each do |brewery|
    buf << render_brewery( brewery )
  end
  buf
end


def render_beers( beers )
  buf = ''
  beers.each_with_index do |beer,i|
    buf << " • \n" if i > 0
    buf << render_beer( beer )
  end
  buf << "\n"
  buf
end


def render_city( city )
  tmpl       = File.read_utf8( '_templates/shared/_city.md.erb' )
  render_erb_template( tmpl, binding )
end

def render_brewery( brewery )
  tmpl       = File.read_utf8( '_templates/shared/_brewery.md.erb' )
  render_erb_template( tmpl, binding )  
end

def render_beer( beer )
  tmpl       = File.read_utf8( '_templates/shared/_beer.md.erb' )
  render_erb_template( tmpl, binding )
end

