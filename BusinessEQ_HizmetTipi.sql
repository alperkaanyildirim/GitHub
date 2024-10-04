--Ameliyatlar Hesaplanıyor
select distinct ff."SubeId",ff."ProtokolId" 
into "MEMOBI_DM"."ProtokolAmeliyat"
from "MEMOBI_ODS_HBYS"."Finans_Fatura" ff 	
inner join "MEMOBI_ODS_HBYS"."Finans_FaturaKalem" ffk  on ffk."FaturaId" = ff."Id" and ff."SubeId" = ffk."SubeId" 
inner join "MEMOBI_ODS_HBYS"."Hasta_ProtokolIslemTutar" hpit on hpit."Id" = ffk."ProtokolIslemTutarId"  and hpit."SubeId" = ffk."SubeId" 
inner join "MEMOBI_ODS_HBYS"."Hasta_ProtokolIslem" hpi on hpi."Id" = hpit."ProtokolIslemId"  and hpi."SubeId" = hpit."SubeId"
inner join "MEMOBI_ODS_HBYS"."Hasta_Protokol" hp on hp."Id" = hpi."ProtokolId"  and hp."SubeId" = hpi."SubeId" 
where ff."FaturaTipiId"  in (8,9) and ff."MatbuFaturaNo"  is not null
	 and ff."MatbuFaturaNo" not in ('E-Fatura','E-Arşiv')
	 and hpi."HizmetId" in  (Select "Id" from "MEMOBI_ODS_MRKZ"."Ortak_Hizmet"  oh where oh."HizmetTipiId"=6 )
	 and ff."CariId" <> 14944
	 and ff."Tarih" >= '2022-01-01'
	 
--Checkuplar Hesaplanıyor
select distinct ff."SubeId",ff."ProtokolId" 
into "MEMOBI_DM"."ProtokolCheckup"
from "MEMOBI_ODS_HBYS"."Finans_Fatura" ff 	
inner join "MEMOBI_ODS_HBYS"."Finans_FaturaKalem" ffk  on ffk."FaturaId" = ff."Id" and ff."SubeId" = ffk."SubeId" 
inner join "MEMOBI_ODS_HBYS"."Hasta_ProtokolIslemTutar" hpit on hpit."Id" = ffk."ProtokolIslemTutarId"  and hpit."SubeId" = ffk."SubeId" 
inner join "MEMOBI_ODS_HBYS"."Hasta_ProtokolIslem" hpi on hpi."Id" = hpit."ProtokolIslemId"  and hpi."SubeId" = hpit."SubeId"
inner join "MEMOBI_ODS_HBYS"."Hasta_Protokol" hp on hp."Id" = hpi."ProtokolId"  and hp."SubeId" = hpi."SubeId" 
where ff."FaturaTipiId"  in (8,9) and ff."MatbuFaturaNo"  is not null
	 and ff."MatbuFaturaNo" not in ('E-Fatura','E-Arşiv')
	 and hpi."HizmetId" in  (Select "Id" from "MEMOBI_ODS_MRKZ"."Ortak_Hizmet"  oh where oh."HizmetTipiId"=21 )
	 and ff."CariId" <> 14944
	 and ff."Tarih" >= '2022-01-01'	 


--Ameliyat ve Checkuplar Hesaplanıyor
select distinct ff."SubeId",ff."ProtokolId" 
into "MEMOBI_DM"."ProtokolAmeliyatCheckup"
from "MEMOBI_ODS_HBYS"."Finans_Fatura" ff 	
inner join "MEMOBI_ODS_HBYS"."Finans_FaturaKalem" ffk  on ffk."FaturaId" = ff."Id" and ff."SubeId" = ffk."SubeId" 
inner join "MEMOBI_ODS_HBYS"."Hasta_ProtokolIslemTutar" hpit on hpit."Id" = ffk."ProtokolIslemTutarId"  and hpit."SubeId" = ffk."SubeId" 
inner join "MEMOBI_ODS_HBYS"."Hasta_ProtokolIslem" hpi on hpi."Id" = hpit."ProtokolIslemId"  and hpi."SubeId" = hpit."SubeId"
inner join "MEMOBI_ODS_HBYS"."Hasta_Protokol" hp on hp."Id" = hpi."ProtokolId"  and hp."SubeId" = hpi."SubeId" 
where ff."FaturaTipiId"  in (8,9) and ff."MatbuFaturaNo"  is not null
	 and ff."MatbuFaturaNo" not in ('E-Fatura','E-Arşiv')
	 and hpi."HizmetId" in  (Select "Id" from "MEMOBI_ODS_MRKZ"."Ortak_Hizmet"  oh where oh."HizmetTipiId" in (6,21) )
	 and ff."CariId" <> 14944
	 and ff."Tarih" >= '2022-01-01'	 
	 
