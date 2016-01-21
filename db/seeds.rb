user = User.first_or_create(:username => 'Agung', :first_name => 'agung', :last_name => '41studio', :email => 'agung@41studio.com', :role => 1, :password => 'top secret', confirmed_at: Time.now)

user = User.create :username => 'Kris', :first_name => 'Kris', :last_name => 'Dhinal', :email => 'kris@41studio.com', :role => 1, :password => '24121987', :confirmed_at => Time.now

# user = User.create :username => 'Lara', :first_name => 'Lara', :last_name => 'Crof', :email => 'krisdhinal@gmail.com', :role => 0, :password => 'akiyama', :confirmed_at => Time.now

destinations = ['Pangandaran', 'Bali', 'Bukit Moko']

destinations.each do |destination|
  d = Destination.first_or_create(name: destination)

  group = Group.first_or_create(name: "#{destination} Grup", lat: 11111, lng: 22222, location: destination, user_id: user.id)

  trip = Trip.first_or_create(group_id: group.id, start_to_trip: Date.today + 2.day, end_to_trip: Date.today + 5.day, user_id: user.id, destination_id: d.id)
end

categories = ['Pantai', 'Wisata', 'Laut', 'Taman']

categories.each do |category|
  Category.first_or_create(plan_category: category)
end


