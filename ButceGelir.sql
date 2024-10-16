SET enable_nestloop TO off;

--Ameliyat protokollerini Bul:
 
drop table IF exists "MEMOBI_DM"."ProtokolAmeliyatDetayTest";
select distinct ff."SubeId" as "SubeId",f."SubeId" as "ProtokolSubeId",f."ProtokolId",ff."FaturaId",'P_AMELIYATLAR' as "Tip"
into "MEMOBI_DM"."ProtokolAmeliyatDetayTest"
from "MEMOBI_DWH"."FCTProtokol" f
inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetaySGKUnion" ff on f."ProtokolIslemTutarId"::varchar =ff."ProtokolIslemTutarId"::varchar --and ff."SubeId"="a20"."SubeUstId"
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "ff"."SubeId"
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "f"."SubeId" AND
case WHEN "ff"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "f"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("f"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
where ff."FaturaRaporTarihiId"  >= 20240101
     and "a12"."Grup" = 'AMELİYATLAR';
     --and "ff"."SubeId" = 158;
     --and ff."FaturaId" in (1351750,1374208);
 
----------------------------------------------------------------------------------------------------------------------------------------------    
	 
	--CheckUp protokollerini Bul:
	
	drop table IF exists "MEMOBI_DM"."ProtokolCheckupDetayTest";
	select distinct ff."SubeId" as "SubeId",f."SubeId" as "ProtokolSubeId",f."ProtokolId",ff."FaturaId",'P_CHECKUP' as "Tip"
	into "MEMOBI_DM"."ProtokolCheckupDetayTest"
	from "MEMOBI_DWH"."FCTProtokol" f
inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetaySGKUnion" ff on f."ProtokolIslemTutarId"::varchar =ff."ProtokolIslemTutarId"::varchar --and ff."SubeId"="a20"."SubeUstId"
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "ff"."SubeId"
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "f"."SubeId" AND
case WHEN "ff"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "f"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("f"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
	where ff."FaturaRaporTarihiId"  >= 20240101
	     and "a12"."Grup" = 'CHECK UP'
	     and not exists (select * from "MEMOBI_DM"."ProtokolAmeliyatDetayTest" a where a."ProtokolId"=f."ProtokolId" and a."SubeId"=ff."SubeId" and a."FaturaId"=ff."FaturaId");
	     -- and "ff"."SubeId" = 158;
	    
	----------------------------------------------------------------------------------------------------------------------------------------------    
	
	drop table IF exists "MEMOBI_DM"."ProtokolAmeliyatCheckupDetayTest";	 
	create table "MEMOBI_DM"."ProtokolAmeliyatCheckupDetayTest"
	as
	select * from "MEMOBI_DM"."ProtokolCheckupDetayTest"
	union
	select * from "MEMOBI_DM"."ProtokolAmeliyatDetayTest";
	
	----------------------------------------------------------------------------------------------------------------------------------------------    
	
	--Klinik araştırma fatura protokollerini Bul:
	
	drop table IF exists "MEMOBI_DM"."ProtokolKlinikDetayTest";	
	select distinct ff."SubeId" as "SubeId",f."SubeId" as "ProtokolSubeId",f."ProtokolId",ff."FaturaId",'P_KLINIK' as "Tip"
	into "MEMOBI_DM"."ProtokolKlinikDetayTest"
	from "MEMOBI_DWH"."FCTProtokol" f
inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetaySGKUnion" ff on f."ProtokolIslemTutarId"::varchar =ff."ProtokolIslemTutarId"::varchar --and ff."SubeId"="a20"."SubeUstId"
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "ff"."SubeId"
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "f"."SubeId" AND
case WHEN "ff"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "f"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
--left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("f"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
	where ff."FaturaRaporTarihiId"  >= 20240101
	     and "ff"."AltKurumId"=10064
	     and not exists (select * from "MEMOBI_DM"."ProtokolAmeliyatCheckupDetayTest" a where a."ProtokolId"=f."ProtokolId" and a."SubeId"=ff."SubeId"and a."FaturaId"=ff."FaturaId");
	 	 --and "ff"."SubeId" = 158;
	    
	----------------------------------------------------------------------------------------------------------------------------------------------
	
	drop table IF exists "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayTest";	 
	create table "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayTest"
	as	
	select * from "MEMOBI_DM"."ProtokolKlinikDetayTest"
	union
	select * from "MEMOBI_DM"."ProtokolAmeliyatCheckupDetayTest";
	
	----------------------------------------------------------------------------------------------------------------------------------------------
	
	drop table IF exists "MEMOBI_DM"."ProtokolAllDetayTest";	
	select distinct ff."SubeId" as "SubeId",f."SubeId" as "ProtokolSubeId",f."ProtokolId",ff."FaturaId",'P_HIZMET_GRUPLARI' as "Tip"
	into "MEMOBI_DM"."ProtokolAllDetayTest"
	from "MEMOBI_DWH"."FCTProtokol" f
inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetaySGKUnion" ff on f."ProtokolIslemTutarId"::varchar =ff."ProtokolIslemTutarId"::varchar --and ff."SubeId"="a20"."SubeUstId"
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "ff"."SubeId"
JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "f"."SubeId" AND
case WHEN "ff"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "f"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
--left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("f"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
	where ff."FaturaRaporTarihiId"  >= 20240101
	     --ff."CariId" <> 14944
	     and not exists (select * from "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayTest" a where a."ProtokolId"=f."ProtokolId" and a."SubeId"=ff."SubeId"and a."FaturaId"=ff."FaturaId");
	 	 --and "ff"."SubeId" = 158;
	 	 --and "f"."ProtokolId" =23908618;
	     --and ff."FaturaId" in (1351750,1374208);
	-- 	select * from "MEMOBI_DM"."ProtokolAllDetayTestBah" where "ProtokolId" in(23769486,23689641,23879906)
	-- 	select * from "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayTestBah" where "ProtokolId" in(23769486,23689641,23879906)
	----------------------------------------------------------------------------------------------------------------------------------------------
	
	drop table IF exists "MEMOBI_DM"."ProtokolAllDetayCiro";	 
	create table "MEMOBI_DM"."ProtokolAllDetayCiro"
	as
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
	FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetaySGKUnion" "a10"
	join "MEMOBI_DM"."ProtokolAllDetayTest" "pa" ON "pa"."SubeId" = "a10"."SubeId" AND "pa"."FaturaId" = "a10"."FaturaId"
	JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"="a11"."ProtokolIslemTutarId" and "pa"."ProtokolSubeId"="a11"."SubeId" and "pa"."ProtokolId"="a11"."ProtokolId")
	left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
	JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ( "a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
	LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "a10"."SubeId")
	LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a30" ON ("a20"."SubeUstId" = "a30"."SubeUstId")
	inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
	inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
	left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
	left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
	WHERE -- "a10"."FaturaRaporTarihiId" >=20240101 
		    --AND 
		    "a11"."SubeId" NOT IN (3,36) 
		   -- and "pa"."ProtokolId" =50748129
			--AND EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAllDetayTestBah" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."FaturaId" = "a10"."FaturaId")
			--AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
			--AND "a12"."Grup" = 'AMELİYAT DİĞER'
	)	 
	SELECT cte."SubeUstAdi",cte."SubeId", "FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","DoktorTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","Grup","ProtokolIslemId","ProtokolId","UygulayanPersonelId",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
	FROM cte GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","DoktorTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","Grup","ProtokolIslemId","ProtokolId","UygulayanPersonelId";
	
	----------------------------------------------------------------------------------------------------------------------------------------------
	 
	drop table IF exists "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayCiro";	 
	create table "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayCiro"
	as
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
	FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetaySGKUnion" "a10"
	inner join "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayTest" "pack" on "pack"."FaturaId"="a10"."FaturaId" and "pack"."SubeId"="a10"."SubeId"
	JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"="a11"."ProtokolIslemTutarId" and "pack"."ProtokolSubeId"="a11"."SubeId" and "pack"."ProtokolId"="a11"."ProtokolId")
	left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
	JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ( "a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
	LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a10"."SubeId" = "a20"."SubeId")
	LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a30" ON ("a20"."SubeUstId" = "a30"."SubeUstId")
	inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."BolumId" 
	inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
	left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
	left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
	WHERE -- "a10"."FaturaRaporTarihiId" >=20240101 
		    --AND 
		    "a11"."SubeId" NOT IN (3,36)
		    --and "a12"."Grup" in ('AMELİYATLAR','CHECK UP')
			--AND EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatTest" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."Id" = "a10"."FaturaId") 
			--AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
			--AND "a12"."Grup" = 'AMELİYAT DİĞER'
	)	 
	SELECT cte."SubeUstAdi",cte."SubeId","FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","DoktorTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","Grup","ProtokolIslemId","ProtokolId","DoktorId","GrupProtokolIslem","IslemTarihiId","Protokolgunlukuniq",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
	FROM cte GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","DoktorTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","Grup","ProtokolIslemId","ProtokolId","DoktorId","GrupProtokolIslem","IslemTarihiId","Protokolgunlukuniq";
	
	----------------------------------------------------------------------------------------------------------------------------------------------
	--Islem sayısı Checkup-Klinik araştırma
	drop table IF exists "MEMOBI_DM"."ProtokolCheckupKlinikAdetRapor";	
	create table "MEMOBI_DM"."ProtokolCheckupKlinikAdetRapor"
	as
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
	FROM "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayCiro" where "Grup"<>'P_AMELIYATLAR'
	GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup","ProtokolIslemId","ProtokolId"
	)	
	SELECT cte."SubeUstAdi", cte."SubeId","FaturaYil","FaturaAyNo","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", count(distinct "ProtokolId") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
	FROM cte
	GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup";
	
	----------------------------------------------------------------------------------------------------------------------------------------------
--Islem Sayısı Ameliyat
	drop table IF exists "MEMOBI_DM"."ProtokolAmeliyatAdetRapor";	
	create table "MEMOBI_DM"."ProtokolAmeliyatAdetRapor"
	as
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
	--CASE WHEN ROW_NUMBER() OVER (partition by "a10"."Grup","a10"."ProtokolIslemId","a10"."FaturaTarih","a10"."SubeId" ORDER BY "a10"."Grup","a10"."ProtokolIslemId","a10"."FaturaTarih","a10"."SubeId" asc)=1 THEN 1 ELSE 0 END AS "Adet" 
	FROM "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayCiro" "a10" 
	where  "a10"."Grup"='P_AMELIYATLAR' and  "a10"."GrupProtokolIslem" = 'AMELİYATLAR' 
	--GROUP BY "a10"."SubeUstAdi","a10"."SubeId","a10"."FaturaYil","a10"."FaturaAyNo","a10"."FaturaTarih","a10"."HastaTip","a10"."DoktorTip","a10"."BaskinKurumTipi","a10"."KurumOdemeTipi","a10"."PerformansBolum","a10"."GelisTipi","a10"."Grup","a10"."ProtokolIslemId","a10"."ProtokolId","a10"."DoktorId"
	)	
	SELECT cte."SubeUstAdi", cte."SubeId","FaturaYil","FaturaAyNo","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar",count(Distinct"Protokolgunlukuniq")  AS "Adet" ,cast (now() AS timestamp) AS "ETLDate" --Count( "ProtokolId"::text||"FaturaTarih"::text) 
	FROM cte
	GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup";
/*
55154-6402

select * from "MEMOBI_DM"."ProtokolAmeliyatAdetRapor" 75519-9870

ProtokolAmeliyatCheckupKlinikDetayCiro
select *
	FROM "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayCiro" "a10" 
	where  "a10"."Grup"='P_AMELIYATLAR' and  "a10"."GrupProtokolIslem" = 'AMELİYATLAR'--1,461,702,588.851*/



-------------------------------------------------------------------------------------------------------------------------------------------------------------
	--Islem Sayısı Hizmetler
	drop table IF exists "MEMOBI_DM"."ProtokolAllAdetRapor";	
	create table "MEMOBI_DM"."ProtokolAllAdetRapor"
	as
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
	FROM "MEMOBI_DM"."ProtokolAllDetayCiro"
	GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup","ProtokolIslemId","ProtokolId"		
	)	
	SELECT cte."SubeUstAdi", cte."SubeId","FaturaYil", "FaturaAyNo","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
	FROM cte GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","HastaTip","DoktorTip","BaskinKurumTipi","PerformansBolum","GelisTipi","Grup";
	
	----------------------------------------------------------------------------------------------------------------------------------------------