--Business EQ
select 'AMELİYAT' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih","DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet",cast (now() AS timestamp) AS "ETLDate" 
from "DM_AmeliyatMSG" 
union all 
select 'AMELİYAT DİĞER' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih",'' as "DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet",cast (now() AS timestamp) AS "ETLDate" 
from "DM_AmeliyatDigerMSG" 
union all 
select 'ANESTEZİ' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih",'' as "DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet",cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_AnesteziMSG" 
union all 
select 'BRANŞ SPESİFİK' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih",'' as "DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet",cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_BransSpesifikMSG" 
union all 
select 'CHECK UP' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih",'' as "DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet",cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_CheckupMSG" 
union all 
select 'DİĞER' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih",'' as "DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate" 
from "MEMOBI_DM"."DM_DigerMSG" 
union all 
select 'GENEL' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih",'' as "DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet",cast (now() AS timestamp) AS "ETLDate"   
from "MEMOBI_DM"."DM_GenelMSG" 
union all 
select 'ILAC MALZEME KAN' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih",'' as "DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet",cast (now() AS timestamp) AS "ETLDate"   
from "MEMOBI_DM"."DM_IlacMalzemeKanMSG" 
union all 
select 'LABORATUVAR' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih",'' as "DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_LaboratuvarMSG" 
union all 
select 'MUAYENE' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih",'' as "DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_MuayeneMSG" 
union all 
select 'ODA YATAK' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih",'' as "DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_OdaYatakMSG" 
union all 
select 'PATOLOJİ' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih",'' as "DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate" 
from "MEMOBI_DM"."DM_PatolojiMSG" 
union all 
select 'RADYOLOJİ' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih",'' as "DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_RadyolojiMSG" 
union all 
select 'GENETİK' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih",'' as "DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_GenetikMSG"
union all 
select 'KLİNİK ARAŞTIRMALAR' as "Tip","SubeUstAdi","FaturaYil","FaturaAyNo","FaturaTarih",'' as "DoktorTip","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi","FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_KlinikArastirmalarMSG" 
	 

