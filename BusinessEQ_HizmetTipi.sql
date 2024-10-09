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
select 'AMELİYAT' as "Tip","SubeUstAdi","IslemYil","IslemAyNo","IslemTarih","DoktorTip","HastaTip","KurumTip", "FaturaKdvsizTutar","Adet",cast (now() AS timestamp) AS "ETLDate" 
from "DM_AmeliyatMSG" 
union all 
select 'AMELİYAT DİĞER' as "Tip","SubeUstAdi","IslemYil","IslemAyNo","IslemTarih",'' as "DoktorTip","HastaTip","KurumTip", "FaturaKdvsizTutar","Adet",cast (now() AS timestamp) AS "ETLDate" 
from "DM_AmeliyatDigerMSG" 
union all 
select 'ANESTEZİ' as "Tip","SubeUstAdi","IslemYil","IslemAyNo","IslemTarih",'' as "DoktorTip","HastaTip","KurumTip", "FaturaKdvsizTutar","Adet",cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_AnesteziMSG" 
union all 
select 'BRANŞ SPESİFİK' as "Tip","SubeUstAdi","IslemYil","IslemAyNo","IslemTarih",'' as "DoktorTip","HastaTip","KurumTip" ,"FaturaKdvsizTutar","Adet",cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_BransSpesifikMSG" 
union all 
select 'CHECK UP' as "Tip","SubeUstAdi","IslemYil","IslemAyNo","IslemTarih",'' as "DoktorTip","HastaTip","KurumTip" ,"FaturaKdvsizTutar","Adet",cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_CheckupMSG" 
union all 
select 'DİĞER' as "Tip","SubeUstAdi","IslemYil","IslemAyNo","IslemTarih",'' as "DoktorTip","HastaTip","KurumTip", "FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate" 
from "MEMOBI_DM"."DM_DigerMSG" 
union all 
select 'GENEL' as "Tip","SubeUstAdi","IslemYil","IslemAyNo","IslemTarih",'' as "DoktorTip","HastaTip","KurumTip", "FaturaKdvsizTutar","Adet",cast (now() AS timestamp) AS "ETLDate"   
from "MEMOBI_DM"."DM_GenelMSG" 
union all 
select 'ILAC MALZEME KAN' as "Tip","SubeUstAdi","IslemYil","IslemAyNo","IslemTarih",'' as "DoktorTip","HastaTip","KurumTip" ,"FaturaKdvsizTutar","Adet",cast (now() AS timestamp) AS "ETLDate"   
from "MEMOBI_DM"."DM_IlacMalzemeKanMSG" 
union all 
select 'LABORATUVAR' as "Tip","SubeUstAdi","IslemYil","IslemAyNo","IslemTarih",'' as "DoktorTip","HastaTip","KurumTip", "FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_LaboratuvarMSG" 
union all 
select 'MUAYENE' as "Tip","SubeUstAdi","IslemYil","IslemAyNo","IslemTarih",'' as "DoktorTip","HastaTip","KurumTip" ,"FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_MuayeneMSG" 
union all 
select 'ODA YATAK' as "Tip","SubeUstAdi","IslemYil","IslemAyNo","IslemTarih",'' as "DoktorTip","HastaTip","KurumTip" ,"FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_OdaYatakMSG" 
union all 
select 'PATOLOJİ' as "Tip","SubeUstAdi","IslemYil","IslemAyNo","IslemTarih",'' as "DoktorTip","HastaTip","KurumTip", "FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate" 
from "MEMOBI_DM"."DM_PatolojiMSG" 
union all 
select 'RADYOLOJİ' as "Tip","SubeUstAdi","IslemYil","IslemAyNo","IslemTarih",'' as "DoktorTip","HastaTip","KurumTip" ,"FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_RadyolojiMSG" 
union all 
select 'GENETİK' as "Tip","SubeUstAdi","IslemYil","IslemAyNo","IslemTarih",'' as "DoktorTip","HastaTip","KurumTip" ,"FaturaKdvsizTutar","Adet" ,cast (now() AS timestamp) AS "ETLDate"  
from "MEMOBI_DM"."DM_GenetikMSG"
	 