--select "FaturaAyNo",sum("FaturaKdvsizTutar") from "MEMOBI_DM"."DM_McKinseyGelirDataBah"	group by "FaturaAyNo"
/*
	drop table IF exists "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDoktorRapor";	
	create table "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDoktorRapor"
	as	
	select
	"SubeId",
	"SubeUstAdi",
	"FaturaYil", 
	"FaturaAyNo",
	"PerformansBolum",
	Count(distinct "DoktorId" ) AS "DoktorSayisi" 
	FROM "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayCiro"
	where "FaturaKdvsizTutar" >=0
	GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","PerformansBolum";--,"HastaTip","DoktorTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","Grup";--,"ProtokolIslemId","ProtokolId"
	
	
	drop table IF exists "MEMOBI_DM"."ProtokolAllDoktorRapor";
	create table "MEMOBI_DM"."ProtokolAllDoktorRapor"
	as	
	with cte as
	(
	select
	"SubeId",
	"SubeUstAdi",
	"FaturaYil", 
	"FaturaAyNo",	
	"PerformansBolum",	
	case when "Grup"='MUAYENE' then CASE WHEN sum("FaturaKdvsizTutar") > 0 THEN   "UygulayanPersonelId"  ELSE -1111 END else  "UygulayanPersonelId" END  as "UygulayanPersonelId"
	--case when "Grup"='MUAYENE' then CASE WHEN "FaturaKdvsizTutar" > 0 THEN Count(distinct "UygulayanPersonelId" ) ELSE 0 end  AS "Adet" 
	FROM "MEMOBI_DM"."ProtokolAllDetayCiro"
	where "FaturaKdvsizTutar" >=0
	GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","PerformansBolum","UygulayanPersonelId","Grup"--;--,"HastaTip","DoktorTip","BaskinKurumTipi","KurumOdemeTipi","GelisTipi","Grup","UygulayanPersonelId"--,"ProtokolIslemId","ProtokolId"
	)	
	SELECT cte."SubeUstAdi", cte."SubeId","FaturaYil", "FaturaAyNo","PerformansBolum", Count(distinct "UygulayanPersonelId") AS "DoktorSayisi" 
	FROM cte 
	where "UygulayanPersonelId"<>-1111
GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","PerformansBolum" ;--,"HastaTip","DoktorTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","Grup";

*/