puts "start create Provinsi and city on indonesia"
location = {
  "Indonesia" => {
    "Bali" => [
      'Karangasem',
      'Badung',
      'Bangli',
      'Buleleng',
      'Klungkung',
      'Tabanan',
      'Gianyar',
      'Denpasar',
      'Jembrana'
    ],
    "Bangka Belitung" => [
      'Bangka Selatan',
      'Belitung',
      'Bangka',
      'Pangkal Pinang',
      'Belitung Timur',
      'Bangka Barat',
      'Bangka Tengah'
    ],
    "Banten" => [
      'Pandeglang',
      'Serang',
      'Lebak',
      'Tangerang',
      'Cilegon',
      'Serang'
    ],
    "Bengkulu"=> [
      'Bengkulu Utara',
      'Seluma',
      'Bengkulu',
      'Kepahiang',
      'Rejang Lebong',
      'Kaur',
      'Bengkulu Selatan',
      'Lebong',
      'Muko-Muko'
    ],
    "D.I. Yogyakarta" =>[
      'Bantul',
      'Sleman',
      'Yogyakarta',
      'Kulon Progo',
      'Gunung Kidul'
    ],
    "DKI Jakarta" =>[
      'Jakarta Timur',
      'Jakarta Pusat',
      'Jakarta Barat',
      'Jakarta Selatan',
      'Jakarta Utara',
      'Kepulauan Seribu'
    ],
    "Gorontalo" =>[
      'Gorontalo',
      'Gorontalo Utara',
      'Bone Bolango',
      'Boalemo',
      'Gorontalo',
      'Pahuwalo'
    ],
    "Jambi" =>[
      'Kerinci',
      'Batang Hari',
      'Merangin',
      'Sarolangun',
      'Bungo',
      'Tanjung Jabung Barat',
      'Jambi',
      'Tanjung Jabung Timur',
      'Muaro Jambi',
      'Tebo '
      ],
    "Jawa Barat" =>[
      'Cianjur',
      'Bandung',
      'Indramayu',
      'Majalengka',
      'Cirebon',
      'Purwakarta',
      'Garut',
      'Banjar',
      'Ciamis',
      'Bekasi',
      'Sukabumi',
      'Tasikmalaya',
      'Karawang',
      'Sukabumi',
      'Bandung Barat',
      'Depok',
      'Subang',
      'Bogor',
      'Sumedang',
      'Kuningan',
      'Tasikmalaya',
      'Cimahi',
      'Cirebon'
      ],
    "Jawa Tengah" =>[
      'Kebumen',
      'Cilacap',
      'Tegal',
      'Banyumas',
      'Semarang',
      'Boyolali',
      'Pemalang',
      'Salatiga',
      'Kudus',
      'Purworejo',
      'Sukoharjo',
      'Bojonegoro',
      'Batang',
      'Magelang',
      'Jepara',
      'Blora',
      'Brebes',
      'Banjarnegara',
      'Surakarta',
      'Temanggung',
      'Semarang',
      'Pati',
      'Wonogiri',
      'Klaten',
      'Purbalingga',
      'Kendal',
      'Pekalongan',
      'Demak',
      'Grobogan',
      'Rembang',
      'Karang Anyar',
      'Wonosobo',
      'Sragen',
      'Magelang',
      'Tegal',
      'Pekalongan'
      ],
    "Jawa Timur"=>[
      'Jember',
      'Sumenep',
      'Malang',
      'Situbondo',
      'Pacitan',
      'Bangkalan',
      'Surabaya',
      'Ponorogo',
      'Lamongan',
      'Nganjuk',
      'Blitar',
      'Madiun',
      'Sidoarjo',
      'Gresik',
      'Tuban',
      'Jombang',
      'Tulungagung',
      'Banyuwangi',
      'Mojokerto',
      'Probolinggo',
      'Kediri',
      'Sampang',
      'Magetan',
      'Batu',
      'Pamekasan',
      'Trenggalek',
      'Bondowoso',
      'Malang',
      'Ngawi',
      'Pasuruan',
      'Lumajang',
      'Probolinggo',
      'Madiun',
      'Kediri',
      'Blitar',
      'Mojokerto',
      'Pasuruan'
    ],
    "Kalimantan Barat" =>[
      'Landak',
      'Ketapang',
      'Sintang',
      'Melawi',
      'Kapuas Hulu',
      'Sanggau',
      'Kubu Raya',
      'Sekadau',
      'Bengkayang',
      'Sambas',
      'Pontianak',
      'Pontianak',
      'Kayong Utara',
      'Singkawang'
    ],

    "Kalimantan Selatan"=>[
      'Barito Kuala',
      'Banjar',
      'Hulu Sungai Utara',
      'Hulu Sungai Selatan',
      'Barito Timur',
      'Balangan',
      'Tampin',
      'Banjarbaru',
      'Banjarmasin',
      'Tabalong',
      'Hulu Sungai Tengah',
      'Tanah Laut',
      'Tanah Bambu',
      'Barito Selatan',
      'Barito Utara',
      'Baru',
      'Murung Raya'
      ],
    "Kalimantan Tengah" =>[
      'Kotawaringin Timur',
      'Kotawaringin Barat',
      'Sukamara',
      'Pulang Pisau',
      'Kapuas',
      'Palangkaraya',
      'Lamandau',
      'Seruyan',
      'Gunung Mas',
      'Katingan'
      ],
    "Kalimantan Timur" =>[
      'Kutai Kartanegara',
      'Kutai Barat',
      'Malinau',
      'Nunukan',
      'Samarinda',
      'Bulungan',
      'Tana Tidung',
      'Tarakan',
      'Panajam Paser Utara',
      'Balikpapan',
      'Kutai Timur',
      'Paser',
      'Berau',
      'Bontang',
      'Kutai Kartanegara'
      ],
    "Kepulauan Riau" =>[
      'Bintan',
      'Batam',
      'Tanjung Pinang',
      'Natuna',
      'Karimun',
      'Lingga'
    ],
    "Lampung" =>[
      'Lampung Utara',
      'Tanggamus',
      'Lampung Tengah',
      'Way Kanan',
      'Lampung Selatan',
      'Lampung Barat',
      'Bandar Lampung',
      'Lampung Timur',
      'Tulang Bawang',
      'Pesawaran',
      'Metro'
      ],
    "Maluku" =>[
      'Buru',
      'Maluku Tengah',
      'Ambon',
      'Seram Bagian Timur',
      'Maluku Tenggara Barat',
      'Kepulauan Aru',
      'Seram Bagian Barat',
      'Maluku Tenggara'
      ],
    "Maluku Utara" =>[
      'Halmahera Selatan',
      'Halmahera Utara',
      'Halmahera Tengah',
      'Halmahera Barat',
      'Halmahera Timur',
      'Kepulauan Sula',
      'Ternate',
      'Tidore'
    ],

    "Aceh"=>[
      'Simeuleu',
      'Aceh Barat',
      'Aceh Tengah',
      'Aceh Barat Daya',
      'Aceh Tenggara',
      'Banda Aceh',
      'Aceh Besar',
      'Aceh Selatan',
      'Aceh Utara',
      'Aceh Timur',
      'Lhokseumawe',
      'Bener Meriah',
      'Pidie Jaya',
      'Pidie',
      'Aceh Tamiang',
      'Nagan Raya',
      'Bireuen',
      'Gayo Lues',
      'Aceh Singkil',
      'Aceh Jaya',
      'Langsa',
      'Subulussalam',
      'Sabang'
      ],
    "NTB" =>[
      'Lombok Timur',
      'Sumbawa',
      'Bima',
      'Mataram',
      'Bima',
      'Lombok Barat',
      'Lombok Tengah',
      'Sumbawa Barat',
      'Dompu'
      ],

    "NTT" =>[
      'Flores Timur',
      'Nagekeo',
      'Ngada',
      'Kupang',
      'Sikka',
      'Alor',
      'Kupang',
      'Timor Tengah Selatan',
      'Lembata',
      'Belu',
      'Rote Ndao',
      'Timor Tengah Utara',
      'Manggarai Timur',
      'Manggarai',
      'Ende',
      'Sumba Timur',
      'Sumba Tengah',
      'Sumba Barat Daya',
      'Manggarai Barat',
      'Sumba Barat'
      ],
    "Papua" =>[
      'Jayawijaya',
      'Jayapura',
      'Asmat',
      'Mimika',
      'Paniai',
      'Intan Jaya',
      'Manokwari',
      'Yahukimo',
      'Yapen Waropen',
      'Keerom',
      'Mappi',
      'Pegunungan Bintang',
      'Mamberamo Raya',
      'Puncak Jaya',
      'Biak Numfor',
      'Talikora',
      'Sarmi',
      'Waropen',
      'Deiyai',
      'Jayapura',
      'Nabire',
      'Boven Digoel',
      'Merauke',
      'Dogiyai',
      'Supiori'
      ],
    "Papua Barat" =>[
      'Sorong',
      'Sorong Selatan',
      'Teluk Bintuni',
      'Kaimana',
      'Fak-Fak',
      'Raja Ampat',
      'Teluk Wondama',
      'Sorong'
      ],
    "Riau" =>[
    'Rokan Hilir',
    'Kampar',
    'Rokan Hulu',
    'Bengkalis',
    'Indragiri Hulu',
    'Indragiri Hilir',
    'Kuantan Sengingi',
    'Dumai',
    'Pekanbaru',
    'Siak',
    'Palalawan',
    'Meranti'
      ],
    "Sulawesi Barat" =>[
      'Polewali Mandar',
      'Mamasa',
      'Mamuju Utara',
      'Majene',
      'Mamuju'
      ],
    "Sulawesi Selatan" =>[
      'Bone',
      'Enrekang',
      'Luwu Timur',
      'Jeneponto',
      'Tana Toraja Utara',
      'Pare-Pare',
      'Luwu Utara',
      'Goa',
      'Pangkajene Kepulauan',
      'Barru',
      'Bantaeng',
      'Maros',
      'Sindenreng Rappang',
      'Pinrang',
      'Wajo',
      'Selayar',
      'Makassar',
      'Tana Toraja',
      'Bulukumba',
      'Sinjai',
      'Soppeng',
      'Takalar',
      'Palopo'
      ],
    "Sulawesi Tengah" =>[
      'Tojo Una-Una',
      'Parigi Moutong',
      'Morowali',
      'Donggala',
      'Banggai',
      'Banggai Kepulauan',
      'Toli-Toli',
      'Buol',
      'Poso',
      'Palu'
      ],
    "Sulawesi Tenggara" =>[
      'Kendari',
      'Konawe',
      'Konawe Utara/ Selatan',
      'Muna',
      'Buton & Buton Utara',
      'Kolaka Utara',
      'Bau-Bau',
      'Kolaka',
      'Wakatobi',
      'Bombana'
      ],
    "Sulawesi Utara" =>[
      'Minahasa Utara',
      'Minahasa Selatan',
      'Minahasa Tenggara',
      'Kepulauan Talaud',
      'Kepulauan Sangihe',
      'Bolaang Mongondow',
      'Bolaang Mongondow Utara',
      'Bitung',
      'Manado',
      'Minahasa',
      'Tomohon'
      ],
    "Sumatera Barat" =>[
      'Padang Pariaman',
      'Lima Puluh Kota',
      'Agam',
      'Solok',
      'Bukit Tinggi',
      'Pasuruan',
      'Sawahlunto',
      'Pesisir Selatan',
      'Tanah Datar',
      'Pasaman',
      'Padang',
      'Pasaman Barat',
      'Sijunjung',
      'Dharmasraya',
      'Solok Selatan',
      'Solok',
      'Padang Panjang',
      'Kepulauan Mentawai',
      'Pariaman',
      'Payakumbuh'
      ],
    "Sumatera Selatan" =>[
      'Muara Enim',
      'Ogan Komering Ilir',
      'Palembang',
      'Musi Banyuasin',
      'Ogan Komering Ulu Selatan',
      'Banyuasin',
      'Ogan Komering Ulu',
      'Ogan Komering Ulu Timur',
      'Musi Rawas',
      'Prabumulih',
      'Pagar Alam',
      'Ogan Ilir',
      'Lahat',
      'Empat Lawang',
      'Lubuk Linggau'
      ],
    "Sumatera Utara" =>[
      'Tapanuli Utara',
      'Tapanuli Tengah',
      'Tapanuli Selatan',
      'Asahan',
      'Labuhan Batu',
      'Nias',
      'Batubara',
      'Toba Samosir',
      'Nias Selatan',
      'Langkat',
      'Humbang Hasudutan',
      'Simalungun',
      'Serdang Bedagai',
      'Deli Serdang',
      'Padang Lawas',
      'Karo',
      'Mandailing Natal',
      'Padang Lawas Utara',
      'Dairi',
      'Binjai',
      'Tanjung Balai',
      'Samosir',
      'Pakpak Barat',
      'Medan',
      'Tebing Tinggi',
      'Padang Sidempuan',
      'Pematangsiantar',
      'Sibolga',
      'Tebing Tinggi'
      ]
    }
  }
puts "start for each country areas and cities"
location.each do |country, areas|
  country = Country.find_or_create_by(name: country)

  areas.each do |area, cities|
    area = country.areas.find_or_create_by(name: area)

    cities.each do |city|
      area.cities.find_or_create_by(name: city)
    end
  end
end
puts "location done"
