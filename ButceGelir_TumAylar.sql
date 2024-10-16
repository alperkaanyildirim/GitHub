--Ameliyat protokollerini Bul:
select distinct ff."SubeId" as "SubeId",f."SubeId" as "ProtokolSubeId",f."ProtokolId",ff."FaturaId",'P_AMELIYATLAR' as "Tip",cast (now() AS timestamp) AS "ETLDate"
from "MEMOBI_DWH"."FCTProtokol" f
inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" ff on f."ProtokolIslemTutarId"::varchar =ff."ProtokolIslemTutarId"::varchar
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "ff"."SubeId"
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "f"."SubeId" AND
case WHEN "ff"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "f"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("f"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
where ff."FaturaRaporTarihiId"  >= 20240101
     and "a12"."Grup" = 'AMELİYATLAR';

--CheckUp protokollerini Bul:
select distinct ff."SubeId" as "SubeId",f."SubeId" as "ProtokolSubeId",f."ProtokolId",ff."FaturaId",'P_CHECKUP' as "Tip",cast (now() AS timestamp) AS "ETLDate"	
from "MEMOBI_DWH"."FCTProtokol" f
inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" ff on f."ProtokolIslemTutarId"::varchar =ff."ProtokolIslemTutarId"::varchar
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "ff"."SubeId"
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "f"."SubeId" AND
case WHEN "ff"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "f"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("f"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
where ff."FaturaRaporTarihiId"  >= 20240101
	  and "a12"."Grup" = 'CHECK UP'
	  and not exists (select * from "MEMOBI_DM"."ProtokolAmeliyatDetayTestTumAylar" a where a."ProtokolId"=f."ProtokolId" and a."SubeId"=ff."SubeId" and a."FaturaId"=ff."FaturaId");
	  
--Ameliyat ve Checkuplar Birleştiriliyor ("MEMOBI_DM"."ProtokolAmeliyatCheckupDetayTestTumAylar")
select * from "MEMOBI_DM"."ProtokolCheckupDetayTestTumAylar"
union
select * from "MEMOBI_DM"."ProtokolAmeliyatDetayTestTumAylar";	  
	
--Klinik Araştırmalar Bulunuyor
select distinct ff."SubeId" as "SubeId",f."SubeId" as "ProtokolSubeId",f."ProtokolId",ff."FaturaId",'P_KLINIK' as "Tip",cast (now() AS timestamp) AS "ETLDate"
from "MEMOBI_DWH"."FCTProtokol" f
inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" ff on f."ProtokolIslemTutarId"::varchar =ff."ProtokolIslemTutarId"::varchar
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "ff"."SubeId"
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "f"."SubeId" AND
case WHEN "ff"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "f"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
where ff."FaturaRaporTarihiId"  >= 20240101
	  and "ff"."AltKurumId"=10064
	  and not exists (select * from "MEMOBI_DM"."ProtokolAmeliyatCheckupDetayTestTumAylar" a where a."ProtokolId"=f."ProtokolId" and a."SubeId"=ff."SubeId"and a."FaturaId"=ff."FaturaId");

--Ameliyat,Checkup ve Klinik Araştırmalar Birleştiriliyor ("MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayTestTumAylar")	  
select * from "MEMOBI_DM"."ProtokolKlinikDetayTestTumAylar"
union
select * from "MEMOBI_DM"."ProtokolAmeliyatCheckupDetayTestTumAylar";	
--ProtokolAll
select distinct ff."SubeId" as "SubeId",f."SubeId" as "ProtokolSubeId",f."ProtokolId",ff."FaturaId",'P_HIZMET_GRUPLARI' as "Tip",cast (now() AS timestamp) AS "ETLDate"	
from "MEMOBI_DWH"."FCTProtokol" f
inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" ff on f."ProtokolIslemTutarId"::varchar =ff."ProtokolIslemTutarId"::varchar
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "ff"."SubeId"
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "f"."SubeId" AND
case WHEN "ff"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "f"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
	where ff."FaturaRaporTarihiId"  >= 20240101
	     and not exists (select * from "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayTestTumAylar" a where a."ProtokolId"=f."ProtokolId" and a."SubeId"=ff."SubeId"and a."FaturaId"=ff."FaturaId");

--ProtokolAllDetayCiro
with cte as
(SELECT "a10"."SubeId" as "SubeId",
	        "a30"."SubeUstAdi" AS "SubeUstAdi", 
		    "a2"."Yil" as "FaturaYil", 
			"a2"."Yilay" as "FaturaAyNo",
			"a12"."Grup" as "Grup",
			"a2"."Tarih" as "FaturaTarih",							
			"a10"."Tutar" AS "FaturaKdvsizTutar",
			CASE WHEN "a11"."BolumId" = 1365 THEN 'Misafir' ELSE 'Staf' END AS "DoktorTip",
			"a10"."Uyruk" as "HastaTip",
			"a25"."BolumUstAdi" as "PerformansBolum",
			case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
			case when "a26"."IkinciAltKurumId" in (10047,10056) then 'SGK'
		 		 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050) then 'ANLAŞMALI KURUM' 
			     when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
				 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
			else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
			case when "a27"."IkinciAltKurumId" in (10047,10056) then 'SGK'
		 		 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050) then 'ANLAŞMALI KURUM' 
				 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
				 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
			else "a27"."AltKurumAdi" end as "KurumOdemeTipi",
			"a11"."ProtokolIslemId",
			"a11"."ProtokolId",
			"a11"."UygulayanPersonelId",
			0 AS "Adet" 
	FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10"
	join "MEMOBI_DM"."ProtokolAllDetayTestTumAylar" "pa" ON "pa"."SubeId" = "a10"."SubeId" AND "pa"."FaturaId" = "a10"."FaturaId"
	JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"="a11"."ProtokolIslemTutarId" and "pa"."ProtokolSubeId"="a11"."SubeId" and "pa"."ProtokolId"="a11"."ProtokolId")
	left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
	JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ( "a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
	LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "a10"."SubeId")
	LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a30" ON ("a20"."SubeUstId" = "a30"."SubeUstId")
	inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
	inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
	left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
	left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
	WHERE "a11"."SubeId" NOT IN (3,36) 
	union 
	SELECT "a10"."SubeId" as "SubeId",
	        "a30"."SubeUstAdi" AS "SubeUstAdi", 
		    "a2"."Yil" as "FaturaYil", 
			"a2"."Yilay" as "FaturaAyNo",
			"a12"."Grup" as "Grup",
			"a2"."Tarih" as "FaturaTarih",							
			"a10"."Tutar" AS "FaturaKdvsizTutar",
			CASE WHEN "a11"."BolumId" = 1365 THEN 'Misafir' ELSE 'Staf' END AS "DoktorTip",
			"a10"."Uyruk" as "HastaTip",
			"a25"."BolumUstAdi" as "PerformansBolum",
			case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
			case when "a26"."IkinciAltKurumId" in (10047,10056) then 'SGK'
		 		 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050) then 'ANLAŞMALI KURUM' 
			     when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
				 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
			else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
			case when "a27"."IkinciAltKurumId" in (10047,10056) then 'SGK'
		 		 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050) then 'ANLAŞMALI KURUM' 
				 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
				 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
			else "a27"."AltKurumAdi" end as "KurumOdemeTipi",
			"a11"."ProtokolIslemId",
			"a11"."ProtokolId",
			"a11"."UygulayanPersonelId",
			0 AS "Adet" 
	FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay_SGKDahil" "a10"
	join "MEMOBI_DM"."ProtokolAllDetayTestTumAylar" "pa" ON "pa"."SubeId" = "a10"."SubeId" AND "pa"."FaturaId" = "a10"."FaturaId"
	JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"="a11"."ProtokolIslemTutarId" and "pa"."ProtokolSubeId"="a11"."SubeId" and "pa"."ProtokolId"="a11"."ProtokolId")
	left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
	JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ( "a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
	LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "a10"."SubeId")
	LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a30" ON ("a20"."SubeUstId" = "a30"."SubeUstId")
	inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
	inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
	left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
	left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
	WHERE "a11"."SubeId" NOT IN (3,36) and "a10"."CariId" = (14944)
)	 
SELECT cte."SubeUstAdi",cte."SubeId", "FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","DoktorTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","Grup","ProtokolIslemId","ProtokolId","UygulayanPersonelId",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","DoktorTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","Grup","ProtokolIslemId","ProtokolId","UygulayanPersonelId";