--select "UygulayanBolumId" ,* from "MEMOBI_DWH"."FCTProtokol" f
/*select "a24"."BolumId",* from  "MEMOBI_DWH"."DIMBolumMapping" "a24" --on "a24"."BolumId" = f."UygulayanBolumId" 
inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
where "a25"."BolumUstAdi"='Pediatri'*/
--left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("f"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
--select * from "MEMOBI_DM"."ProtokolAllDoktorRapor" where "SubeId" =158 and "FaturaAyNo" =202402

--Doktor Sayısı
/*
create table  "MEMOBI_DM"."ProtokolAllDoktorRaporDev"
as
select * from  "MEMOBI_DM"."ProtokolAllDoktorRapor"
*/
	drop table IF exists "MEMOBI_DM"."ProtokolAllDoktorRapor";
	create table "MEMOBI_DM"."ProtokolAllDoktorRapor"
	as	
	with cte as
	(
	select  ff."SubeId" as "SubeId","a30"."SubeUstAdi" AS "SubeUstAdi",d."PersonelBirlesimId","a2"."Yil" as "FaturaYil","a2"."Yilay" as "FaturaAyNo","a25"."BolumUstAdi" as "UygulayanBolum",d."CalismaTipiId"
	from "MEMOBI_DWH"."FCTProtokol" f
inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetaySGKUnion" ff on f."ProtokolIslemTutarId"::varchar =ff."ProtokolIslemTutarId"::varchar --and ff."SubeId"="a20"."SubeUstId"
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
--select "UygulayanBolumId" ,* from "MEMOBI_DWH"."FCTProtokol" f
--left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("f"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
	where ff."FaturaRaporTarihiId"  >= 20240101 
	)	
	SELECT cte."SubeUstAdi", cte."SubeId","FaturaYil", "FaturaAyNo","UygulayanBolum","CalismaTipiId", Count(distinct "PersonelBirlesimId") AS "DoktorSayisi" 
	FROM cte 
	GROUP BY "SubeUstAdi","SubeId","FaturaYil","FaturaAyNo","UygulayanBolum","CalismaTipiId" ;	



/*Doktor isimleri ara calısma*/
/*
	drop table IF exists "MEMOBI_DM"."ProtokolAllDoktorRaporAdSoyad";
	create table "MEMOBI_DM"."ProtokolAllDoktorRaporAdSoyad"
	as	
	with cte as
	(
	select  ff."SubeId" as "SubeId","a30"."SubeUstAdi" AS "SubeUstAdi",d."PersonelBirlesimId","a115"."PersonelAdiSoyadi","a2"."Yil" as "FaturaYil","a2"."Yilay" as "FaturaAyNo","a25"."BolumUstAdi" as "UygulayanBolum",d."CalismaTipiId"
	from "MEMOBI_DWH"."FCTProtokol" f
inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetaySGKUnion" ff on f."ProtokolIslemTutarId"::varchar =ff."ProtokolIslemTutarId"::varchar --and ff."SubeId"="a20"."SubeUstId"
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
--select "UygulayanBolumId" ,* from "MEMOBI_DWH"."FCTProtokol" f
--left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("f"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
	where ff."FaturaRaporTarihiId"  >= 20240101 
	
	)	
	SELECT distinct cte."SubeUstAdi", cte."SubeId","FaturaYil", "FaturaAyNo","UygulayanBolum","CalismaTipiId", "PersonelBirlesimId","PersonelAdiSoyadi"
	FROM cte 
	GROUP BY "SubeUstAdi", "SubeId","FaturaYil", "FaturaAyNo","UygulayanBolum","CalismaTipiId", "PersonelBirlesimId","PersonelAdiSoyadi" ;	*/
	
------MSTR SORGUSU------

drop table IF exists "MEMOBI_DM"."DM_McKinseyGelirDataDev";
create table "MEMOBI_DM"."DM_McKinseyGelirDataDev"
as
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
sum(0)  as "DoktorSayisi"
from "MEMOBI_DM"."ProtokolAllDetayCiro"
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
sum(0)  as "DoktorSayisi"
from "MEMOBI_DM"."ProtokolAmeliyatCheckupKlinikDetayCiro"
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
sum(0)  as "DoktorSayisi"
from "MEMOBI_DM"."ProtokolAmeliyatAdetRapor"
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
sum(0)  as "DoktorSayisi"
from "MEMOBI_DM"."ProtokolCheckupKlinikAdetRapor"
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
sum(0)  as "DoktorSayisi"
from "MEMOBI_DM"."ProtokolAllAdetRapor"
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
