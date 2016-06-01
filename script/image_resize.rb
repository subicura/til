prefix = 'changshin_'
idx = 1

Dir['*.jpg'].each do |filename|
	cmd = "convert \"#{filename}\" -thumbnail 1200x800 -background black -gravity center -extent 1200x800 #{prefix}#{("%02d" % idx)}.jpg"
	`#{cmd}`
	cmd = "convert \"#{filename}\" -resize 60x60^ -gravity center -crop '60x60+0+0' #{prefix}#{("%02d" % idx)}_thumb.jpg"
	`#{cmd}`

	idx += 1
end