--Ameliyat
with cte AS
(SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
		"a2"."Yil" AS "FaturaYil", 
		"a2"."Yilay" AS "FaturaAyNo",
		"a2"."Tarih" AS "FaturaTarih",					
		"a10"."Tutar" AS "FaturaKdvsizTutar", 
		CASE WHEN "a11"."BolumId" = 1365 THEN 'Misafir' ELSE 'Staf' END AS "DoktorTip", 
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		"a10"."Uyruk" as "HastaTip",
		case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
	 		 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
			 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
		else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
		case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 		 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
			 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
		else "a27"."AltKurumAdi" end as "KurumOdemeTipi",					
		0 AS "Adet" 
 FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
 WHERE "a10"."FaturaRaporTarihiId" >=20240101 
 	   AND "a11"."SubeId" NOT IN (3,36) 
	   AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
	   AND EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyat" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
UNION all 
 SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	    "a2"."Yil" AS "FaturaYil", 
		"a2"."Yilay" AS "FaturaAyNo",
		"a2"."Tarih" AS "FaturaTarih",					
		0 AS "Tutar", 
		CASE WHEN "a11"."BolumId" = 1365 THEN 'Misafir' ELSE 'Staf' END AS "DoktorTip", 
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
	    else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
		case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
	    else "a22"."AltKurumAdi" end as  "KurumOdemeTipi",	
		CASE WHEN ROW_NUMBER() OVER (partition by "a12"."Grup","a11"."ProtokolId","a10"."FaturaRaporTarihiId" ,"a20"."SubeId" ORDER BY "a12"."Grup","a11"."ProtokolId","a10"."FaturaRaporTarihiId","a20"."SubeId" asc)=1 THEN 1 ELSE 0 END AS "Adet" 
 FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	   AND "a10"."FaturaRaporTarihiId" >=20240101 
	   AND "a11"."SubeId" NOT IN (3,36) 
	   AND "a12"."Grup" = 'AMELİYATLAR' 
	   AND ("a22"."AltKurumId" <> 10064)  
 GROUP BY "a20"."SubeAdi", "a20"."SubeId","a2"."Yil","a2"."Yilay","a2"."Tarih","a12"."Grup","a11"."ProtokolId","a10"."FaturaRaporTarihiId","a11"."BolumId","a25"."BolumUstAdi",
           CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
	       case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end
) 
SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo","FaturaTarih","DoktorTip", "HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum (cte."Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate" 
FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","BaskinKurumTipi","KurumOdemeTipi","DoktorTip","HastaTip","PerformansBolum","GelisTipi"

--Ameliyat Diğer
with cte as
(SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	    "a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo",
		"a2"."Tarih" as "FaturaTarih",							
		"a10"."Tutar" AS "FaturaKdvsizTutar",
		"a10"."Uyruk" as "HastaTip",
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
	 		 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
		     when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
			 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
		else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
		case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 		 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
			 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
		else "a27"."AltKurumAdi" end as "KurumOdemeTipi",	
		0 AS "Adet" 
FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
 WHERE "a10"."FaturaRaporTarihiId" >=20240101 
 	    AND "a11"."SubeId" NOT IN (3,36) 
		AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
		AND "a12"."Grup" = 'AMELİYAT DİĞER' 
UNION all 
 SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	    "a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo", 
		"a2"."Tarih" as "FaturaTarih",
		0 AS "Tutar", 
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",						
		case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
 		     when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
		else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
		case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
	    else "a22"."AltKurumAdi" end as  "KurumOdemeTipi",
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'AMELİYAT DİĞER' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
 FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"							
 where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	   AND "a10"."FaturaRaporTarihiId" >=20240101 
	   AND "a11"."SubeId" NOT IN (3,36) 
	   AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId")
	    AND ("a22"."AltKurumId" <> 10064) 
 GROUP BY "a20"."SubeAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a10"."FaturaRaporTarihiId","ss1"."UstId","a25"."BolumUstAdi",case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
	       CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
	       case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end
) 
SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","HastaTip" ,"BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi"
--Anestezi
with cte AS
(SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	     "a2"."Yil" as "FaturaYil", 
		 "a2"."Yilay" as "FaturaAyNo", 
		 "a2"."Tarih" as "FaturaTarih",
		 "a10"."Tutar" AS "FaturaKdvsizTutar", 
		 "a10"."Uyruk" as "HastaTip",
		 "a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
			 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
	    else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
		case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 		 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
			 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
		else "a27"."AltKurumAdi" end as "KurumOdemeTipi",	
		0 AS "Adet" 
FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0		
 WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	    AND "a11"."SubeId" NOT IN (3,36) 
		AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
		AND "a12"."Grup" = 'ANESTEZİ' 
UNION all 
 SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	    "a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo",
		"a2"."Tarih" as "FaturaTarih",			
		0 AS "Tutar", 
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		"a25"."BolumUstAdi" as "PerformansBolum",
 	    case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 		 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
		else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
		case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
	    else "a22"."AltKurumAdi" end as  "KurumOdemeTipi",		
		Count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'ANESTEZİ' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
 FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"		
 where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
  	   AND "a10"."FaturaRaporTarihiId" >=20240101 
	   AND "a11"."SubeId" NOT IN (3,36) 
	    AND ("a22"."AltKurumId" <> 10064) 
	  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
 GROUP BY "a20"."SubeAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a10"."FaturaRaporTarihiId","a25"."BolumUstAdi",case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
	       "ss1"."UstId",CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
	        case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end			
	) 
SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi"
--Brans Spesifik
with cte AS
(SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
		"a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo", 
		"a2"."Tarih" as "FaturaTarih",
		"a10"."Tutar" AS "FaturaKdvsizTutar", 
		"a10"."Uyruk" as "HastaTip",
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
			 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
		else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
		case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 		 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
		     when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
		else "a27"."AltKurumAdi" end as "KurumOdemeTipi",	
		0 AS "Adet" 
  FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0 
  WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	     AND "a11"."SubeId" NOT IN (3,36) 
		 AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		 AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
		 AND "a12"."Grup" = 'BRANŞ SPESİFİK' 
UNION all 
 SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
		 "a2"."Yil" as "FaturaYil", 
		 "a2"."Yilay" as "FaturaAyNo",
 		 "a2"."Tarih" as "FaturaTarih",		 
		 0 AS "Tutar", 
		 CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		 "a25"."BolumUstAdi" as "PerformansBolum",
		 case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		 case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 		  when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			  when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			  when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
		else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
		case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
	    else "a22"."AltKurumAdi" end as  "KurumOdemeTipi",	
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'BRANŞ SPESİFİK' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"		
 where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
       AND "a10"."FaturaRaporTarihiId" >=20240101 
		AND "a11"."SubeId" NOT IN (3,36) 
		 AND ("a22"."AltKurumId" <> 10064) 
		AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
 GROUP BY "a20"."SubeAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a10"."FaturaRaporTarihiId","ss1"."UstId",
		 "a25"."BolumUstAdi",case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
		  CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
		  case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end		
) 
SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi"
--Checkup
with cte as
(SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	    "a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo", 
		"a2"."Tarih" as "FaturaTarih",
		"a10"."Tutar" AS "FaturaKdvsizTutar",
		"a10"."Uyruk" as "HastaTip",
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
						 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
					case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a27"."AltKurumAdi" end as "KurumOdemeTipi",	
		0 AS "Adet" 
  FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
  WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	     AND "a11"."SubeId" NOT IN (3,36) 
		 AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyat" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		 AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
		 AND "a12"."Grup" = 'CHECK UP' 
UNION all 
  SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	      "a2"."Yil" as "FaturaYil", 
		  "a2"."Yilay" as "FaturaAyNo",
		   "a2"."Tarih" as "FaturaTarih",		  
		  0 AS "Tutar", 
		  CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		  "a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		  case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
		case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
	    else "a22"."AltKurumAdi" end as  "KurumOdemeTipi",	
		  CASE WHEN ROW_NUMBER() OVER (partition by "a12"."Grup","a11"."ProtokolId","a10"."FaturaRaporTarihiId" ,"a20"."SubeId" ORDER BY "a12"."Grup","a11"."ProtokolId","a10"."FaturaRaporTarihiId" ,"a20"."SubeId" asc)=1 THEN 1 ELSE 0 END AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"			
   where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	     AND "a10"."FaturaRaporTarihiId" >=20240101 
		 AND "a11"."SubeId" NOT IN (3,36) 
		 AND "a12"."Grup" = 'CHECK UP' 
		  AND ("a22"."AltKurumId" <> 10064) 
   GROUP BY "a20"."SubeAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a10"."FaturaRaporTarihiId",
   "a25"."BolumUstAdi",case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
   "ss1"."UstId",CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
   case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
				 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end
) 
SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi"
--Diğer
with cte as
(SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
		"a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo", 
		"a2"."Tarih" as "FaturaTarih",
		"a10"."Tutar" AS "FaturaKdvsizTutar",
		"a10"."Uyruk" as "HastaTip",
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
						 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
					case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a27"."AltKurumAdi" end as "KurumOdemeTipi",	
		0 AS "Adet" 
 FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
  WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	     AND "a11"."SubeId" NOT IN (3,36) 
		 AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		 AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
		 AND "a12"."Grup" = 'DİĞER' 
   UNION all 
  SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	      "a2"."Yil" as "FaturaYil", 
		  "a2"."Yilay" as "FaturaAyNo",
		  "a2"."Tarih" as "FaturaTarih",		  
		  0 AS "Tutar", 
		  CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		  "a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		 case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
			case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
	    else "a22"."AltKurumAdi" end as  "KurumOdemeTipi",	
		  count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'DİĞER' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"			
   where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
		  AND "a10"."FaturaRaporTarihiId" >=20240101 
		  AND "a11"."SubeId" NOT IN (3,36) 
		   AND ("a22"."AltKurumId" <> 10064) 
		  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	GROUP BY "a20"."SubeAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a10"."FaturaRaporTarihiId","ss1"."UstId",
	"a25"."BolumUstAdi",case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
	CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
	case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
				 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end
	) 
	SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo","FaturaTarih" ,"HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
	FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi"
--Genel
with cte as
(SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	     "a2"."Yil" as "FaturaYil", 
		 "a2"."Yilay" as "FaturaAyNo",
		 "a2"."Tarih" as "FaturaTarih",			 
		 "a10"."Tutar" AS "FaturaKdvsizTutar",
		 "a10"."Uyruk" as "HastaTip",
		 "a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
						 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
					case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a27"."AltKurumAdi" end as "KurumOdemeTipi",	 	
		 0 AS "Adet" 
  FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0	
  WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	    AND "a11"."SubeId" NOT IN (3,36) 
		AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
		AND "a12"."Grup" = 'GENEL' 
   UNION all 
  SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	      "a2"."Yil" as "FaturaYil", 
		  "a2"."Yilay" as "FaturaAyNo", 
		  "a2"."Tarih" as "FaturaTarih",	
		  0 AS "Tutar", 
		  CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		  "a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
			case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
	    else "a22"."AltKurumAdi" end as  "KurumOdemeTipi",	
		  count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'GENEL' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
 FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"		
   where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	     AND "a10"."FaturaRaporTarihiId" >=20240101 
		 AND "a11"."SubeId" NOT IN (3,36) 
		  AND ("a22"."AltKurumId" <> 10064) 
		 AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	GROUP BY "a20"."SubeAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a10"."FaturaRaporTarihiId","ss1"."UstId",
	"a25"."BolumUstAdi",case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
	CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
				 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end							
) 
SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi"
--Genetik
with cte as
(SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
		"a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo", 
		"a2"."Tarih" as "FaturaTarih",	
		"a10"."Tutar" AS "FaturaKdvsizTutar",
		"a10"."Uyruk" as "HastaTip",	
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",		
		case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
						 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
					case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a27"."AltKurumAdi" end as "KurumOdemeTipi",		
		0 AS "Adet" 
 FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
 WHERE "a10"."FaturaRaporTarihiId" >=20240101 
		AND "a11"."SubeId" NOT IN (3,36) 
		AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
		AND "a12"."Grup" = 'GENETİK' 

UNION all 
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
"a2"."Yil" as "FaturaYil", 
"a2"."Yilay" as "FaturaAyNo", 
"a2"."Tarih" as "FaturaTarih",	
0 AS "Tutar", 
CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
	case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
	    else "a22"."AltKurumAdi" end as  "KurumOdemeTipi",	
count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'GENETİK' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"			
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	 AND "a10"."FaturaRaporTarihiId" >=20240101 
	 AND "a11"."SubeId" NOT IN (3,36) 
	  AND ("a22"."AltKurumId" <> 10064) 
	 AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
GROUP BY "a20"."SubeAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a10"."FaturaRaporTarihiId","ss1"."UstId",
"a25"."BolumUstAdi",case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end ,
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
				 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end			
) 
SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo","FaturaTarih", "HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi"
--İlac Malzeme Kan
with cte as(
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	   "a2"."Yil" as "FaturaYil", 
	   "a2"."Yilay" as "FaturaAyNo", 
	   "a2"."Tarih" as "FaturaTarih",	
	   "a10"."Tutar" AS "FaturaKdvsizTutar", 
	   "a10"."Uyruk" as "HastaTip",
	   "a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
	  case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
						 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
					case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a27"."AltKurumAdi" end as "KurumOdemeTipi",	
	   0 AS "Adet" 
FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	   AND "a11"."SubeId" NOT IN (3,36) 
	   AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	   AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
	   AND "a12"."Grup" IN ('İLAÇ','MALZEMELER','KAN ÜRÜNLERİ') 
UNION all 
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
		"a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo", 
		"a2"."Tarih" as "FaturaTarih",	
		0 AS "Tutar",
	   CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",	
	   "a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
			case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "KurumOdemeTipi",	
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" IN ('İLAÇ','MALZEMELER','KAN ÜRÜNLERİ') THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"			
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	 AND "a10"."FaturaRaporTarihiId" >=20240101 
	 AND "a11"."SubeId" NOT IN (3,36) 
	  AND ("a22"."AltKurumId" <> 10064) 
	 AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
GROUP BY "a20"."SubeAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a10"."FaturaRaporTarihiId","ss1"."UstId",
"a25"."BolumUstAdi",case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
				 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end
) SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi"
--Laboratuvar
with cte as(
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	   "a2"."Yil" as "FaturaYil", 
	   "a2"."Yilay" as "FaturaAyNo", 
	   "a2"."Tarih" as "FaturaTarih",
	   "a10"."Tutar" AS "FaturaKdvsizTutar",
	   "a10"."Uyruk" as "HastaTip",	 
"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",	   
	  case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
						 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
					case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a27"."AltKurumAdi" end as "KurumOdemeTipi",	  
	   0 AS "Adet" 
FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	   AND "a11"."SubeId" NOT IN (3,36) 
	   AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	   AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
	   AND "a12"."Grup" = 'LABORATUVAR' 
UNION all 
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	    "a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo",
		"a2"."Tarih" as "FaturaTarih",		
		0 AS "Tutar",
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
					case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "KurumOdemeTipi",		 
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'LABORATUVAR' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"		
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	  AND "a10"."FaturaRaporTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
	   AND ("a22"."AltKurumId" <> 10064) 
	  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	  GROUP BY "a20"."SubeAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a10"."FaturaRaporTarihiId","ss1"."UstId",
	  "a25"."BolumUstAdi",case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
	  CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
	  case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
				 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end			
	  ) 
SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi"
--Muayene
with cte as(
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
		"a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo", 
		"a2"."Tarih" as "FaturaTarih",
		"a10"."Tutar" AS "FaturaKdvsizTutar",
		"a10"."Uyruk" as "HastaTip",
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
    	case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
						 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
		case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a27"."AltKurumAdi" end as "KurumOdemeTipi",		   
		0 AS "Adet" 
FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
	  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyat" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	  AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
	  AND "a12"."Grup" = 'MUAYENE' 
UNION all 
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
		"a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo", 
		"a2"."Tarih" as "FaturaTarih",
		0 AS "Tutar", 
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
					case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "KurumOdemeTipi",		 
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3) AND "a11"."KdvsizHizmetTutari">0) AND "a11"."GelisTipiId" = 'A' AND "a12"."Grup" = 'MUAYENE' THEN "a11"."ProtokolIslemId" end) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"			
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	  AND "a10"."FaturaRaporTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
	   AND ("a22"."AltKurumId" <> 10064) 
