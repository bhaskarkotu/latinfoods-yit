class StatisticsController < ApplicationController
	
	def index
		@lc= Gchart.line(:data => [0, 40, 10, 70, 20])
		@bc = Gchart.bar(:title => "Matt vs Rob",
           :data => [[300, 100, 30, 200], [100, 200, 300, 10]], 
           :bar_colors => 'FF0000,00FF00',
           :stacked => false, :size => '400x200',
           :legend => ["Matt's Mojo", "Rob's Mojo"] )
		@pc = Gchart.pie_3d(:title => 'ruby_fu', :size => '400x200',
              :data => [10, 45, 45], :labels => ["DHH", "Rob", "Matt"] )
	end

end