---ProtokolAmeliyatCheckupKlinikDetayCiro
	with cte as
	(SELECT "a10"."SubeId" as "SubeId",
	        "a30"."SubeUstAdi" AS "SubeUstAdi", 
		    "a2"."Yil" as "FaturaYil", 
			"a2"."Yilay" as "FaturaAyNo",
			"pack"."Tip" as "Grup",
			"a2"."Tarih" as "FaturaTarih",							
			"a10"."Tutar" AS "FaturaKdvsizTutar",
			CASE WHEN "a11"."BolumId" = 1365 THEN 'Misafir' ELSE 'Staf' END AS "DoktorTip", 
			"a10"."Uyruk" as "HastaTip",
			"a25"."BolumUstAdi" as "PerformansBolum",
			case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
			case when "a26"."IkinciAltKurumId" in (10047,10056) then 'SGK'
		 		 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050) then 'ANLAŞMALI KURUM' 
			     when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
				 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
			else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
			case when "a27"."IkinciAltKurumId" in (10047,10056) then 'SGK'
		 		 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050) then 'ANLAŞMALI KURUM' 
				 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
				 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
			else "a27"."AltKurumAdi" end as "KurumOdemeTipi",
			"a11"."ProtokolIslemId",
			"a12"."Grup" as "GrupProtokolIslem",
			"a11"."ProtokolId",
			"a11"."DoktorId",
			"a11"."IslemTarihiId",
			"a11"."ProtokolId"::text||"a11"."IslemTarihiId"::text as "Protokolgunlukuniq",
			0 AS "Adet" 
	FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10"
	inner join "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayTestTumAylar" "pack" on "pack"."FaturaId"="a10"."FaturaId" and "pack"."SubeId"="a10"."SubeId"
	JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"="a11"."ProtokolIslemTutarId" and "pack"."ProtokolSubeId"="a11"."SubeId" and "pack"."ProtokolId"="a11"."ProtokolId")
	left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
	JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ( "a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
	LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a10"."SubeId" = "a20"."SubeId")
	LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a30" ON ("a20"."SubeUstId" = "a30"."SubeUstId")
	inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."BolumId" 
	inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
	left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
	left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
	WHERE "a11"."SubeId" NOT IN (3,36)		
	union 
	SELECT "a10"."SubeId" as "SubeId",
	        "a30"."SubeUstAdi" AS "SubeUstAdi", 
		    "a2"."Yil" as "FaturaYil", 
			"a2"."Yilay" as "FaturaAyNo",
			"pack"."Tip" as "Grup",
			"a2"."Tarih" as "FaturaTarih",							
			"a10"."Tutar" AS "FaturaKdvsizTutar",
			CASE WHEN "a11"."BolumId" = 1365 THEN 'Misafir' ELSE 'Staf' END AS "DoktorTip", 
			"a10"."Uyruk" as "HastaTip",
			"a25"."BolumUstAdi" as "PerformansBolum",
			case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
			case when "a26"."IkinciAltKurumId" in (10047,10056) then 'SGK'
		 		 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050) then 'ANLAŞMALI KURUM' 
			     when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
				 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
			else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
			case when "a27"."IkinciAltKurumId" in (10047,10056) then 'SGK'
		 		 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050) then 'ANLAŞMALI KURUM' 
				 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
				 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
			else "a27"."AltKurumAdi" end as "KurumOdemeTipi",
			"a11"."ProtokolIslemId",
			"a12"."Grup" as "GrupProtokolIslem",
			"a11"."ProtokolId",
			"a11"."DoktorId",
			"a11"."IslemTarihiId",
			"a11"."ProtokolId"::text||"a11"."IslemTarihiId"::text as "Protokolgunlukuniq",
			0 AS "Adet" 
	FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay_SGKDahil" "a10"
	inner join "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayTestTumAylar" "pack" on "pack"."FaturaId"="a10"."FaturaId" and "pack"."SubeId"="a10"."SubeId"
	JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"="a11"."ProtokolIslemTutarId" and "pack"."ProtokolSubeId"="a11"."SubeId" and "pack"."ProtokolId"="a11"."ProtokolId")
	left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
	JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ( "a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
	LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a10"."SubeId" = "a20"."SubeId")
	LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a30" ON ("a20"."SubeUstId" = "a30"."SubeUstId")
	inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."BolumId" 
	inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
	left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
	left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
	WHERE "a11"."SubeId" NOT IN (3,36)  and "a10"."CariId" = (14944)		
	)	 
	SELECT cte."SubeUstAdi",cte."SubeId","FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","DoktorTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","Grup","ProtokolIslemId","ProtokolId","DoktorId","GrupProtokolIslem","IslemTarihiId","Protokolgunlukuniq",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
	FROM cte GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","DoktorTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","Grup","ProtokolIslemId","ProtokolId","DoktorId","GrupProtokolIslem","IslemTarihiId","Protokolgunlukuniq";