GROUP BY "a20"."SubeAdi", "a2"."Yil","a2"."Yilay","a2"."Tarih",CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
"a25"."BolumUstAdi",case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
				 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end
) 
SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi"
--Oda Yatak

with cte as(
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
		"a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo", 
		"a2"."Tarih" as "FaturaTarih",
		"a10"."Tutar" AS "FaturaKdvsizTutar",
		"a10"."Uyruk" as "HastaTip",	
"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",		
case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
						 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
					case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a27"."AltKurumAdi" end as "KurumOdemeTipi",			   
		0 AS "Adet" 
FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0	
WHERE "a10"."FaturaRaporTarihiId" >=20240101 
  	   AND "a11"."SubeId" NOT IN (3,36) 
	   AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	   AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
	   AND "a12"."Grup" = 'ODA YATAK' 
UNION all 
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
		"a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo",
		"a2"."Tarih" as "FaturaTarih",		
		0 AS "Tutar", 
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
					case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "KurumOdemeTipi",		 
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'ODA YATAK' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"		
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	   AND "a10"."FaturaRaporTarihiId" >=20240101 
	   AND "a11"."SubeId" NOT IN (3,36) 
	    AND ("a22"."AltKurumId" <> 10064) 
	   AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
GROUP BY "a20"."SubeAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a10"."FaturaRaporTarihiId",
"a25"."BolumUstAdi",case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
"ss1"."UstId" ,CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
				 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end			
) 
SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi"
--Patoloji

