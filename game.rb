require 'ray'

Ray.game "Avoid the Obstacles" do
  register { add_hook :quit, method(:exit!) }
  scene :square do
    @rect = Ray::Polygon.rectangle([0, 0, 20, 20], Ray::Color.blue)
    @rect.pos = [200,200]
    deleted = 0
    deletedcon = 0
    level = 0
    oldlevel = 0
    counts = 0
    yrand = 0
    max_x = window.size.width - 20
    max_y = window.size.height - 20
    @obstacles = 1.times.map do
      x = rand(max_x) + rand(10)
      y = rand(max_y) + 10
      g  = Ray::Polygon.rectangle([0,0,10,10], Ray::Color.red)
      g.pos = [1200+rand(100), y]

      g
    end
    on :mouse_motion do |pos|
      @rect.pos = pos
    end

    always do

      on :key_press, key(:q){ exit }
      on :key_press, key(:p){
        if level == -3
          level = oldlevel
        else
          oldlevel = level
          level = -3
        end
      }
      @game_over ||= @obstacles.any? { |e|
        [e.pos.x, e.pos.y, 10, 10].to_rect.collide?([@rect.pos.x, @rect.pos.y, 20,20])
      }
    #  @timeslow ||= @time_slow.any? { |e|
    #    [e.pos.x, e.pos.y, 10, 10].to_rect.collide?([@rect.pos.x, @rect.pos.y, 20,20])
    #  }
      @obstacles.each do |e|
        e.pos -= [3 + level, 0 + yrand]
      end

      @obstacles.reject! { |e|
        e.pos.x < 0
      }
      if rand(5) == 1
        @obstacles += 1.times.map do
          x = rand(max_x) + rand(10)
          y = rand(max_y) + 10

          g  = Ray::Polygon.rectangle([0,0,10,10], Ray::Color.red)
          g.pos = [1200+rand(100), y]

          g
        end
      end
      if rand(10) == 5
        @time_slow = 1.times.map do
          x = rand(max_x) + rand(10)
          y = rand(max_y) + 10

          g  = Ray::Polygon.rectangle([0,0,10,10], Ray::Color.white)
          g.pos = [100+rand(100), y]

          g

        end
      end

      deleted = deleted + 1
      if deleted % 1000 == 0
        level += 1
      end
    end
    render do |win|
      if @game_over

        win.draw text("YOU LOST", :at => [180,180], :size => 60)
        #win.draw text("Score:" + deletedcon.to_s, :at => [220,300], :size => 20)
      elsif deleted < 200
        win.draw text("Get Ready", :at => [180,180], :size => 60)
      else
        win.draw text("Score:" + deleted.to_s, :at => [10,10], :size => 20)
        win.draw text("Level:" + level.to_s, :at => [550,10], :size => 20)
        @obstacles.each { |g| win.draw(g) }
        win.draw @rect
        #win.draw @time_slow

      end

    end
  end
  scenes << :square
end