--Islem sayısı Checkup-Klinik araştırma
	with cte as
	(
	select
	"SubeId",
	"SubeUstAdi",
	"FaturaYil", 
	"FaturaAyNo",
	"FaturaTarih",
	"Grup",
	0 AS "FaturaKdvsizTutar",
	"DoktorTip",
	"PerformansBolum",
	"GelisTipi",
	"HastaTip",
	"BaskinKurumTipi",
	"ProtokolIslemId",
	"ProtokolId"
	FROM "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayCiroTumAylar" where "Grup"<>'P_AMELIYATLAR'
	GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup","ProtokolIslemId","ProtokolId"
	)	
	SELECT cte."SubeUstAdi", cte."SubeId","FaturaYil","FaturaAyNo","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", count(distinct "ProtokolId") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
	FROM cte
	GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup";	
--Islem Sayısı Ameliyat
with cte as
	(
	select 
	"a10"."SubeId",
	"a10"."SubeUstAdi",
	"a10"."FaturaYil", 
	"a10"."FaturaAyNo",
	"a10"."FaturaTarih",
	"a10"."Grup",
	0 AS "FaturaKdvsizTutar",
	"a10"."DoktorTip",
	"a10"."PerformansBolum",
	"a10"."GelisTipi",
	"a10"."HastaTip",
	"a10"."BaskinKurumTipi",	
	"a10"."ProtokolId",
	"a10"."DoktorId",
	"a10"."Protokolgunlukuniq"
	FROM "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayCiroTumAylar" "a10" 
	where  "a10"."Grup"='P_AMELIYATLAR' and  "a10"."GrupProtokolIslem" = 'AMELİYATLAR' 	
	)	
	SELECT cte."SubeUstAdi", cte."SubeId","FaturaYil","FaturaAyNo","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar",count(Distinct"Protokolgunlukuniq")  AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
	FROM cte
	GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup";	
