def max(a, b)
  a > b ? a : b
end

def min(a, b)
  a < b ? a : b
end

def time_range
  hours = [rand(24), rand(24)]
  { "#{min(*hours).to_s.rjust(2, '0')}:00" => "#{max(*hours).to_s.rjust(2, '0')}:00" }
end

FactoryGirl.define do
  factory :schedule do
    timezone { Faker::Address.time_zone }
    holidays { (0..rand(10)).to_a.map { Faker::Date.between(Time.zone.today, 1.year.from_now) } }
    breaks do
      {
        Faker::Date.between(Time.zone.today, 1.year.from_now) => { '09:00' => '10:30', '16:00' => '16:30' },
        Faker::Date.between(Time.zone.today, 1.year.from_now)  => { '12:15' => '12:45', '13:30' => '14:00' },
        Faker::Date.between(Time.zone.today, 1.year.from_now)  => time_range
      }
    end
    hours do
      amount = rand(0)
      amount = 1 if amount < 1
      days = [:mon, :tue, :wed, :thu, :fri, :sat, :sun]
      days.sample(amount).each_with_object({}) do |day, hash|
        hash[day] = time_range
        hash
      end
    end
  end

  factory :full_schedule, parent: :schedule do
    hours do
      {
        mon: { '00:00' => '24:00' },
        tue: { '00:00' => '24:00' },
        wed: { '00:00' => '24:00' },
        thu: { '00:00' => '24:00' },
        fri: { '00:00' => '24:00' },
        sat: { '00:00' => '24:00' },
        sun: { '00:00' => '24:00' }
      }
    end
  end
end
