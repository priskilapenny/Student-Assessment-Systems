# API Endpoint Documentation

## 1. Retrieve Assessment Result

**Endpoint:** `GET /nilai/mataPelajaran`

**Purpose:** Retrieve assessment result by subjects

**Body Parameters:**
````json
{
    "angkatan_id": 7,
    "mapel_id": [20],
    "type_ujian_id": 5
}
````

**Response:**
````json
[
    {
        "mapel_id": 20,
        "mata_pelajaran": "Sejarah",
        "tingkat_id": 3,
        "tingkat": "Tingkat 3",
        "semester_id": 2,
        "semester": "Semester 2",
        "angkatan": "2023",
        "kelas_id": 1,
        "kelas": "Kelas A",
        "th_ajaran": "2025-2026",
        "siswa": [
            {
                "siswa_id": 22,
                "nama_siswa": "Danu Aji E",
                "nis": "23002",
                "nilai": {
                    "uts": "63.20",
                    "uas": "66.20",
                    "ujian": "64.70",
                    "penugasan": "58.00",
                    "nilai_akhir": "60.84"
                }
            },
            {
                "siswa_id": 21,
                "nama_siswa": "Shawna Farrelli",
                "nis": "23001",
                "nilai": {
                    "uts": "55.80",
                    "uas": "71.40",
                    "ujian": "63.60",
                    "penugasan": "62.00",
                    "nilai_akhir": "61.32"
                }
            }
        ]
    }
]
````

## 2. Insert Multiple Data

**Endpoint:** `POST /siswa/upload`

**Purpose:** Insert multiple students data

**Body Parameters:**
````json
{    
    "file_upload": {{file-upload}},
    "angkatan": "2026",
    "tingkat": "Tingkat 1",
    "siswa": [
        {
            "nama_siswa": "Steven Adams",
            "nis": "178",
            "kelas": "Kelas AA"
        },
        {
            "nama_siswa": "Kelvin Warren",
            "nis": "196",
            "kelas": "Kelas A-2"
        },
        {
            "nama_siswa": "Edward Allen",
            "nis": "159",
            "kelas": "Kelas A-2"
        }
    ]
}
````

**Response:**
````json
{
  "message": "Data siswa telah berhasil diunggah."
}
````

## 3. Update Data

**Endpoint:** `POST /siswa/update`

**Purpose:** Update student data

**Path Parameters:**

| Parameter | Type | Description |
|---|---|---|
| `siswa_id` | Integer | Unique siswa identifier |
| `nama_siswa` | String | Name of data siswa |
| `nis` | String | Siswa number identifier |
| `angkatan_id` | Integer | Unique angkatan identifier |
| `tingkat_id` | Integer | Unique tingkat identifier |
| `kelas_id` | Integer | Unique kelas identifier |

**Response:**
````json
{
  "message": "Data siswa telah berhasil diubah."
}
````
