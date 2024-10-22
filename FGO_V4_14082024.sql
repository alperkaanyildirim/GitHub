SET enable_nestloop TO off;

select distinct "SubeId","SubeAdi","Gruplama","Tarih","BolumAdi","ProtokolId",
		ROUND(SUM("DosyaToplamCiro"),2) as "DosyaToplamCiro",
		ROUND(SUM("IndirimliHastaPayi"),2) as "IndirimliHastaPayi",
		ROUND( (SUM("DosyaToplamCiro") - SUM("HizmetCiro") - SUM("MalzemeCiro")),2) as "HedefCiro",
   	    ROUND( (SUM("DosyaToplamCiroFatura") - SUM("HizmetCiroFatura") - SUM("MalzemeCiroFatura")),2) as "HedefCiroFatura"
from
(
--Dosya Toplamı alınıyor
select "a11"."SubeId",
       "a20"."SubeAdi",
		--7001,13650 --ÜCRETLİ, 18782 --SGK ÜCRETLİ,18741 --SGK MO2,19226--SGK MO2 O.U 7121 --MO-2 13657 --MO2 OU	    
		case when coalesce("a14"."KurumId",0) in (0,7001,13650,18782) then 'Cari' else 'MO-2' end as "Gruplama",
		to_date("a11"."FaturaRaporTarihiId"::text, 'YYYYMMDD') as "Tarih",
		"a19"."BolumAdi",
		--count(distinct "a22"."ProtokolId") as "Adet",
		"a22"."ProtokolId",
	    SUM("a12"."KdvliHizmetTutari") AS "DosyaToplamCiro",
	    SUM("a11"."KDVliTutar") AS "DosyaToplamCiroFatura",
	    0 AS "IndirimliHastaPayi",
	    0 as "MalzemeCiro",
	    0 as "MalzemeCiroFatura",
	    0 as "HizmetCiro",
	    0 as "HizmetCiroFatura"
from "MEMOBI_DM"."VW_ProtokolAmeliyat" "a22"
inner join "MEMOBI_ODS_HBYS"."Finans_Fatura" "a66" on "a66"."ProtokolId" = "a22"."ProtokolId" and "a66"."SubeId" = a22."SubeId" 
left join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a11" on "a11"."SubeId" = "a22"."SubeId" and "a11"."ProtokolId" = "a22"."ProtokolId" and "a11"."FaturaId" = "a66"."Id" and a66."State" = 1
left join "MEMOBI_DWH"."FCTProtokol" "a12" on 	("a11"."KaynakSys" = "a12"."KaynakSys" and "a11"."ProtokolIslemTutarId" = "a12"."ProtokolIslemTutarId" and "a11"."SubeId" = "a12"."SubeId")
left join "MEMOBI_DM"."DM_XLS_Kurum" "a14" on "a14"."KurumId" = "a12"."BaskinKurumId" and "a14"."KaynakSys" = "a12"."KaynakSys" 
left join "MEMOBI_DWH"."DIMBolumMapping" "a18" on ("a12"."BolumId" = "a18"."BolumId")
left join "MEMOBI_DWH"."DIMBolum" "a19" on 	("a19"."BolumId" = "a18"."BolumId")
left join "MEMOBI_DWH"."DIMSube" "a20" on	("a20"."SubeId" = "a11"."SubeId") 
where case when "a12"."PState"<>0 and "a12"."PIState">1 and "a12"."PITState"<>0 then 1 else 0 end = 1
		and "a11"."FaturaRaporTarihiId" >=20240101
	   and "a11"."SubeId" in (105,23,158,7)
	   and "a12"."IndirimGrubuId" = 0
	   and ("a14"."KurumId" in (7001,13650,18782,18741,19226,7121,13657) or "a14"."KurumId" is null)
	   and (("a12"."SubeId"  in (105) and "a18"."BolumUstId" in (732,772,738,720,745,736,750,820,751,756))
		 			 or ("a12"."SubeId" in (23) and "a18"."BolumUstId" in ( 732,772,738,720,745,736,750,820,751,756))  
	       	         or ("a12"."SubeId" in (158)  and "a18"."BolumUstId" in (732,772,735,738,720,745,736,750,820,751,756))
					 or ("a12"."SubeId" in (7) and "a18"."BolumUstId" in ( 732,772,735,738,720,745,736,750,820,751,756)))
	   and "a11"."Uyruk" = 'Yerli'
	   and "a11"."KaynakSys" = 0 --Pusula
group by "a11"."SubeId",to_date("a11"."FaturaRaporTarihiId"::text, 'YYYYMMDD'),"a20"."SubeAdi","a14"."KurumId","a19"."BolumAdi","a20"."SubeUstId","a22"."ProtokolId"

union ALL


select "a11"."SubeId",
       "a20"."SubeAdi",
		--7001,13650 --ÜCRETLİ, 18782 --SGK ÜCRETLİ,18741 --SGK MO2,19226--SGK MO2 O.U 7121 --MO-2 13657 --MO2 OU	    
		case when coalesce("a14"."KurumId",0) in (0,7001,13650,18782) then 'Cari' else 'MO-2' end as "Gruplama",
		to_date("a11"."FaturaRaporTarihiId"::text, 'YYYYMMDD') as "Tarih",
		"a19"."BolumAdi",
		--count(distinct "a22"."ProtokolId") as "Adet",
		"a22"."ProtokolId",
	    0 AS "DosyaToplamCiro",
	    0 AS "DosyaToplamCiroFatura",
	    sum("a12"."KdvliIndirimTutari") AS "IndirimliHastaPayi",
	    0 as "MalzemeCiro",
	    0 as "MalzemeCiroFatura",
	    0 as "HizmetCiro",
	    0 as "HizmetCiroFatura"
from "MEMOBI_DM"."VW_ProtokolAmeliyat" "a22"
inner join "MEMOBI_ODS_HBYS"."Finans_Fatura" "a66" on "a66"."ProtokolId" = "a22"."ProtokolId" and "a66"."SubeId" = a22."SubeId" 
left join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a11" on "a11"."SubeId" = "a22"."SubeId" and "a11"."ProtokolId" = "a22"."ProtokolId" and "a11"."FaturaId" = "a66"."Id" and a66."State" = 1
left join "MEMOBI_DWH"."FCTProtokol" "a12" on 	("a11"."KaynakSys" = "a12"."KaynakSys" and "a11"."ProtokolIslemTutarId" = "a12"."ProtokolIslemTutarId" and "a11"."SubeId" = "a12"."SubeId")
left join "MEMOBI_DM"."DM_XLS_Kurum" "a14" on "a14"."KurumId" = "a12"."BaskinKurumId" and "a14"."KaynakSys" = "a12"."KaynakSys" 
left join "MEMOBI_DWH"."DIMBolumMapping" "a18" on ("a12"."BolumId" = "a18"."BolumId")
left join "MEMOBI_DWH"."DIMBolum" "a19" on 	("a19"."BolumId" = "a18"."BolumId")
left join "MEMOBI_DWH"."DIMSube" "a20" on	("a20"."SubeId" = "a11"."SubeId") 
where case when "a12"."PState"<>0 and "a12"."PIState">1 and "a12"."PITState"<>0 then 1 else 0 end = 1
		and "a11"."FaturaRaporTarihiId" >=20240101
	   and "a11"."SubeId" in (105,23,158,7)
	   and "a12"."IndirimGrubuId" = 0
	   and "a12"."KurumTipiId" = 0
	   and ("a14"."KurumId" in (7001,13650,18782,18741,19226,7121,13657) or "a14"."KurumId" is null)
	  and (("a12"."SubeId"  in (105) and "a18"."BolumUstId" in (732,772,738,720,745,736,750,820,751,756))
		 			 or ("a12"."SubeId" in (23) and "a18"."BolumUstId" in ( 732,772,738,720,745,736,750,820,751,756))  
	       	         or ("a12"."SubeId" in (158)  and "a18"."BolumUstId" in (732,772,735,738,720,745,736,750,820,751,756))
					 or ("a12"."SubeId" in (7) and "a18"."BolumUstId" in ( 732,772,735,738,720,745,736,750,820,751,756)))
	   and "a11"."Uyruk" = 'Yerli'
	   and "a11"."KaynakSys" = 0 --Pusula
group by "a11"."SubeId",to_date("a11"."FaturaRaporTarihiId"::text, 'YYYYMMDD'),"a20"."SubeAdi","a14"."KurumId","a19"."BolumAdi","a20"."SubeUstId","a22"."ProtokolId"
union ALL
--Çıkartılacak olan özellikli sarf malzemeleri toplanıyor
select "a11"."SubeId",
       "a20"."SubeAdi",
		--7001,13650 --ÜCRETLİ, 18782 --SGK ÜCRETLİ,18741 --SGK MO2,19226--SGK MO2 O.U 7121 --MO-2 13657 --MO2 OU	    
		case when coalesce("a14"."KurumId",0) in (0,7001,13650,18782) then 'Cari' else 'MO-2' end as "Gruplama",
		to_date("a11"."FaturaRaporTarihiId"::text, 'YYYYMMDD') as "Tarih",
		"a19"."BolumAdi",
		--count(distinct "a22"."ProtokolId") as "Adet",
		"a22"."ProtokolId",
	    0 "DosyaToplamCiro",
		0 AS "DosyaToplamCiroFatura",
        0 AS "IndirimliHastaPayi",
	    SUM("a12"."KdvliHizmetTutari") as "MalzemeCiro",
	    SUM("a11"."KDVliTutar") as "MalzemeCiroFatura",
   	    0 as "HizmetCiro",
	    0 as "HizmetCiroFatura"
from "MEMOBI_DM"."VW_ProtokolAmeliyat" "a22"
inner join "MEMOBI_ODS_HBYS"."Finans_Fatura" "a66" on "a66"."ProtokolId" = "a22"."ProtokolId" and "a66"."SubeId" = a22."SubeId" 
left join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a11" on "a11"."SubeId" = "a22"."SubeId" and "a11"."ProtokolId" = "a22"."ProtokolId" and "a11"."FaturaId" = "a66"."Id" and a66."State" = 1
left join "MEMOBI_DWH"."FCTProtokol" "a12" on 	("a11"."KaynakSys" = "a12"."KaynakSys" and "a11"."ProtokolIslemTutarId" = "a12"."ProtokolIslemTutarId" and "a11"."SubeId" = "a12"."SubeId")
inner join "MEMOBI_DWH"."DIMMalzeme"	"a16" on concat(2, "a16"."MalzemeId")::integer = "a12"."HizmetMalzemeId" and "a16"."KaynakSys" = "a12"."KaynakSys"
left join "MEMOBI_DM"."DM_XLS_Kurum" "a14" on "a14"."KurumId" = "a12"."BaskinKurumId" and "a14"."KaynakSys" = "a12"."KaynakSys" 
left join "MEMOBI_DWH"."DIMBolumMapping" "a18" on ("a12"."BolumId" = "a18"."BolumId")
left join "MEMOBI_DWH"."DIMBolum" "a19" on 	("a19"."BolumId" = "a18"."BolumId")
left join "MEMOBI_DWH"."DIMSube" "a20" on	("a20"."SubeId" = "a11"."SubeId") 
where case when "a12"."PState"<>0 and "a12"."PIState">1 and "a12"."PITState"<>0 then 1 else 0 end = 1
		and "a11"."FaturaRaporTarihiId" >=20240101
	   and "a11"."SubeId" in (105,23,158,7)
	   and ("a14"."KurumId" in (7001,13650,18782,18741,19226,7121,13657) or "a14"."KurumId" is null)
	   and "a12"."IndirimGrubuId" = 0
	   and "a11"."Uyruk" = 'Yerli'
	    and (("a12"."SubeId"  in (105) and "a18"."BolumUstId" in (732,772,738,720,745,736,750,820,751,756))
		 			 or ("a12"."SubeId" in (23) and "a18"."BolumUstId" in ( 732,772,738,720,745,736,750,820,751,756))  
	       	         or ("a12"."SubeId" in (158)  and "a18"."BolumUstId" in (732,772,735,738,720,745,736,750,820,751,756))
					 or ("a12"."SubeId" in (7) and "a18"."BolumUstId" in ( 732,772,735,738,720,745,736,750,820,751,756)))
	   and "a16"."MalzemeTipiId" = 54
	   and "a11"."KaynakSys" = 0 --Pusula
group by "a11"."SubeId",to_date("a11"."FaturaRaporTarihiId"::text, 'YYYYMMDD'),"a20"."SubeAdi","a14"."KurumId","a19"."BolumAdi","a20"."SubeUstId","a22"."ProtokolId"
union ALL
--Çıkartılacak olan hizmetler toplanıyor
select "a11"."SubeId",
       "a20"."SubeAdi",
		--7001,13650 --ÜCRETLİ, 18782 --SGK ÜCRETLİ,18741 --SGK MO2,19226--SGK MO2 O.U 7121 --MO-2 13657 --MO2 OU	    
		case when coalesce("a14"."KurumId",0) in (0,7001,13650,18782) then 'Cari' else 'MO-2' end as "Gruplama",
		to_date("a11"."FaturaRaporTarihiId"::text, 'YYYYMMDD') as "Tarih",
		"a19"."BolumAdi",
		--count(distinct "a22"."ProtokolId") as "Adet",
		"a22"."ProtokolId",
	    0 "DosyaToplamCiro",
		0 AS "DosyaToplamCiroFatura",
	    0 AS "IndirimliHastaPayi",
		0 AS "MalzemeCiro",
		0 AS "MalzemeCiroFatura",
	    SUM("a12"."KdvliHizmetTutari") as "HizmetCiro",
	    SUM("a11"."KDVliTutar") as "HizmetCiroFatura"
from "MEMOBI_DM"."VW_ProtokolAmeliyat" "a22"
inner join "MEMOBI_ODS_HBYS"."Finans_Fatura" "a66" on "a66"."ProtokolId" = "a22"."ProtokolId" and "a66"."SubeId" = a22."SubeId" 
left join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a11" on "a11"."SubeId" = "a22"."SubeId" and "a11"."ProtokolId" = "a22"."ProtokolId" and "a11"."FaturaId" = "a66"."Id" and a66."State" = 1
left join "MEMOBI_DWH"."FCTProtokol" "a12" on 	("a11"."KaynakSys" = "a12"."KaynakSys" and "a11"."ProtokolIslemTutarId" = "a12"."ProtokolIslemTutarId" and "a11"."SubeId" = "a12"."SubeId")
inner join "MEMOBI_DWH"."DIMHizmet"	"a17" on concat(1, "a17"."HizmetId")::integer = "a12"."HizmetMalzemeId" and "a17"."KaynakSys" = "a12"."KaynakSys"
left join "MEMOBI_DM"."DM_XLS_Kurum" "a14" on "a14"."KurumId" = "a12"."BaskinKurumId" and "a14"."KaynakSys" = "a12"."KaynakSys" 
left join "MEMOBI_DWH"."DIMBolumMapping" "a18" on ("a12"."BolumId" = "a18"."BolumId")
left join "MEMOBI_DWH"."DIMBolum" "a19" on 	("a19"."BolumId" = "a18"."BolumId")
left join "MEMOBI_DWH"."DIMSube" "a20" on	("a20"."SubeId" = "a11"."SubeId") 
where case when "a12"."PState"<>0 and "a12"."PIState">1 and "a12"."PITState"<>0 then 1 else 0 end = 1
		and "a11"."FaturaRaporTarihiId" >=20240101
	   and "a11"."SubeId" in (105,23,158,7)	  
	   and ("a14"."KurumId" in (7001,13650,18782,18741,19226,7121,13657) or "a14"."KurumId" is null)
	   and "a12"."IndirimGrubuId" = 0
	   and "a11"."Uyruk" = 'Yerli'
	   and "a17"."HizmetId" in (16201,148548,148547,89458,81464,72931,200090,62342,154799,154061,153703,151995,151994,151594,150553,148996,148995,146489,146488,146487,146486,
										   146485,146484,146483,146482,146492,146491,146490,146239,143604,143603,141236,139174,135402,133001,133000,131624,130110,130061,127189,126077,126076,126075,126074,126073,120120,51176,117745,
										    116530,116220,115880,110559,53658,98301)
	    and (("a12"."SubeId"  in (105) and "a18"."BolumUstId" in (732,772,738,720,745,736,750,820,751,756))
		 			 or ("a12"."SubeId" in (23) and "a18"."BolumUstId" in ( 732,772,738,720,745,736,750,820,751,756))  
	       	         or ("a12"."SubeId" in (158)  and "a18"."BolumUstId" in (732,772,735,738,720,745,736,750,820,751,756))
					 or ("a12"."SubeId" in (7) and "a18"."BolumUstId" in ( 732,772,735,738,720,745,736,750,820,751,756)))
	   and "a11"."KaynakSys" = 0 --Pusula
group by "a11"."SubeId",to_date("a11"."FaturaRaporTarihiId"::text, 'YYYYMMDD'),"a20"."SubeAdi","a14"."KurumId","a19"."BolumAdi","a20"."SubeUstId","a22"."ProtokolId"
) YY
group by YY."SubeId",YY."SubeAdi",YY."Gruplama",YY."Tarih",YY."BolumAdi",YY."ProtokolId"