with cte as(
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	   "a2"."Yil" as "FaturaYil", 
	   "a2"."Yilay" as "FaturaAyNo",
		"a2"."Tarih" as "FaturaTarih",	   
	   "a10"."Tutar" AS "FaturaKdvsizTutar", 
	   "a10"."Uyruk" as "HastaTip",
	   "a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
						 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
					case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a27"."AltKurumAdi" end as "KurumOdemeTipi",			   
	   0 AS "Adet" 
FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
	  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	  AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
	  AND "a12"."Grup" = 'PATOLOJİ' 
UNION all 
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	    "a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo", 
		"a2"."Tarih" as "FaturaTarih",
		0 AS "Tutar", 
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "KurumOdemeTipi",		 
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'PATOLOJİ' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"		
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	  AND "a10"."FaturaRaporTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
	   AND ("a22"."AltKurumId" <> 10064) 
	  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
GROUP BY "a20"."SubeAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a10"."FaturaRaporTarihiId","ss1"."UstId",
"a25"."BolumUstAdi",case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
	     CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
				 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end) 
SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi"
--Radyoloji

with cte as(
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	   "a2"."Yil" as "FaturaYil",
	   "a2"."Yilay" as "FaturaAyNo",
		"a2"."Tarih" as "FaturaTarih",	   	   
	   "a10"."Tutar" AS "FaturaKdvsizTutar",
		"a10"."Uyruk" as "HastaTip",
"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",		
case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
						 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
					case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a27"."AltKurumAdi" end as "KurumOdemeTipi",			   
		0 AS "Adet" 
 FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0	
 WHERE "a10"."FaturaRaporTarihiId" >=20240101 
		AND "a11"."SubeId" NOT IN (3,36) 
		AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		AND ("a27"."AltKurumId" <> 10064 or "a26"."AltKurumId" <> 10064)
		AND "a12"."Grup" = 'RADYOLOJİ' 
UNION all 
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	    "a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo", 
		"a2"."Tarih" as "FaturaTarih",	   
		0 AS "Tutar", 
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
					case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "KurumOdemeTipi",		 
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'RADYOLOJİ' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"			
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	   AND "a10"."FaturaRaporTarihiId" >=20240101 
	   AND "a11"."SubeId" NOT IN (3,36)
	    AND ("a22"."AltKurumId" <> 10064) 	   
	   AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
GROUP BY "a20"."SubeAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a10"."FaturaRaporTarihiId","ss1"."UstId",
"a25"."BolumUstAdi",case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
				 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end				
) 
SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo","FaturaTarih", "HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi"
--Klinik Araştırmalar