--Islem Sayısı Hizmetler
with cte as
	(
	SELECT
	"SubeId",
	"SubeUstAdi",
	"FaturaYil", 
	"FaturaAyNo",
	"FaturaTarih",
	"Grup",
	0 AS "FaturaKdvsizTutar",
	"DoktorTip",
	"PerformansBolum",
	"GelisTipi",
	"HastaTip",
	"BaskinKurumTipi",
	"ProtokolIslemId",
	"ProtokolId",
	SUM(case when "Grup"='MUAYENE' then CASE WHEN "FaturaKdvsizTutar" > 0 THEN 1 ELSE 0 END else CASE WHEN "FaturaKdvsizTutar" >= 0 THEN 1 ELSE 0 end END ) as "Adet"
	FROM "MEMOBI_DM"."ProtokolAllDetayCiroTumAylar"
	GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup","ProtokolIslemId","ProtokolId"		
	)	
	SELECT cte."SubeUstAdi", cte."SubeId","FaturaYil", "FaturaAyNo","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
	FROM cte GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup";
---Doktor Adet
with cte as
(	select  ff."SubeId" as "SubeId","a30"."SubeUstAdi" AS "SubeUstAdi",d."PersonelBirlesimId","a2"."Yil" as "FaturaYil","a2"."Yilay" as "FaturaAyNo","a25"."BolumUstAdi" as "UygulayanBolum",d."CalismaTipiId"
	from "MEMOBI_DWH"."FCTProtokol" f
	inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" ff on f."ProtokolIslemTutarId"::varchar =ff."ProtokolIslemTutarId"::varchar
	JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "ff"."SubeId"
	JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "f"."SubeId" AND
	case WHEN "ff"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "f"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null end
	JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ( "ff"."FaturaRaporTarihiId" = "a2"."TarihId") 
	LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("ff"."SubeId" = "a20"."SubeId")
	LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a30" ON ("a20"."SubeUstId" = "a30"."SubeUstId")
	inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = f."UygulayanBolumId" 
	inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
	inner join "MEMOBI_DWH"."VW_DIMDoktor" d on d."PersonelId"=f."UygulayanPersonelId" 
	inner join "MEMOBI_DWH"."VW_DIMPersonelBirlesim" "a115"  on ("d"."PersonelBirlesimId" = "a115"."PersonelId")
	where ff."FaturaRaporTarihiId"  >= 20240101 
	)	
SELECT cte."SubeUstAdi", cte."SubeId","FaturaYil", "FaturaAyNo","UygulayanBolum","CalismaTipiId", Count(distinct "PersonelBirlesimId") AS "DoktorSayisi" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte 
GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","UygulayanBolum","CalismaTipiId" ;