--Ameliyat
with cte AS
(SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
					"a2"."Yil" AS "IslemYil", 
					"a2"."Yilay" AS "IslemAyNo",
					"a2"."Tarih" AS "IslemTarih",					
					"a10"."Tutar" AS "FaturaKdvsizTutar", 
					CASE WHEN "a11"."BolumId" = 1365 THEN 'Misafir' ELSE 'Staf' END AS "DoktorTip", 
					"a10"."Uyruk" as "HastaTip",
					case when "a10"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a10"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a10"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a10"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a10"."AltKurumAdi" end as "KurumTip", 
					0 AS "Adet" 
			FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
			JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."SubeId" = "a11"."SubeId" AND "a10"."ProtokolIslemTutarId"::varchar= "a11"."ProtokolIslemTutarId") 
			left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
			left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
			JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
			LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId")
			WHERE "a10"."FaturaRaporTarihiId" >=20240101 
				  AND "a11"."SubeId" NOT IN (3,36) 
				  AND EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyat" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		UNION all 
			SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
				    "a2"."Yil" AS "IslemYil", 
					"a2"."Yilay" AS "IslemAyNo",
					"a2"."Tarih" AS "IslemTarih",					
					0 AS "Tutar", 
					CASE WHEN "a11"."BolumId" = 1365 THEN 'Misafir' ELSE 'Staf' END AS "DoktorTip", 
					CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
					case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end as "KurumTip", 
					CASE WHEN ROW_NUMBER() OVER (partition by "a12"."Grup","a11"."ProtokolId","a11"."IslemTarihiId" ,"a20"."SubeUstId" ORDER BY "a12"."Grup","a11"."ProtokolId","a11"."IslemTarihiId" ,"a20"."SubeUstId" asc)=1 THEN 1 ELSE 0 END AS "Adet" 
			FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
			left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
			left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
			left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
			LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 
			left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
			left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
			where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
				  AND "a11"."IslemTarihiId" >=20240101 
				  AND "a11"."SubeId" NOT IN (3,36) 
				  AND "a12"."Grup" = 'AMELİYATLAR' 
			GROUP BY "a20"."SubeUstAdi", "a20"."SubeUstId","a2"."Yil","a2"."Yilay","a2"."Tarih","a12"."Grup","a11"."ProtokolId","a11"."IslemTarihiId","a11"."BolumId",
			CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
			case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ' when "a22"."AltKurumAdi" like 'SGK%' then 'SGK' when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM'  else "a22"."AltKurumAdi" end 			
) 
SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo","IslemTarih","DoktorTip", "HastaTip","KurumTip",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum (cte."Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate" 
FROM cte GROUP BY "SubeUstAdi" ,"IslemYil","IslemAyNo","IslemTarih","KurumTip","DoktorTip","HastaTip"
--Ameliyat Diğer
with cte as
(SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	    "a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo",
		"a2"."Tarih" AS "IslemTarih",							
		"a10"."Tutar" AS "FaturaKdvsizTutar",
		"a10"."Uyruk" as "HastaTip",
		case when "a10"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a10"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a10"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a10"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a10"."AltKurumAdi" end as "KurumTip", 
		0 AS "Adet" 
		FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
		JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."SubeId" = "a11"."SubeId" AND "a10"."ProtokolIslemTutarId"::varchar= "a11"."ProtokolIslemTutarId") 
		left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
		left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
		JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
		LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId")
	    WHERE "a10"."FaturaRaporTarihiId" >=20240101 
			   AND "a11"."SubeId" NOT IN (3,36) 
			   AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
			   AND "a12"."Grup" = 'AMELİYAT DİĞER' 
		UNION all 
	SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
		    "a2"."Yil" AS "IslemYil", 
			"a2"."Yilay" AS "IslemAyNo", 
			"a2"."Tarih" AS "IslemTarih",
			0 AS "Tutar", 
			CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",					
			case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end as "KurumTip", 
			count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'AMELİYAT DİĞER' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
	FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
	left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
	left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
	left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
	LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 
	left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
	left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
	where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
		  AND "a11"."IslemTarihiId" >=20240101 
		  AND "a11"."SubeId" NOT IN (3,36) 
		  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId")		  
	GROUP BY "a20"."SubeUstAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a11"."IslemTarihiId","a16"."SubeUstId",	 
	CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
	case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ' when "a22"."AltKurumAdi" like 'SGK%' then 'SGK' when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM'  else "a22"."AltKurumAdi" end 			
) 
SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo", "IslemTarih","HastaTip","KurumTip",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"IslemYil","IslemAyNo","IslemTarih","HastaTip" ,"KurumTip"
--Anestezi
with cte AS
(SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	     "a2"."Yil" AS "IslemYil", 
		 "a2"."Yilay" AS "IslemAyNo", 
		 "a2"."Tarih" AS "IslemTarih",
		 "a10"."Tutar" AS "FaturaKdvsizTutar", 
		 "a10"."Uyruk" as "HastaTip",
		case when "a10"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a10"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a10"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a10"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a10"."AltKurumAdi" end as "KurumTip", 
		 0 AS "Adet" 
  FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
  JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON("a10"."SubeId" = "a11"."SubeId" AND "a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
  left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
  left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
  JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
  LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId")			
  WHERE "a10"."FaturaRaporTarihiId" >=20240101 
		AND "a11"."SubeId" NOT IN (3,36) 
		AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		AND "a12"."Grup" = 'ANESTEZİ' 
	UNION all 
	SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
		    "a2"."Yil" AS "IslemYil", 
			"a2"."Yilay" AS "IslemAyNo",
			"a2"."Tarih" AS "IslemTarih",			
			0 AS "Tutar", 
			CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
			case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end as "KurumTip", 
			count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'ANESTEZİ' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
	FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
	left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
	left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
	left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
	LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 
	left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId"
	left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0		
	where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
		  AND "a11"."IslemTarihiId" >=20240101 
		  AND "a11"."SubeId" NOT IN (3,36) 	  
		  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	GROUP BY "a20"."SubeUstAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a11"."IslemTarihiId",
	 
	"a16"."SubeUstId",CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
	case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ' when "a22"."AltKurumAdi" like 'SGK%' then 'SGK' when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM'  else "a22"."AltKurumAdi" end 			
	) 
SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo", "IslemTarih","HastaTip","KurumTip",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"IslemYil","IslemAyNo","IslemTarih","HastaTip","KurumTip"
--Brans Spesifik
with cte AS
(SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
		"a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo", 
		"a2"."Tarih" AS "IslemTarih",
		"a10"."Tutar" AS "FaturaKdvsizTutar", 
		"a10"."Uyruk" as "HastaTip",
		case when "a10"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a10"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a10"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a10"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a10"."AltKurumAdi" end as "KurumTip", 
		0 AS "Adet" 
  FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
  JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."SubeId" = "a11"."SubeId" AND "a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
  left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
  left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
  JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
  LEFT outer JOIN "MEMOBI_DWH"."DIMTarih" "a17" ON ("a11"."IslemTarihiId" = "a17"."TarihId") 
  LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId")		  
  WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	     AND "a11"."SubeId" NOT IN (3,36) 
		 AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		 AND "a12"."Grup" = 'BRANŞ SPESİFİK' 
	UNION all 
  SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
		 "a2"."Yil" AS "IslemYil", 
		 "a2"."Yilay" AS "IslemAyNo",
		"a2"."Tarih" AS "IslemTarih",		 
		 0 AS "Tutar", 
		 CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		 case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end as "KurumTip", 
		 count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'BRANŞ SPESİFİK' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
  FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
  left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
  left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
  left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
  LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 
  left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId"
  left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
  where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	    AND "a11"."IslemTarihiId" >=20240101 
		AND "a11"."SubeId" NOT IN (3,36) 
		AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
   GROUP BY "a20"."SubeUstAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a11"."IslemTarihiId","a16"."SubeUstId",
    
   CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ' when "a22"."AltKurumAdi" like 'SGK%' then 'SGK' when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM'  else "a22"."AltKurumAdi" end 			
) 
SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo", "IslemTarih","HastaTip","KurumTip",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"IslemYil","IslemAyNo","IslemTarih","HastaTip","KurumTip"
--Checkup
with cte as
(SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	    "a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo", 
		"a2"."Tarih" AS "IslemTarih",
		"a10"."Tutar" AS "FaturaKdvsizTutar",
		"a10"."Uyruk" as "HastaTip",
		case when "a10"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a10"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a10"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a10"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a10"."AltKurumAdi" end as "KurumTip", 
		0 AS "Adet" 
  FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
  JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."SubeId" = "a11"."SubeId" AND "a10"."ProtokolIslemTutarId"::varchar= "a11"."ProtokolIslemTutarId") 
  left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
  left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
  JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
  LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 
  WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	     AND "a11"."SubeId" NOT IN (3,36) 
		 AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyat" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		 AND "a12"."Grup" = 'CHECK UP' 
   UNION all 
  SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	      "a2"."Yil" AS "IslemYil", 
		  "a2"."Yilay" AS "IslemAyNo",
		   "a2"."Tarih" AS "IslemTarih",		  
		  0 AS "Tutar", 
		  CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		  case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end as "KurumTip",  
		  CASE WHEN ROW_NUMBER() OVER (partition by "a12"."Grup","a11"."ProtokolId","a11"."IslemTarihiId" ,"a16"."SubeUstId" ORDER BY "a12"."Grup","a11"."ProtokolId","a11"."IslemTarihiId" ,"a16"."SubeUstId" asc)=1 THEN 1 ELSE 0 END AS "Adet" 
   FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
   left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
   left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
   left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
   LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 
   left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId"  
left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
   where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	     AND "a11"."IslemTarihiId" >=20240101 
		 AND "a11"."SubeId" NOT IN (3,36) 
		 AND "a12"."Grup" = 'CHECK UP'   
   GROUP BY "a20"."SubeUstAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a11"."IslemTarihiId",
    
   "a16"."SubeUstId",CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
   case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ' when "a22"."AltKurumAdi" like 'SGK%' then 'SGK' when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM'  else "a22"."AltKurumAdi" end 			
) 
SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo", "IslemTarih","HastaTip","KurumTip",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"IslemYil","IslemAyNo","IslemTarih","HastaTip","KurumTip"
--Diğer
with cte as
(SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
		"a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo", 
		"a2"."Tarih" AS "IslemTarih",
		"a10"."Tutar" AS "FaturaKdvsizTutar",
		"a10"."Uyruk" as "HastaTip",
		case when "a10"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a10"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a10"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a10"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a10"."AltKurumAdi" end as "KurumTip", 	
		0 AS "Adet" 
  FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
  JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."SubeId" = "a11"."SubeId" AND "a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
  left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
  left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
  JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
  LEFT outer JOIN "MEMOBI_DWH"."DIMTarih" "a17" ON ("a11"."IslemTarihiId" = "a17"."TarihId") 
  LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 
  WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	     AND "a11"."SubeId" NOT IN (3,36) 
		 AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		 AND "a12"."Grup" = 'DİĞER' 
   UNION all 
  SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	      "a2"."Yil" AS "IslemYil", 
		  "a2"."Yilay" AS "IslemAyNo",
		  "a2"."Tarih" AS "IslemTarih",		  
		  0 AS "Tutar", 
		  CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		  case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end as "KurumTip", 
		  count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'DİĞER' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
   FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
   left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
   left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
   left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
   LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 
   left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId"
   left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
   inner JOIN "MEMOBI_DWH"."DIMBolumMapping" "a24" on "a24"."BolumId" = a11."PerformansBolumId" 
	inner JOIN "MEMOBI_DWH"."DIMBolumUst" "a25" on "a25"."BolumUstId" = a24."BolumUstId"			
   where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
		  AND "a11"."IslemTarihiId" >=20240101 
		  AND "a11"."SubeId" NOT IN (3,36) 		  
		  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	GROUP BY "a20"."SubeUstAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a11"."IslemTarihiId","a16"."SubeUstId",
	 
	CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
	case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ' when "a22"."AltKurumAdi" like 'SGK%' then 'SGK' when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM'  else "a22"."AltKurumAdi" end 			
	) 
	SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo","IslemTarih" ,"HastaTip","KurumTip",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
	FROM cte GROUP BY "SubeUstAdi" ,"IslemYil","IslemAyNo","IslemTarih","HastaTip","KurumTip"
