require './lib/CTParser.rb'
require './lib/CTValidator.rb'
require './lib/CTManager.rb'
require './lib/CTPrinter.rb'

ctp = CTParser.new('./data/talks.txt')
validated_talks = CTValidator.new(ctp.talks)
ctm = CTManager.new(validated_talks.talks)
ctp = CTPrinter.new(ctm.talks, ctm.tracks)
ctp.calc_total_length
ctp.print_schedule