with cte as(
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	   "a2"."Yil" as "FaturaYil", 
	   "a2"."Yilay" as "FaturaAyNo",
		"a2"."Tarih" as "FaturaTarih",	   
	   "a10"."Tutar" AS "FaturaKdvsizTutar", 
	   "a10"."Uyruk" as "HastaTip",
	   "a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
case when "a26"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a26"."AltKurumAdi" like 'AK%' or "a26"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a26"."AltKurumAdi" like 'CARİ%' or "a11"."KurumId" is null then 'CARİ'
						 when "a26"."AltKurumAdi" is null and "a11"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a26"."AltKurumAdi" end as "BaskinKurumTipi",					
					case when "a27"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a27"."AltKurumAdi" like 'AK%' or "a27"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a27"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a27"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a27"."AltKurumAdi" end as "KurumOdemeTipi",			   
	   0 AS "Adet" 
FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId")  
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId")
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a26" on "a26"."KurumId" = "a11"."BaskinKurumId" and "a26"."KaynakSys" = 0
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a27" on "a27"."KurumId" = "a10"."KurumId" and "a27"."KaynakSys" = 0
WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
	  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	  AND ("a27"."AltKurumId" = 10064 or "a26"."AltKurumId" = 10064)
UNION all 
SELECT "a20"."SubeAdi" AS "SubeUstAdi", 
	    "a2"."Yil" as "FaturaYil", 
		"a2"."Yilay" as "FaturaAyNo", 
		"a2"."Tarih" as "FaturaTarih",
		0 AS "Tutar", 
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
	case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
	 					 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a22"."AltKurumAdi" end as "KurumOdemeTipi",		 	
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a22"."AltKurumAdi" = ('AK KLİNİK ARAŞTIRMA') THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"		
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	  AND "a10"."FaturaRaporTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
	  AND ("a22"."AltKurumId" = 10064) 		  
	  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
GROUP BY "a20"."SubeAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a10"."FaturaRaporTarihiId","ss1"."UstId",
"a25"."BolumUstAdi",case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end,
	     CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
case when "a22"."IkinciAltKurumId" = 10047 then 'SGK' when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
				 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ' when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end
) 
SELECT cte."SubeUstAdi", "FaturaYil", "FaturaAyNo", "FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"FaturaYil","FaturaAyNo","FaturaTarih","HastaTip","BaskinKurumTipi","KurumOdemeTipi","PerformansBolum","GelisTipi"





