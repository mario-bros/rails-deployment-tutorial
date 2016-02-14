module ArticlesHelper

  def get_season()
    time = Time.now

    if (time.month >=3) && (time.month <=5)
      "Yeah it is Spring"
    elsif (time.month > 5) && (time.month <= 8)
      "Everyone Loves Summer"
    elsif (time.month > 8) && (time.month <= 10)
      "Put on Your Coat because the Fall is here"
    else
      "Yuck winter"
    end
  end
end
