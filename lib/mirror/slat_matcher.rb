module Mirror
  class SlatMatcher
    def initialize(ad)
      @ad = ad
    end

    def perform
      slats = Slat.all
      ads = Ad.where.not(status: :pending)
        .where("end_at >= ?", @ad.start_at)
        .where("start_at <=?", @ad.end_at)

      booked_ads = ads.select do |ad| # 走期內有其他廣告
        ad.start_at.in?(@ad.period) || ad.end_at.in?(@ad.period)
      end

      booked_slats = booked_ads.map &:slat

      if booked_slats.present?
        slats.find { |slat| booked_slats.exclude? slat }
      else
        slats.first
      end
    end

  end
end