--Genel
with cte as
(SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	     "a2"."Yil" AS "IslemYil", 
		 "a2"."Yilay" AS "IslemAyNo",
		 "a2"."Tarih" AS "IslemTarih",			 
		 "a10"."Tutar" AS "FaturaKdvsizTutar",
		 "a10"."Uyruk" as "HastaTip",
		case when "a10"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a10"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a10"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a10"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a10"."AltKurumAdi" end as "KurumTip", 	
		 0 AS "Adet" 
  FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
  JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."SubeId" = "a11"."SubeId" AND "a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
  left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
  left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
  JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
  LEFT outer JOIN "MEMOBI_DWH"."DIMTarih" "a17" ON ("a11"."IslemTarihiId" = "a17"."TarihId") 
  LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId")
  WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	    AND "a11"."SubeId" NOT IN (3,36) 
		AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		AND "a12"."Grup" = 'GENEL' 
   UNION all 
  SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	      "a2"."Yil" AS "IslemYil", 
		  "a2"."Yilay" AS "IslemAyNo", 
		  "a2"."Tarih" AS "IslemTarih",	
		  0 AS "Tutar", 
		  CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		  case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end as "KurumTip", 
		  count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'GENEL' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
   FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
   left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
   left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
   left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
   LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 
   left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId"  
   left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0  
   where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	     AND "a11"."IslemTarihiId" >=20240101 
		 AND "a11"."SubeId" NOT IN (3,36) 
		 AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	GROUP BY "a20"."SubeUstAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a11"."IslemTarihiId","a16"."SubeUstId",
	 
	CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ' when "a22"."AltKurumAdi" like 'SGK%' then 'SGK' when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM'  else "a22"."AltKurumAdi" end 			
) 
SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo", "IslemTarih","HastaTip","KurumTip",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"IslemYil","IslemAyNo","IslemTarih","HastaTip","KurumTip"
--Genetik
with cte as
(SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
		"a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo", 
		"a2"."Tarih" AS "IslemTarih",	
		"a10"."Tutar" AS "FaturaKdvsizTutar",
		"a10"."Uyruk" as "HastaTip",	
		case when "a10"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a10"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a10"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a10"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a10"."AltKurumAdi" end as "KurumTip", 	
		0 AS "Adet" 
 FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."SubeId" = "a11"."SubeId" AND "a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 			
 WHERE "a10"."FaturaRaporTarihiId" >=20240101 
		AND "a11"."SubeId" NOT IN (3,36) 
		AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 		
		AND "a12"."Grup" = 'GENETİK' 

UNION all 
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
"a2"."Yil" AS "IslemYil", 
"a2"."Yilay" AS "IslemAyNo", 
"a2"."Tarih" AS "IslemTarih",	
0 AS "Tutar", 
CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end as "KurumTip", 
count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'GENETİK' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 
left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	 AND "a11"."IslemTarihiId" >=20240101 
	 AND "a11"."SubeId" NOT IN (3,36) 
	 AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
GROUP BY "a20"."SubeUstAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a11"."IslemTarihiId","a16"."SubeUstId",
 
CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end ,
case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ' when "a22"."AltKurumAdi" like 'SGK%' then 'SGK' when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM'  else "a22"."AltKurumAdi" end 			
) 
SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo","IslemTarih", "HastaTip","KurumTip",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"IslemYil","IslemAyNo","IslemTarih","HastaTip","KurumTip"
--İlac Malzeme Kan
with cte as(
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	   "a2"."Yil" AS "IslemYil", 
	   "a2"."Yilay" AS "IslemAyNo", 
	   "a2"."Tarih" AS "IslemTarih",	
	   "a10"."Tutar" AS "FaturaKdvsizTutar", 
	   "a10"."Uyruk" as "HastaTip",
	   case when "a10"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a10"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a10"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a10"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a10"."AltKurumAdi" end as "KurumTip", 	
	   0 AS "Adet" 
FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."SubeId" = "a11"."SubeId" AND "a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMTarih" "a17" ON ("a11"."IslemTarihiId" = "a17"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 
WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	   AND "a11"."SubeId" NOT IN (3,36) 
	   AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	   AND "a12"."Grup" IN ('İLAÇ','MALZEMELER','KAN ÜRÜNLERİ') 
UNION all 
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
		"a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo", 
		"a2"."Tarih" AS "IslemTarih",	
		0 AS "Tutar",
	   CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",	
	 case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end as "KurumTip", 
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" IN ('İLAÇ','MALZEMELER','KAN ÜRÜNLERİ') THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 
left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId"
left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	 AND "a11"."IslemTarihiId" >=20240101 
	 AND "a11"."SubeId" NOT IN (3,36) 		  
	 AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
GROUP BY "a20"."SubeUstAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a11"."IslemTarihiId","a16"."SubeUstId",
 
CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ' when "a22"."AltKurumAdi" like 'SGK%' then 'SGK' when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM'  else "a22"."AltKurumAdi" end 			
) SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo", "IslemTarih","HastaTip","KurumTip",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"IslemYil","IslemAyNo","IslemTarih","HastaTip","KurumTip"
--Laboratuvar
with cte as(
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	   "a2"."Yil" AS "IslemYil", 
	   "a2"."Yilay" AS "IslemAyNo", 
	   "a2"."Tarih" AS "IslemTarih",
	   "a10"."Tutar" AS "FaturaKdvsizTutar",
	   "a10"."Uyruk" as "HastaTip",	 
	  case when "a10"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a10"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
						 when "a10"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a10"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
						 else "a10"."AltKurumAdi" end as "KurumTip", 		   
	   0 AS "Adet" 
FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."SubeId" = "a11"."SubeId" AND "a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMTarih" "a17" ON ("a11"."IslemTarihiId" = "a17"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId")			 
WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	   AND "a11"."SubeId" NOT IN (3,36) 
	   AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	   AND "a12"."Grup" = 'LABORATUVAR' 
UNION all 
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	    "a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo",
		"a2"."Tarih" AS "IslemTarih",		
		0 AS "Tutar",
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end as "KurumTip", 	 
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'LABORATUVAR' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId")
left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId"
left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0		
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	  AND "a11"."IslemTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
	  and "a22"."AltKurumAdi" NOT IN ('AK KLİNİK ARAŞTIRMA')		  
	  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	  GROUP BY "a20"."SubeUstAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a11"."IslemTarihiId","a16"."SubeUstId",
	   
	  CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
	  case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ' when "a22"."AltKurumAdi" like 'SGK%' then 'SGK' when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM'  else "a22"."AltKurumAdi" end 			
	  ) 
SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo", "IslemTarih","HastaTip","KurumTip",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"IslemYil","IslemAyNo","IslemTarih","HastaTip","KurumTip"
--Muayene
with cte as(
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
		"a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo", 
		"a2"."Tarih" AS "IslemTarih",
		"a10"."Tutar" AS "FaturaKdvsizTutar",
		"a10"."Uyruk" as "HastaTip",
    	case when "a10"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
	    	 when "a10"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
			 when "a10"."AltKurumAdi" like 'SGK%' then 'SGK'
			 when "a10"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
		    else "a10"."AltKurumAdi" end as "KurumTip", 		   
		0 AS "Adet" 
FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."SubeId" = "a11"."SubeId" AND "a10"."ProtokolIslemTutarId"::varchar= "a11"."ProtokolIslemTutarId") 
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMTarih" "a17" ON ("a11"."IslemTarihiId" = "a17"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId")
WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
	  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyat" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	  AND "a12"."Grup" = 'MUAYENE' 
UNION all 
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
		"a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo", 
		"a2"."Tarih" AS "IslemTarih",
		0 AS "Tutar", 
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end as "KurumTip", 
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3) AND "a11"."KdvsizHizmetTutari">0) AND "a11"."GelisTipiId" = 'A' AND "a12"."Grup" = 'MUAYENE' THEN "a11"."ProtokolIslemId" end) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId")
left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	  AND "a11"."IslemTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
GROUP BY "a20"."SubeUstAdi", "a2"."Yil","a2"."Yilay","a2"."Tarih",CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
 
