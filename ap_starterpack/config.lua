Config = {}

Config.ap_starterpack = {
    lang = 'EN', -- EN or ID
    ped = 'a_m_y_business_03', -- https://docs.fivem.net/docs/game-references/ped-models/
    durasi = 10000, -- Durasi Loading
    lokasi = vector4(-1031.5133, -2736.9155, 20.1693, 59.5154), -- Lokasi PED
    jarak = 50, -- Jarak Spawn PED
    items = {
        {
            dapetnya = 'water',
            jumlahnya = 10,
        },
        {
            dapetnya = 'bread',
            jumlahnya = 10,
        },
        {
            dapetnya = 'phone',
            jumlahnya = 1,
        },
    }
}

Config.ap_starterpackStrings = {
    ['ID'] = { -- Bahasa Indonesia
        labelloading = 'Mengambil Starter Pack',
        titlenotif = 'NAMA SERVER',
        dibatalkan = 'Kamu membatalkan proses pengambilan',
        labeltarget = 'Ambil Starter Pack',
        sudahambil = 'Kamu sudah menerima starter pack!',
        berhasilambil = 'Kamu berhasil mengambil starter pack. Hafe fun!',
    },
    ['EN'] = { -- English
        labelloading = 'Taking a starter pack',
        titlenotif = 'SERVER NAME',
        dibatalkan = 'You cancel the process',
        labeltarget = 'Claim Starter Pack',
        sudahambil = 'You have received starter pack!',
        berhasilambil = 'You have successfully retrieved starter pack. Hafe fun!',
    },
}