--HastaSayısı
with cte as(	 
SELECT 
		case when "a12"."Grup" IN ('İLAÇ','MALZEMELER','KAN ÜRÜNLERİ')  then 'ILAC MALZEME KAN' else "a12"."Grup" end as "Grup",
		"a20"."SubeAdi" AS "SubeAdi", 
	    "a2"."Yil" AS "FaturaYil", 
		"a2"."Yilay" AS "FaturaAyNo",
		CASE WHEN "a11"."BolumId" = 1365 THEN 'Misafir' ELSE 'Staf' END AS "DoktorTip", 
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
	    else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
	    "a11"."HastaMerkezId"
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	  AND "a10"."FaturaRaporTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36)
	  AND ("a22"."AltKurumId" <> 10064)  
union all
SELECT 
		'KLİNİK ARAŞTIRMALAR' as "Grup",
		"a20"."SubeAdi" AS "SubeAdi", 
	    "a2"."Yil" AS "FaturaYil", 
		"a2"."Yilay" AS "FaturaAyNo",
		CASE WHEN "a11"."BolumId" = 1365 THEN 'Misafir' ELSE 'Staf' END AS "DoktorTip", 
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
	    else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
	    "a11"."HastaMerkezId"
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	  AND "a10"."FaturaRaporTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
	  AND ("a22"."AltKurumId" = 10064)  

) 
SELECT cte."Grup",cte."SubeAdi", "FaturaYil", "FaturaAyNo","DoktorTip", "HastaTip",count(distinct "HastaMerkezId") as "HastaSayisi",cast (now() AS timestamp) AS "ETLDate" 
FROM cte 
GROUP BY cte."Grup",cte."SubeAdi", "FaturaYil", "FaturaAyNo","DoktorTip", "HastaTip"