case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ' when "a22"."AltKurumAdi" like 'SGK%' then 'SGK' when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM'  else "a22"."AltKurumAdi" end 			
) 
SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo", "IslemTarih","HastaTip","KurumTip",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"IslemYil","IslemAyNo","IslemTarih","HastaTip","KurumTip"
--Oda Yatak
with cte as(
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
		"a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo", 
		"a2"."Tarih" AS "IslemTarih",
		"a10"."Tutar" AS "FaturaKdvsizTutar",
		"a10"."Uyruk" as "HastaTip",	
     	case when "a10"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
	    	 when "a10"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
			 when "a10"."AltKurumAdi" like 'SGK%' then 'SGK'
			 when "a10"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
		    else "a10"."AltKurumAdi" end as "KurumTip", 		   
		0 AS "Adet" 
FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."SubeId" = "a11"."SubeId" AND "a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMTarih" "a17" ON ("a11"."IslemTarihiId" = "a17"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId")
WHERE "a10"."FaturaRaporTarihiId" >=20240101 
  	   AND "a11"."SubeId" NOT IN (3,36) 
	   AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 	 
	   AND "a12"."Grup" = 'ODA YATAK' 
UNION all 
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
		"a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo",
		"a2"."Tarih" AS "IslemTarih",		
		0 AS "Tutar", 
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end as "KurumTip", 
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'ODA YATAK' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId")
left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	   AND "a11"."IslemTarihiId" >=20240101 
	   AND "a11"."SubeId" NOT IN (3,36) 
	   AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
GROUP BY "a20"."SubeUstAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a11"."IslemTarihiId",
 
"a16"."SubeUstId" ,CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end 	   
) 
SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo", "IslemTarih","HastaTip","KurumTip",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"IslemYil","IslemAyNo","IslemTarih","HastaTip","KurumTip"
--Patoloji
with cte as(
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	   "a2"."Yil" AS "IslemYil", 
	   "a2"."Yilay" AS "IslemAyNo",
		"a2"."Tarih" AS "IslemTarih",	   
	   "a10"."Tutar" AS "FaturaKdvsizTutar", 
	   "a10"."Uyruk" as "HastaTip",
	   case when "a10"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
	    	 when "a10"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
			 when "a10"."AltKurumAdi" like 'SGK%' then 'SGK'
			 when "a10"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
		    else "a10"."AltKurumAdi" end as "KurumTip", 		   
	   0 AS "Adet" 
FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."SubeId" = "a11"."SubeId" AND "a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMTarih" "a17" ON ("a11"."IslemTarihiId" = "a17"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId")
WHERE "a10"."FaturaRaporTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
	  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
	  AND "a12"."Grup" = 'PATOLOJİ' 
UNION all 
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	    "a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo", 
		"a2"."Tarih" AS "IslemTarih",
		0 AS "Tutar", 
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end as "KurumTip", 
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'PATOLOJİ' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId")
left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId"
left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0		
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	  AND "a11"."IslemTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 	  
	  AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
GROUP BY "a20"."SubeUstAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a11"."IslemTarihiId","a16"."SubeUstId",
	     CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end
		 ) 
SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo", "IslemTarih","HastaTip","KurumTip",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"IslemYil","IslemAyNo","IslemTarih"
--Radyoloji
with cte as(
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	   "a2"."Yil" AS "IslemYil",
	   "a2"."Yilay" AS "IslemAyNo",
		"a2"."Tarih" AS "IslemTarih",	   	   
	   "a10"."Tutar" AS "FaturaKdvsizTutar",
		"a10"."Uyruk" as "HastaTip",
		case when "a10"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
	    	 when "a10"."AltKurumAdi" like 'CARİ%' or "a10"."KurumId" is null then 'CARİ'
			 when "a10"."AltKurumAdi" like 'SGK%' then 'SGK'
			 when "a10"."AltKurumAdi" is null and "a10"."KurumId" is not null then 'ANLAŞMALI KURUM' 
		    else "a10"."AltKurumAdi" end as "KurumTip", 		   
		0 AS "Adet" 
 FROM "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a10" 
 JOIN "MEMOBI_DWH"."FCTProtokol" "a11" ON ("a10"."SubeId" = "a11"."SubeId" AND "a10"."ProtokolIslemTutarId"= "a11"."ProtokolIslemTutarId") 
 left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
 left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
 JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a10"."FaturaRaporTarihiId" = "a2"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMTarih" "a17" ON ("a11"."IslemTarihiId" = "a17"."TarihId") 
 LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 			
 WHERE "a10"."FaturaRaporTarihiId" >=20240101  
		AND "a11"."SubeId" NOT IN (3,36) 
		AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolAmeliyatCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
		AND "a12"."Grup" = 'RADYOLOJİ' 
UNION all 
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	    "a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo", 
		"a2"."Tarih" AS "IslemTarih",	   
		0 AS "Tutar", 
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM' 
						 when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ'
						 when "a22"."AltKurumAdi" like 'SGK%' then 'SGK'
						 when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' 
					else "a22"."AltKurumAdi" end as "KurumTip", 
		count(distinct CASE WHEN ("a11"."KurumTipiId" IN (0,1,2,3)) AND "a12"."Grup" = 'RADYOLOJİ' THEN "a11"."ProtokolIslemId" END) AS "Adet" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId")
left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0		
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	   AND "a11"."IslemTarihiId" >=20240101 
	   AND "a11"."SubeId" NOT IN (3,36)		  	   
	   AND NOT EXISTS (SELECT 1 FROM "MEMOBI_DM"."ProtokolCheckup" pa WHERE pa."SubeId" = "a11"."SubeId" AND pa."ProtokolId" = "a11"."ProtokolId") 
GROUP BY "a20"."SubeUstAdi", "a2"."Yil","a2"."Yilay" ,"a2"."Tarih","a12"."Grup" ,"a11"."ProtokolId","a11"."IslemTarihiId","a16"."SubeUstId",
CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end,
case when "a22"."AltKurumAdi" like 'AK%' then 'ANLAŞMALI KURUM'  when "a22"."AltKurumAdi" like 'CARİ%' or "a22"."KurumId" is null then 'CARİ' when "a22"."AltKurumAdi" like 'SGK%' then 'SGK' when "a22"."AltKurumAdi" is null and "a22"."KurumId" is not null then 'ANLAŞMALI KURUM' else "a22"."AltKurumAdi" end
) 
SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo","IslemTarih", "HastaTip","KurumTip",sum(cte."FaturaKdvsizTutar") AS "FaturaKdvsizTutar", sum("Adet") AS "Adet" ,cast (now() AS timestamp) AS "ETLDate"
FROM cte GROUP BY "SubeUstAdi" ,"IslemYil","IslemAyNo","IslemTarih","HastaTip","KurumTip"


--------------------------------------


--HastaSayısı
with cte as(	 
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	    "a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo",					
		"a11"."HastaMerkezId",
		case when "a11"."GelisTipiId" = 'Y' then 'Yatan' else 'Ayaktan' end as "GelisTipi",
		CASE WHEN coalesce("a21"."UyrukId",1)=1 THEN 'Yerli' ELSE 'Yabanci' end AS "HastaTip",
		CASE WHEN "a11"."BolumId" = 1365 THEN 'Misafir' ELSE 'Staf' END AS "DoktorTip" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 
left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	  AND "a11"."IslemTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
) 
SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo","DoktorTip", "HastaTip",count(distinct "HastaMerkezId") as "HastaSayisi",cast (now() AS timestamp) AS "ETLDate" 
FROM cte 
GROUP BY cte."SubeUstAdi", "IslemYil", "IslemAyNo","DoktorTip", "HastaTip"
--Doktor Sayısı
with cte as(	 
SELECT "a20"."SubeUstAdi" AS "SubeUstAdi", 
	    "a2"."Yil" AS "IslemYil", 
		"a2"."Yilay" AS "IslemAyNo",					
		"a118"."PersonelId",
		CASE WHEN "a11"."BolumId" = 1365 THEN 'Misafir' ELSE 'Staf' END AS "DoktorTip" 
FROM "MEMOBI_DWH"."FCTProtokol" "a11" 
left outer JOIN "MEMOBI_DWH"."DIMHizmetMalzeme" "a12" ON ("a11"."HizmetMalzemeId" = "a12"."HizmetMalzemeUId") 
left outer JOIN "MEMOBI_DWH"."DIMSube" "a16" ON ("a11"."SubeId" = "a16"."SubeId") 
left outer JOIN "MEMOBI_DWH"."DIMTarih" "a2" ON ("a11"."IslemTarihiId" = "a2"."TarihId") 
LEFT outer JOIN "MEMOBI_DWH"."DIMSubeUst" "a20" ON ("a20"."SubeUstId" = "a16"."SubeUstId") 
left outer join "MEMOBI_DWH"."DIMHastaCurrent" "a21" on "a21"."HastaMerkezId" = "a11"."HastaMerkezId" 
left join "MEMOBI_DM"."DM_XLS_Kurum" "a22" on "a22"."KurumId" = "a11"."BaskinKurumId"   and "a22"."KaynakSys" = 0
LEFT JOIN "DM_XLS_Doktor" a18 ON a11."PerformansDoktorId" = a18."DoktorId" AND a11."SubeId" = a18."SubeId" AND a11."PerformansBolumId" = a18."ServisId" AND (a18."MasterDoktorId" <> ALL (ARRAY['-999'::integer, '-9999'::integer])) 
LEFT JOIN "VW_DIMPersonelBirlesim" a118 ON a18."MasterDoktorId" = a118."PersonelId"
where CASE WHEN "a11"."PState"<>0 AND "a11"."PIState">1 AND "a11"."PITState"<>0 THEN 1 ELSE 0 END = 1 
	  AND "a11"."IslemTarihiId" >=20240101 
	  AND "a11"."SubeId" NOT IN (3,36) 
) 
SELECT cte."SubeUstAdi", "IslemYil", "IslemAyNo","DoktorTip", count(distinct "PersonelId") as "DoktorSayisi",cast (now() AS timestamp) AS "ETLDate" 
FROM cte 
GROUP BY cte."SubeUstAdi", "IslemYil", "IslemAyNo","DoktorTip"