------------------------------------
--Herşeyden bağımsız Ameliyat Fatura Toplamları
SET enable_nestloop TO off;

select distinct "SubeId","SubeAdi","Gruplama","Tarih","BolumAdi","ProtokolId",
		ROUND(SUM("FaturaToplam"),2) as "FaturaToplam"		
from
(select "a11"."SubeId",
       "a20"."SubeAdi",
		--7001,13650 --ÜCRETLİ, 18782 --SGK ÜCRETLİ,18741 --SGK MO2,19226--SGK MO2 O.U 7121 --MO-2 13657 --MO2 OU	    
		case when coalesce("a14"."KurumId",0) in (0,7001,13650,18782) then 'Cari' else 'MO-2' end as "Gruplama",
		to_date("a11"."FaturaRaporTarihiId"::text, 'YYYYMMDD') as "Tarih",
		"a19"."BolumAdi",
		"a22"."ProtokolId",
		SUM("a11"."KDVliTutar") as "FaturaToplam"
from "MEMOBI_DM"."VW_ProtokolAmeliyat" "a22"
inner join "MEMOBI_ODS_HBYS"."Finans_Fatura" "a66" on "a66"."ProtokolId" = "a22"."ProtokolId" and "a66"."SubeId" = a22."SubeId" 
left join "MEMOBI_DM"."DM_FaturaRaporTablosuDetay" "a11" on "a11"."SubeId" = "a22"."SubeId" and "a11"."ProtokolId" = "a22"."ProtokolId" and "a11"."FaturaId" = "a66"."Id" and a66."State" = 1
left join "MEMOBI_DWH"."FCTProtokol" "a12" on 	("a11"."KaynakSys" = "a12"."KaynakSys" and "a11"."ProtokolIslemTutarId" = "a12"."ProtokolIslemTutarId" and "a11"."SubeId" = "a12"."SubeId")
left join "MEMOBI_DM"."DM_XLS_Kurum" "a14" on "a14"."KurumId" = "a12"."BaskinKurumId" and "a14"."KaynakSys" = "a12"."KaynakSys" 
left join "MEMOBI_DWH"."DIMBolumMapping" "a18" on ("a12"."BolumId" = "a18"."BolumId")
left join "MEMOBI_DWH"."DIMBolum" "a19" on 	("a19"."BolumId" = "a18"."BolumId")
left join "MEMOBI_DWH"."DIMSube" "a20" on	("a20"."SubeId" = "a11"."SubeId") 
where case when "a12"."PState"<>0 and "a12"."PIState">1 and "a12"."PITState"<>0 then 1 else 0 end = 1
		and "a11"."FaturaRaporTarihiId" >=20240101
	   and "a11"."SubeId" in (105,23,158,7)
	   and "a12"."IndirimGrubuId" = 0
	   and ("a14"."KurumId" in (7001,13650,18782,18741,19226,7121,13657) or "a14"."KurumId" is null)
	   and "a11"."Uyruk" = 'Yerli'
	   and "a11"."KaynakSys" = 0 --Pusula
group by "a11"."SubeId",to_date("a11"."FaturaRaporTarihiId"::text, 'YYYYMMDD'),"a20"."SubeAdi","a14"."KurumId","a19"."BolumAdi","a20"."SubeUstId","a22"."ProtokolId"
)YY
group by YY."SubeId",YY."SubeAdi",YY."Gruplama",YY."Tarih",YY."BolumAdi",YY."ProtokolId"
