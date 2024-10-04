--Hizmetlerin Geçtiği Protokoller Hesaplanıyor
select distinct  hp."SubeId" ,HP."Id" as "ProtokolId",OH."Id" as "HizmetId",OH."Adi" as "HizmetAdi",HPI."IslemTarihi" 
--into "MEMOBI_DM"."VINTAGE_PROTOKOL"
from "MEMOBI_ODS_HBYS"."Hasta_Protokol" HP
left join "MEMOBI_ODS_HBYS"."Hasta_ProtokolIslem" HPI on HPI."SubeId" = hp."SubeId" and HPI."ProtokolId" = HP."Id" 
left join "MEMOBI_ODS_MRKZ"."Ortak_Hizmet" OH on OH."Id" = HPI."HizmetId"
where HPI."HizmetId" in (42793,42792,75204,75205,15820,129509,17040,200300)
and HP."State"<>0 and HPI."State">1
and cast(HP."AcilisTarihi" as date) >= '2024-03-01' 
--Fatura Tutarları
select  distinct DSubeUst."SubeUstAdi" AS "SubeUstAdi",
        HP."Id" as "ProtokolId",
	    cast(HP."AcilisTarihi"  as DATE) as "ProtokolAcilisTarihi",
	    VP."HizmetAdi",
	    OH."AltGrup",
	    VP."IslemTarihi",
	    TY."TaburcuTarihi" as "TaburcuTarihi",
	    FF."Tarih"  as "FaturaTarihi",
	    case when FF."FaturaTipiId" = 4 then 'Satış İade'
	 	    when FF."FaturaTipiId" = 9 then 'Kurum' 
	 	    when FF."FaturaTipiId" = 8 then 'Hasta'
	 	    else 'XX'end as "FaturaTipi", 
	    FC."Adi" as "Cari",
	    SUM(FFK."KdvsizTutar") as "KdvsizTutar"
--into "MEMOBI_DM"."VINTAGE_PROTOKOLFATURA" 
from "MEMOBI_DM"."VINTAGE_PROTOKOL" VP
inner join "MEMOBI_ODS_HBYS"."Hasta_Protokol" HP on HP."SubeId" = VP."SubeId" and HP."Id" = VP."ProtokolId"  
inner JOIN "MEMOBI_DWH"."DIMSube" DSube ON (DSube."SubeId" = VP."SubeId") 
inner JOIN "MEMOBI_DWH"."DIMSubeUst" DSubeUst ON (DSubeUst."SubeUstId" = DSube."SubeUstId")
inner join "MEMOBI_DWH"."DIMHizmetMalzeme" OH on OH."HizmetMalzemeId" = VP."HizmetId"
inner join "MEMOBI_ODS_HBYS"."Tedavi_Yatis" TY on TY."SubeId" = VP."SubeId" and TY."ProtokolId"  = VP."ProtokolId"
inner join "MEMOBI_ODS_HBYS"."Finans_Fatura" FF on FF."SubeId" = VP."SubeId" and FF."ProtokolId" = VP."ProtokolId"
inner join "MEMOBI_ODS_HBYS"."Finans_FaturaKalem" FFK on FFK."SubeId" = FF."SubeId" and FF."Id" = FFK."FaturaId"
inner join "MEMOBI_ODS_MRKZ"."Finans_Cari" FC on FC."Id" = FF."CariId" 
where FF."State"<>0  AND  FF."FaturaTipiId" in (8,4,9,12,10,11)
--and VP."ProtokolId" = 80341648
group by  DSubeUst."SubeUstAdi",HP."Id",cast(HP."AcilisTarihi"  as DATE),VP."HizmetAdi",OH."AltGrup",VP."IslemTarihi",TY."TaburcuTarihi",FF."Tarih" ,FF."FaturaTipiId",FC."Adi"
order by 1,2