--Doktor Sayısı
with cte as(	 
SELECT 
		case when "a12"."Grup" IN ('İLAÇ','MALZEMELER','KAN ÜRÜNLERİ')  then 'ILAC MALZEME KAN' else "a12"."Grup" end as "Grup",
		"a20"."SubeAdi" AS "SubeAdi", 
	    "a2"."Yil" AS "FaturaYil", 
		"a2"."Yilay" AS "FaturaAyNo",
		CASE WHEN "a11"."BolumId" = 1365 THEN 'Misafir' ELSE 'Staf' END AS "DoktorTip", 
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
	    else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
	    "a118"."PersonelId"
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 LEFT JOIN "DM_XLS_Doktor" a18 ON a11."PerformansDoktorId" = a18."DoktorId" AND a11."SubeId" = a18."SubeId" AND a11."PerformansBolumId" = a18."ServisId" AND (a18."MasterDoktorId" <> ALL (ARRAY['-999'::integer, '-9999'::integer])) 
LEFT JOIN "VW_DIMPersonelBirlesim" a118 ON a18."MasterDoktorId" = a118."PersonelId"
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	  AND "a10"."FaturaRaporTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36)
	  AND ("a22"."AltKurumId" <> 10064)  
union all
SELECT 
		'KLİNİK ARAŞTIRMALAR' as "Grup",
		"a20"."SubeAdi" AS "SubeAdi", 
	    "a2"."Yil" AS "FaturaYil", 
		"a2"."Yilay" AS "FaturaAyNo",
		CASE WHEN "a11"."BolumId" = 1365 THEN 'Misafir' ELSE 'Staf' END AS "DoktorTip", 
		"a25"."BolumUstAdi" as "PerformansBolum",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		case when "a22"."IkinciAltKurumId" = 10047 then 'SGK'
			 when "a22"."AltKurumAdi" like 'AK%' or "a22"."IkinciAltKurumId" in (10078,10054,10058,10057,10048,10049,10051,10050,10056) then 'ANLAŞMALI KURUM' 
			 when "a22"."AltKurumAdi" like 'CARİ%' or "a11"."BaskinKurumId" is null then 'CARİ'
			 when "a22"."AltKurumAdi" is null and "a11"."BaskinKurumId" is not null then 'ANLAŞMALI KURUM' 
	    else "a22"."AltKurumAdi" end as "BaskinKurumTipi",					
	    "a118"."PersonelId"
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
 inner join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" on ("a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss1" ON "ss1"."SubeId" = "a10"."SubeId"
 JOIN "MEMOBI_ODS_MRKZ"."Sube_Mapping" "ss2" ON "ss2"."SubeId" = "a11"."SubeId" AND
 case WHEN "a10"."SubeId" = "ss1"."SubeId" THEN "ss1"."UstId" ELSE null END = case WHEN "a11"."SubeId" = "ss2"."SubeId" THEN "ss2"."UstId" ELSE null END
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSube" "a20" ON ("a20"."SubeId" = "ss1"."UstId") 
 left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
 left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
 inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
 inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"
 LEFT JOIN "DM_XLS_Doktor" a18 ON a11."PerformansDoktorId" = a18."DoktorId" AND a11."SubeId" = a18."SubeId" AND a11."PerformansBolumId" = a18."ServisId" AND (a18."MasterDoktorId" <> ALL (ARRAY['-999'::integer, '-9999'::integer])) 
LEFT JOIN "VW_DIMPersonelBirlesim" a118 ON a18."MasterDoktorId" = a118."PersonelId"
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	  AND "a10"."FaturaRaporTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
	  AND ("a22"."AltKurumId" = 10064)  

) 
SELECT cte."Grup",cte."SubeAdi", "FaturaYil", "FaturaAyNo","DoktorTip", "HastaTip",count(distinct "PersonelId") as "DoktorSayisi",cast (now() AS timestamp) AS "ETLDate" 
FROM cte 
GROUP BY cte."Grup",cte."SubeAdi", "FaturaYil", "FaturaAyNo","DoktorTip", "HastaTip"