--Gelir Data	
select
"SubeId",
"SubeUstAdi", 
"FaturaYil", 
"FaturaAyNo",
"HastaTip",
"DoktorTip",
"BaskinKurumTipi", 
"KurumOdemeTipi", 
"PerformansBolum", 
"GelisTipi", 
"Grup", 
sum("FaturaKdvsizTutar") as "FaturaKdvsizTutar", 
sum(0) as "Adet",
sum(0)  as "DoktorSayisi",
cast (now() AS timestamp) AS "ETLDate"
from "MEMOBI_DM"."ProtokolAllDetayCiroTumAylar"
group by
"SubeId",
"SubeUstAdi", 
"FaturaYil", 
"FaturaAyNo",
"HastaTip",
"DoktorTip",
"BaskinKurumTipi", 
"KurumOdemeTipi", 
"PerformansBolum", 
"GelisTipi", 
"Grup"
union all
select
"SubeId",
"SubeUstAdi", 
"FaturaYil", 
"FaturaAyNo",
"HastaTip",
"DoktorTip", 
"BaskinKurumTipi", 
"KurumOdemeTipi", 
"PerformansBolum", 
"GelisTipi", 
"Grup", 
sum("FaturaKdvsizTutar") as "FaturaKdvsizTutar", 
sum(0) as "Adet",
sum(0)  as "DoktorSayisi",
cast (now() AS timestamp) AS "ETLDate"
from "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayCiroTumAylar"
group by
"SubeId",
"SubeUstAdi", 
"FaturaYil", 
"FaturaAyNo",
"HastaTip",
"DoktorTip",
"BaskinKurumTipi", 
"KurumOdemeTipi", 
"PerformansBolum", 
"GelisTipi", 
"Grup"
union all
select
"SubeId",
"SubeUstAdi", 
"FaturaYil", 
"FaturaAyNo", 
"HastaTip",
"DoktorTip",
"BaskinKurumTipi", 
'IslemSayisi' as "KurumOdemeTipi", 
"PerformansBolum", 
"GelisTipi", 
"Grup", 
sum(0) as "FaturaKdvsizTutar", 
sum("Adet") as "Adet",
sum(0)  as "DoktorSayisi",
cast (now() AS timestamp) AS "ETLDate"
from "MEMOBI_DM"."ProtokolAmeliyatAdetRaporTumAylar"
group by
"SubeId",
"SubeUstAdi", 
"FaturaYil", 
"FaturaAyNo",
"HastaTip",
"DoktorTip",
"BaskinKurumTipi", 
"KurumOdemeTipi", 
"PerformansBolum", 
"GelisTipi", 
"Grup"
union all
select
"SubeId",
"SubeUstAdi", 
"FaturaYil", 
"FaturaAyNo", 
"HastaTip",
"DoktorTip",
"BaskinKurumTipi", 
'IslemSayisi' as "KurumOdemeTipi",
"PerformansBolum", 
"GelisTipi", 
"Grup", 
sum(0) as "FaturaKdvsizTutar", 
sum("Adet") as "Adet",
sum(0)  as "DoktorSayisi",
cast (now() AS timestamp) AS "ETLDate"
from "MEMOBI_DM"."ProtokolCheckupKlinikAdetRaporTumAylar"
group by
"SubeId",
"SubeUstAdi", 
"FaturaYil", 
"FaturaAyNo",
"HastaTip",
"DoktorTip",
"BaskinKurumTipi", 
"KurumOdemeTipi", 
"PerformansBolum", 
"GelisTipi", 
"Grup"
union all
select
"SubeId",
"SubeUstAdi", 
"FaturaYil", 
"FaturaAyNo", 
"HastaTip",
"DoktorTip",
"BaskinKurumTipi", 
'IslemSayisi' as "KurumOdemeTipi",
"PerformansBolum", 
"GelisTipi", 
"Grup", 
sum(0) as "FaturaKdvsizTutar", 
sum("Adet") as "Adet",
sum(0)  as "DoktorSayisi",
cast (now() AS timestamp) AS "ETLDate"
from "MEMOBI_DM"."ProtokolAllAdetRaporTumAylar"
group by
"SubeId",
"SubeUstAdi", 
"FaturaYil", 
"FaturaAyNo",
"HastaTip",
"DoktorTip",
"BaskinKurumTipi", 
"KurumOdemeTipi", 
"PerformansBolum", 
"GelisTipi", 
"Grup";

