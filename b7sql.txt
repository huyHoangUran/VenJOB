a: SELECT * from SinhVien where hotensv like '%Le';



b: SELECT g.hotengv, k.tenkhoa from GiangVien g inner join Khoa k on g.makhoa = k.makhoa where k.makhoa = 'Geo';


c:  select distinct HuongDan.magv, hotengv, tenkhoa 
 from (HuongDan inner join GiangVien on HuongDan.magv = GiangVien.magv) inner join Khoa on Khoa.makhoa = GiangVien.makhoa
 where HuongDan.magv
 in (SELECT HuongDan.magv
 from
    HuongDan
group by
    HuongDan.magv
having 
    COUNT(HuongDan.magv) > 1);


d: select distinct  DeTai.madt, tendt from HuongDan inner join DeTai on HuongDan.madt = DeTai.madt where HuongDan.madt in( select HuongDan.madt from HuongDan  group by HuongDan.madt having count(HuongDan.madt)>1) 
except
select HuongDan.madt, DeTai.tendt from HuongDan inner join DeTai on HuongDan.madt = DeTai.madt group by HuongDan.madt having count(HuongDan.madt) = ( select MAX(mycount) from (select HuongDan.madt, COUNT(HuongDan.madt)  mycount from HuongDan GROUP BY HuongDan.madt) sub);