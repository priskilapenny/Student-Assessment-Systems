-- all siswa
SELECT b.*, a.angkatan_id, a.angkatan, c.tingkat_id, c.tingkat, d.nama_kelas
FROM siswa b 
JOIN angkatan a ON a.angkatan_id=b.angkatan_id
LEFT JOIN tingkat c ON b.tingkat_id=c.tingkat_id
LEFT JOIN kelas d ON b.kelas_id=d.kelas_id
WHERE b.is_active=1 
ORDER BY b.tingkat_id, a.nama_angkatan, d.nama_kelas, b.nis;

-- detail nilai siswa
SELECT a.na_id, a.tingkat_id, b.tingkat, a.semester_id, c.semester, a.th_ajaran_id, e.tahun_ajaran, a.kelas_id, d.nama_kelas, a.nilai
FROM nilai_akhir AS a
LEFT JOIN tingkat AS b ON a.tingkat_id = b.tingkat_id
LEFT JOIN semester AS c ON a.semester_id = c.semester_id
LEFT JOIN kelas AS d ON a.kelas_id = d.kelas_id
LEFT JOIN tahun_ajaran AS e ON a.th_ajaran_id = e.th_ajaran_id
WHERE a.siswa_id = @siswaid;

-- nilai per matkul
SELECT a.mapel_id, a.mata_pelajaran, c.tingkat_id, d.tingkat, b.semester_id, b.semester , e.siswa_id, h.kelas_id, f.kelas_id
FROM mata_pelajaran a
JOIN siswa e
JOIN semester b ON a.semester_id=b.semester_id
JOIN tingkat_semester c ON b.semester_id=c.semester_id
JOIN nilai_akhir h ON e.siswa_id=h.siswa_id AND a.semester_id=h.semester_id
LEFT JOIN tingkat d ON c.tingkat_id=d.tingkat_id
LEFT JOIN kelas f ON h.kelas_id=f.kelas_id
JOIN angkatan g ON e.angkatan_id=g.angkatan_id
WHERE e.angkatan_id=@angkatanid AND a.mapel_id IN (@mapelid) AND e.is_active=1
ORDER BY a.mapel_id, f.nama_kelas, e.nis;

-- nilai akhir calculation
SELECT a.siswa_id, a.semester_id, b.tingkat_id, b.kelas_id, AVG(nilai) na
FROM nilai_kumulatif_mapel a
JOIN siswa b ON a.siswa_id=b.siswa_id
WHERE a.angkatan_id=@angkatanid AND a.semester_id=@semesterid
GROUP BY a.siswa_id;

-- list kode ujian
SELECT a.kode_ujian_id, a.type_ujian_id, b.type_ujian, b.notes AS notes_type, a.tgl_awal, a.tgl_akhir, a.is_active, a.created_at, 
c.ujian_mapel_id, c.mapel_id, d.mata_pelajaran, e.kode_ujian_id , IF(a.tgl_akhir >= CURDATE() AND e.kode_ujian_id IS NOT NULL, 1, 0) AS available
FROM kode_ujian a
JOIN kode_ujian_mapel c ON a.kode_ujian_id=c.kode_ujian_id
JOIN mata_pelajaran d ON c.mapel_id=d.mapel_id
JOIN type_ujian b ON a.type_ujian_id=b.type_ujian_id
LEFT JOIN (
	SELECT MAX(kode_ujian_id) kode_ujian_id, mapel_id
	FROM kode_ujian_mapel a
	GROUP BY mapel_id
) e ON a.kode_ujian_id=e.kode_ujian_id AND c.mapel_id=e.mapel_id
ORDER BY a.created_at DESC;

