--where FP."HastaMerkezId" = 80794072 

--HastaDatamart
SELECT T."OncekiAySonGun" AS "Ref_Tarih", 
	   HD."HastaMerkezId", 
	   HD."HastaTCKimlikNo", 
	   HD."TCKNDogrulama", 
	   hd."Yas", 
	   HD."CinsiyetAdi", 
	   HD."UlkeAdi", 
	   HD."IlAdi", 
	   HD."IlceAdi", 
	   HD."Kusak", 
	   HD."YasGrubu", 
	   HT."Recency_Month" AS "Recency_Month", 
	   HT."Tenure_Month" AS "Tenure_Month", 
	   HT."Max_IslemTarihi" AS "SonHizmetTarihi",
	   HT."Min_IslemTarihi" AS "IlkHizmetTarihi", 
	   coalesce(HT."Frekans") AS "Frekans", 
	   round(Coalesce(HC."Total_Ciro_Kdvli_USD_03", 0)::numeric, 2) AS "Ciro_03_USD", 
	   round(Coalesce(HC."Total_Ciro_Kdvli_USD_06", 0)::numeric, 2) AS "Ciro_06_USD", 
	   round(Coalesce (HC."Total_Ciro_Kdvli_USD_012", 0)::numeric, 2) AS "Ciro_012_USD", 
	   round(Coalesce (HC."Total_Ciro_Kdvli_USD_024", 0)::numeric, 2) AS "Ciro_024_USD", 
	   round(Coalesce (HC."Total_Ciro_Kdvli_Usd", 0)::numeric, 2) AS "Total_Ciro_USD", 
	   round(Coalesce (HC."Total_Ciro_Kdvli_USD_03_Ayaktan", 0)::numeric, 2) AS "Total_Ciro_03_Ayaktan_USD", 
	   round(Coalesce (HC."Total_Ciro_Kdvli_USD_03_Yatan", 0)::numeric, 2) AS "Total_Ciro_03_Yatan_USD",
	   round(Coalesce (HC."Total_Ciro_Kdvli_USD_06_Ayaktan", 0)::numeric, 2) AS "Total_Ciro_06_Ayaktan_USD", 
	   round(Coalesce (HC."Total_Ciro_Kdvli_USD_06_Yatan", 0)::numeric, 2) AS "Total_Ciro_06_Yatan_USD", 
	   round(Coalesce (HC."Total_Ciro_Kdvli_USD_012_Ayaktan", 0)::numeric, 2) AS "Total_Ciro_012_Ayaktan_USD", 
	   round(Coalesce (HC."Total_Ciro_Kdvli_USD_012_Yatan", 0)::numeric, 2) AS "Total_Ciro_012_Yatan_USD", 
	   round(Coalesce (HC."Total_Ciro_Kdvli_USD_024_Ayaktan", 0)::numeric, 2) AS "Total_Ciro_024_Ayaktan_USD", 
	   round(Coalesce (HC."Total_Ciro_Kdvli_USD_024_Yatan", 0)::numeric, 2) AS "Total_Ciro_024_Yatan_USD", 
	   round(Coalesce (HC."Total_Ciro_Kdvli_USD_Ayaktan", 0)::numeric, 2) AS "Total_Ciro_Ayaktan_USD", 
	   round(Coalesce (HC."Total_Ciro_Kdvli_USD_Yatan", 0)::numeric, 2) AS "Total_Ciro_Yatan_USD", 
	   COALESCE(HFA."Lab_Flag", 0) AS "Lab_Flag", 
	   COALESCE(HFA."Rad_Flag", 0) AS "Rad_Flag", 
	   COALESCE(HF."Lab_Flag_03", 0) AS "Lab_Flag_03", 
	   COALESCE(HF."Lab_Flag_06", 0) AS "Lab_Flag_06", 
	   COALESCE(HF."Lab_Flag_012", 0) AS "Lab_Flag_012", 
	   COALESCE(HF."Lab_Flag_024", 0) AS "Lab_Flag_024",
	   COALESCE(HF."Rad_Flag_03", 0) AS "Rad_Flag_03", 
	   COALESCE(HF."Rad_Flag_06", 0) AS "Rad_Flag_06", 
	   COALESCE(HF."Rad_Flag_012", 0) AS "Rad_Flag_012",
	   COALESCE(HF."Rad_Flag_024", 0) AS "Rad_Flag_024", 
	   COALESCE(HF."Acil_Flag_03", 0) AS "Acil_Flag_03", 
	   COALESCE(HF."Acil_Flag_06", 0) AS "Acil_Flag_06", 
	   COALESCE(HF."Acil_Flag_012", 0) AS "Acil_Flag_012",
	   COALESCE(HF."Acil_Flag_024", 0) AS "Acil_Flag_024",
	   COALESCE(HF."Ayaktan_Flag_03", 0) AS "Ayaktan_Flag_03", 
	   COALESCE(HF."Ayaktan_Flag_06", 0) AS "Ayaktan_Flag_06", 
	   COALESCE(HF."Ayaktan_Flag_012", 0) AS "Ayaktan_Flag_012", 
	   COALESCE(HF."Ayaktan_Flag_024", 0) AS "Ayaktan_Flag_024", 
	   COALESCE(HF."Yatan_Flag_03", 0) AS "Yatan_Flag_03",
	   COALESCE(HF."Yatan_Flag_06", 0) AS "Yatan_Flag_06", 
	   COALESCE(HF."Yatan_Flag_012", 0) AS "Yatan_Flag_012",
	   COALESCE(HF."Yatan_Flag_024", 0) AS "Yatan_Flag_024", 
	   COALESCE(HFA."Acil_Flag", 0) AS "Acil",
	   COALESCE(HFA."Ayaktan_Flag", 0) AS "Ayaktan", 
	   COALESCE(HFA."Yatan_Flag", 0) AS "Yatan",
	   COALESCE(HFA."SubeSegment", 0) AS "SubeSegment", 
	   COALESCE(HF."Sisli_Flag_03", 0) AS "Sisli_Flag_03", 
	   COALESCE(HF."Atasehir_Flag_03", 0) AS "Atasehir_Flag_03", 
	   COALESCE(HF."Antalya_Flag_03", 0) AS "Antalya_Flag_03", 
	   COALESCE(HF."Hizmet_Flag_03", 0) AS "Hizmet_Flag_03", 
	   COALESCE(HF."Diyarbakir_Flag_03", 0) AS "Diyarbakir_Flag_03", 
	   COALESCE(HF."MedStarAntalya_Flag_03", 0) AS "MedStarAntalya_Flag_03", 
	   COALESCE(HF."Topcular_Flag_03", 0) AS "Topcular_Flag_03", 
	   COALESCE(HF."Kayseri_Flag_03", 0) AS "Kayseri_Flag_03", 
	   COALESCE(HF."Ankara_Flag_03", 0) AS "Ankara_Flag_03", 
	   COALESCE(HF."Dicle_Flag_03", 0) AS "Dicle_Flag_03",
	   COALESCE(HF."Bahcelievler_Flag_03", 0) AS "Bahcelievler_Flag_03",
	   COALESCE(HF."Sisli_Flag__06", 0) AS "Sisli_Flag_06", 
	   COALESCE(HF."Atasehir_Flag__06", 0) AS "Atasehir_Flag_06",
	   COALESCE(HF."Antalya_Flag__06", 0) AS "Antalya_Flag_06", 
	   COALESCE(HF."Hizmet_Flag__06", 0) AS "Hizmet_Flag_06", 
	   COALESCE(HF."Diyarbakir_Flag__06", 0) AS "Diyarbakir_Flag_06", 
	   COALESCE(HF."MedStarAntalya_Flag__06", 0) AS "MedStarAntalya_Flag_06",
	   COALESCE(HF."Topcular_Flag__06", 0) AS "Topcular_Flag_06", 
	   COALESCE(HF."Kayseri_Flag__06", 0) AS "Kayseri_Flag_06",
	   COALESCE(HF."Ankara_Flag__06", 0) AS "Ankara_Flag_06", 
	   COALESCE(HF."Dicle_Flag__06", 0) AS "Dicle_Flag_06", 
	   COALESCE(HF."Bahcelievler_Flag__06", 0) AS "Bahcelievler_Flag_06", 
	   COALESCE(HF."Sisli_Flag__012", 0) AS "Sisli_Flag_012", 
	   COALESCE(HF."Atasehir_Flag__012", 0) AS "Atasehir_Flag_012",
	   COALESCE(HF."Antalya_Flag__012", 0) AS "Antalya_Flag_012", 
	   COALESCE(HF."Hizmet_Flag__012", 0) AS "Hizmet_Flag_012",
	   COALESCE(HF."Diyarbakir_Flag__012", 0) AS "Diyarbakir_Flag_012", 
	   COALESCE(HF."MedStarAntalya_Flag__012", 0) AS "MedStarAntalya_Flag_012",
	   COALESCE(HF."Topcular_Flag__012", 0) AS "Topcular_Flag_012", 
	   COALESCE(HF."Kayseri_Flag__012", 0) AS "Kayseri_Flag_012", 
	   COALESCE(HF."Ankara_Flag__012", 0) AS "Ankara_Flag_012",
	   COALESCE(HF."Dicle_Flag__012", 0) AS "Dicle_Flag_012", 
	   COALESCE(HF."Bahcelievler_Flag__012", 0) AS "Bahcelievler_Flag_012",
	   COALESCE(HF."Sisli_Flag__024", 0) AS "Sisli_Flag_024", 
	   COALESCE(HF."Atasehir_Flag__024", 0) AS "Atasehir_Flag_024",
	   COALESCE(HF."Antalya_Flag__024", 0) AS "Antalya_Flag_024", 
	   COALESCE(HF."Hizmet_Flag__024", 0) AS "Hizmet_Flag_024", 
	   COALESCE(HF."Diyarbakir_Flag__024", 0) AS "Diyarbakir_Flag_024",
	   COALESCE(HF."MedStarAntalya_Flag__024", 0) AS "MedStarAntalya_Flag_024",
	   COALESCE(HF."Topcular_Flag__024", 0) AS "Topcular_Flag_024", 
	   COALESCE(HF."Kayseri_Flag__024", 0) AS "Kayseri_Flag_024", 
	   COALESCE(HF."Ankara_Flag__024", 0) AS "Ankara_Flag_024", 
	   COALESCE(HF."Dicle_Flag__024", 0) AS "Dicle_Flag_024", 
	   COALESCE(HF."Bahcelievler_Flag__024", 0) AS "Bahcelievler_Flag_024", 
	   COALESCE(HFA."Sisli_Flag", 0) AS "Sisli_Flag",
	   COALESCE(HFA."Atasehir_Flag", 0) AS "Atasehir_Flag", 
	   COALESCE(HFA."Antalya_Flag", 0) AS "Antalya_Flag", 
	   COALESCE(HFA."Hizmet_Flag", 0) AS "Hizmet_Flag", 
	   COALESCE(HFA."Diyarbakir_Flag", 0) AS "Diyarbakir_Flag",
	   COALESCE(HFA."MedStarAntalya_Flag", 0) AS "MedStarAntalya_Flag",
	   COALESCE(HFA."Topcular_Flag", 0) AS "Topcular_Flag", 
	   COALESCE(HFA."Kayseri_Flag", 0) AS "Kayseri_Flag", 
	   COALESCE(HFA."Ankara_Flag", 0) AS "Ankara_Flag", 
	   COALESCE(HFA."Dicle_Flag", 0) AS "Dicle_Flag", 
	   COALESCE(HFA."Bahcelievler_Flag", 0) AS "Bahcelievler_Flag",
	   COALESCE(SBD."SubeUstId2Yil", 0) AS "Son2Yil_EnCokSube_Id", 
	   SBD."Lokasyon2Yil" AS "Son2Yil_EnCokSube_Adi",
	   COALESCE(SBD."EnCokSubeUstId", 0) AS "EnCokSube_Id", 
	   SBD."EnCokLokasyon" AS "EnCokSube_Adi", 
	   COALESCE(SBD."EnSonSubeUstId", 0) AS "EnSonSube_Id",
	   SBD."EnSonLokasyon" AS "EnSonSube_Adi", 
	   COALESCE(SBD."DoktorId2Yil", 0) AS "Son2Yil_EnCokDoktor_Id",
	   SBD."DoktorAdi2Yil" AS "Son2Yil_EnCokDoktor_Adi",
	   COALESCE(SBD."EnCokDoktorId", 0) AS "EnCokDoktor_Id",
	   SBD."EnCokDoktorAdi" AS "EnCokDoktor_Adi", 
	   COALESCE(SBD."EnSonDoktorId", 0) AS "EnSonDoktor_Id",
	   SBD."EnSonDoktorAdi" AS "EnSonDoktor_Adi",
	   SBD."EnCokBolumAdi" AS "EnCokBolum_Adi",
	   SBD."EnCokBolumId" AS "EnCokBolum_Id", 
	   SBD."BolumAdi2Yil" AS "Son2Yil_BaskinBolum",
	   SBD."EnSonBolumAdi" AS "EnSonBolum_Adi",
	   SBD."EnSonBolumId" AS "EnSonBolum_Id", 
	   COALESCE(HF."Farkli_BolumAdet", 0) AS "KacFarklıBolum",
	   COALESCE(HF."Farkli_BolumAdet_03", 0) AS "KacFarklıBolum_03",
	   COALESCE(HF."Farkli_BolumAdet_06", 0) AS "KacFarklıBolum_06",
	   COALESCE(HF."Farkli_BolumAdet_012", 0) AS "KacFarklıBolum_012", 
	   COALESCE(HF."Farkli_BolumAdet_24", 0) AS "KacFarklıBolum_024",
	   COALESCE(HF."Adet_03", 0) AS "Frekans_03", 
	   COALESCE(HF."Adet_06", 0) AS "Frekans_06",
	   COALESCE(HF."Adet_012", 0) AS "Frekans_012",
	   COALESCE(HF."Adet_024", 0) AS "Frekans_024",
	   COALESCE(HF."Adet_Ay", 0) AS "KacFarklıAy",
	   COALESCE(HF."Adet_Ay_03", 0) AS "KacFarklıAy_03", 
	   COALESCE(HF."Adet_Ay_06", 0) AS "KacFarklıAy_06",
	   COALESCE(HF."Adet_Ay_012", 0) AS "KacFarklıAy_012",
	   COALESCE(HF."Adet_Ay_024", 0) AS "KacFarklıAy_024", 
	   COALESCE(HF."Hizmet_01", 0) AS "Hizmet_01",
	   COALESCE(HF."Hizmet_02", 0) AS "Hizmet_02",
	   COALESCE(HF."Hizmet_03", 0) AS "Hizmet_03", 
	   COALESCE(HF."Hizmet_04", 0) AS "Hizmet_04", 
	   COALESCE(HF."Hizmet_05", 0) AS "Hizmet_05",
	   COALESCE(HF."Hizmet_06", 0) AS "Hizmet_06",
	   COALESCE(HF."Hizmet_07", 0) AS "Hizmet_07",
	   COALESCE(HF."Hizmet_08", 0) AS "Hizmet_08", 
	   COALESCE(HF."Hizmet_09", 0) AS "Hizmet_09",
	   COALESCE(HF."Hizmet_010", 0) AS "Hizmet_010",
	   COALESCE(HF."Hizmet_011", 0) AS "Hizmet_011", 
	   COALESCE(HF."Hizmet_012", 0) AS "Hizmet_012",
	   COALESCE(HF."Hizmet_12", 0) AS "Hizmet_12", 
	   COALESCE(HF."Hizmet_13_24", 0) AS "Hizmet_13_24", 
	   COALESCE(HF."Hizmet_24", 0) AS "Hizmet_24", 
	   COALESCE(HF."Hizmet_Dahiliye_03", 0) AS "Hizmet_Dahiliye_03", 
	   COALESCE(HF."Hizmet_Dahiliye_06", 0) AS "Hizmet_Dahiliye_06", 
	   COALESCE(HF."Hizmet_Dahiliye_012", 0) AS "Hizmet_Dahiliye_012", 
	   COALESCE(HF."Hizmet_Dahiliye_013_024", 0) AS "Hizmet_Dahiliye_013_024", 
	   COALESCE(HF."Hizmet_Dahiliye_024", 0) AS "Hizmet_Dahiliye_024", 
	   COALESCE(HF."Hizmet_Dermatoloji_03", 0) AS "Hizmet_Dermatoloji_03", 
	   COALESCE(HF."Hizmet_Dermatoloji_06", 0) AS "Hizmet_Dermatoloji_06", 
	   COALESCE(HF."Hizmet_Dermatoloji_012", 0) AS "Hizmet_Dermatoloji_012", 
	   COALESCE(HF."Hizmet_Dermatoloji_013_024", 0) AS "Hizmet_Dermatoloji_013_024", 
	   COALESCE(HF."Hizmet_Dermatoloji_024", 0) AS "Hizmet_Dermatoloji_024",
	   COALESCE(HF."Hizmet_Endokrinoloji_03", 0) AS "Hizmet_Endokrinoloji_03", 
	   COALESCE(HF."Hizmet_Endokrinoloji_06", 0) AS "Hizmet_Endokrinoloji_06", 
	   COALESCE(HF."Hizmet_Endokrinoloji_012", 0) AS "Hizmet_Endokrinoloji_012",
	   COALESCE(HF."Hizmet_Endokrinoloji_013_024", 0) AS "Hizmet_Endokrinoloji_013_024",
	   COALESCE(HF."Hizmet_Endokrinoloji_024", 0) AS "Hizmet_Endokrinoloji_024", 
	   COALESCE(HF."Hizmet_Gastroentoroloji_03", 0) AS "Hizmet_Gastroentoroloji_03",
	   COALESCE(HF."Hizmet_Gastroentoroloji_06", 0) AS "Hizmet_Gastroentoroloji_06", 
	   COALESCE(HF."Hizmet_Gastroentoroloji_012", 0) AS "Hizmet_Gastroentoroloji_012",
	   COALESCE(HF."Hizmet_Gastroentoroloji_013_024", 0) AS "Hizmet_Gastroentoroloji_013_024",
	   COALESCE(HF."Hizmet_Gastroentoroloji_024", 0) AS "Hizmet_Gastroentoroloji_024",
	   COALESCE(HF."Hizmet_GenelCerrahi_03", 0) AS "Hizmet_GenelCerrahi_03", 
	   COALESCE(HF."Hizmet_GenelCerrahi_06", 0) AS "Hizmet_GenelCerrahi_06",
	   COALESCE(HF."Hizmet_GenelCerrahi_012", 0) AS "Hizmet_GenelCerrahi_012",
	   COALESCE(HF."Hizmet_GenelCerrahi_013_024", 0) AS "Hizmet_GenelCerrahi_013_024",
	   COALESCE(HF."Hizmet_GenelCerrahi_024", 0) AS "Hizmet_GenelCerrahi_024",
	   COALESCE(HF."Hizmet_GogusHastaliklari_03", 0) AS "Hizmet_GogusHastaliklari_03", 
	   COALESCE(HF."Hizmet_GogusHastaliklari_06", 0) AS "Hizmet_GogusHastaliklari_06",
	   COALESCE(HF."Hizmet_GogusHastaliklari_012", 0) AS "Hizmet_GogusHastaliklari_012", 
	   COALESCE(HF."Hizmet_GogusHastaliklari_013_024", 0) AS "Hizmet_GogusHastaliklari_013_024", 
	   COALESCE(HF."Hizmet_GogusHastaliklari_024", 0) AS "Hizmet_GogusHastaliklari_024", 
	   COALESCE(HF."Hizmet_Goz_03", 0) AS "Hizmet_Goz_03",
	   COALESCE(HF."Hizmet_Goz_06", 0) AS "Hizmet_Goz_06",
	   COALESCE(HF."Hizmet_Goz_012", 0) AS "Hizmet_Goz_012", 
	   COALESCE(HF."Hizmet_Goz_013_024", 0) AS "Hizmet_Goz_013_024",
	   COALESCE(HF."Hizmet_Goz_024", 0) AS "Hizmet_Goz_024", 
	   COALESCE(HF."Hizmet_Kardiyoloji_03", 0) AS "Hizmet_Kardiyoloji_03",
	   COALESCE(HF."Hizmet_Kardiyoloji_06", 0) AS "Hizmet_Kardiyoloji_06", 
	   COALESCE(HF."Hizmet_Kardiyoloji_012", 0) AS "Hizmet_Kardiyoloji_012", 
	   COALESCE(HF."Hizmet_Kardiyoloji_013_024", 0) AS "Hizmet_Kardiyoloji_013_024",
	   COALESCE(HF."Hizmet_Kardiyoloji_024", 0) AS "Hizmet_Kardiyoloji_024", 
	   COALESCE(HF."Hizmet_KBB_03", 0) AS "Hizmet_KBB_03", 
	   COALESCE(HF."Hizmet_KBB_06", 0) AS "Hizmet_KBB_06", 
	   COALESCE(HF."Hizmet_KBB_012", 0) AS "Hizmet_KBB_012", 
	   COALESCE(HF."Hizmet_KBB_013_024", 0) AS "Hizmet_KBB_013_024",
	   COALESCE(HF."Hizmet_KBB_024", 0) AS "Hizmet_KBB_024", 
	   COALESCE(HF."Hizmet_Noroloji_03", 0) AS "Hizmet_Noroloji_03", 
	   COALESCE(HF."Hizmet_Noroloji_06", 0) AS "Hizmet_Noroloji_06",
	   COALESCE(HF."Hizmet_Noroloji_012", 0) AS "Hizmet_Noroloji_012",
	   COALESCE(HF."Hizmet_Noroloji_013_024", 0) AS "Hizmet_Noroloji_013_024", 
	   COALESCE(HF."Hizmet_Noroloji_024", 0) AS "Hizmet_Noroloji_024", 
	   COALESCE(HF."Hizmet_Norosijurji_03", 0) AS "Hizmet_Norosirurji_03", 
	   COALESCE(HF."Hizmet_Norosijurji_06", 0) AS "Hizmet_Norosirurji_06", 
	   COALESCE(HF."Hizmet_Norosijurji_012", 0) AS "Hizmet_Norosirurji_012",
	   COALESCE(HF."Hizmet_Norosijurji_013_024", 0) AS "Hizmet_Norosirurji_013_024", 
	   COALESCE(HF."Hizmet_Norosijurji_024", 0) AS "Hizmet_Norosirurji_024", 
	   COALESCE(HF."Hizmet_Ortopedi_03", 0) AS "Hizmet_Ortopedi_03", 
	   COALESCE(HF."Hizmet_Ortopedi_06", 0) AS "Hizmet_Ortopedi_06", 
	   COALESCE(HF."Hizmet_Ortopedi_012", 0) AS "Hizmet_Ortopedi_012", 
	   COALESCE(HF."Hizmet_Ortopedi_013_024", 0) AS "Hizmet_Ortopedi_013_024", 
	   COALESCE(HF."Hizmet_Ortopedi_024", 0) AS "Hizmet_Ortopedi_024", 
	   COALESCE(HF."Hizmet_Uroloji_03", 0) AS "Hizmet_Uroloji_03",
	   COALESCE(HF."Hizmet_Uroloji_06", 0) AS "Hizmet_Uroloji_06", 
	   COALESCE(HF."Hizmet_Uroloji_012", 0) AS "Hizmet_Uroloji_012", 
	   COALESCE(HF."Hizmet_Uroloji_013_024", 0) AS "Hizmet_Uroloji_013_024",
	   COALESCE(HF."Hizmet_Uroloji_024", 0) AS "Hizmet_Uroloji_024", 
	   COALESCE(HT."Checkup_Flag_03", 0) AS "Checkup_Flag_03", 
	   COALESCE(HT."Checkup_Flag_06", 0) AS "Checkup_Flag_06", 
	   COALESCE(HT."Checkup_Flag_012", 0) AS "Checkup_Flag_012",
	   COALESCE(HT."Checkup_Flag_024", 0) AS "Checkup_Flag_024",
	   COALESCE(HR."Randevu_Kaynak_Mobil_Flag_03", 0) AS "Randevu_Kaynak_Mobil_Flag_03", 
	   COALESCE(HR."Randevu_Kaynak_Mobil_Flag_06", 0) AS "Randevu_Kaynak_Mobil_Flag_06", 
	   COALESCE(HR."Randevu_Kaynak_Mobil_Flag_012", 0) AS "Randevu_Kaynak_Mobil_Flag_012", 
	   COALESCE(HR."Randevu_Kaynak_Mobil_Flag_024", 0) AS "Randevu_Kaynak_Mobil_Flag_024", 
	   COALESCE(HR."Randevu_Kaynak_Pusula_HBYS_Flag_03", 0) AS "Randevu_Kaynak_Pusula_HBYS_Flag_03", 
	   COALESCE(HR."Randevu_Kaynak_Pusula_HBYS_Flag_06", 0) AS "Randevu_Kaynak_Pusula_HBYS_Flag_06", 
	   COALESCE(HR."Randevu_Kaynak_Pusula_HBYS_Flag_012", 0) AS "Randevu_Kaynak_Pusula_HBYS_Flag_012",
	   COALESCE(HR."Randevu_Kaynak_Pusula_HBYS_Flag_024", 0) AS "Randevu_Kaynak_Pusula_HBYS_Flag_024", 
	   COALESCE(HR."Randevu_Kaynak_Websitesi_Flag_03", 0) AS "Randevu_Kaynak_Websitesi_Flag_03", 
	   COALESCE(HR."Randevu_Kaynak_Websitesi_Flag_06", 0) AS "Randevu_Kaynak_Websitesi_Flag_06", 
	   COALESCE(HR."Randevu_Kaynak_Websitesi_Flag_012", 0) AS "Randevu_Kaynak_Websitesi_Flag_012", 
	   COALESCE(HR."Randevu_Kaynak_Websitesi_Flag_024", 0) AS "Randevu_Kaynak_Websitesi_Flag_024", 
	   COALESCE(HR."Randevu_Kaynak_CagriMerkezi_Flag_03", 0) AS "Randevu_Kaynak_CagriMerkezi_Flag_03", 
	   COALESCE(HR."Randevu_Kaynak_CagriMerkezi_Flag_06", 0) AS "Randevu_Kaynak_CagriMerkezi_Flag_06",
	   COALESCE(HR."Randevu_Kaynak_CagriMerkezi_Flag_012", 0) AS "Randevu_Kaynak_CagriMerkezi_Flag_012", 
	   COALESCE(HR."Randevu_Kaynak_CagriMerkezi_Flag_024", 0) AS "Randevu_Kaynak_CagriMerkezi_Flag_024", 
	   COALESCE(HR."Randevu_Kaynak_Whatsapp_Flag_03", 0) AS "Randevu_Kaynak_Whatsapp_Flag_03", 
	   COALESCE(HR."Randevu_Kaynak_Whatsapp_Flag_06", 0) AS "Randevu_Kaynak_Whatsapp_Flag_06",
	   COALESCE(HR."Randevu_Kaynak_Whatsapp_Flag_012", 0) AS "Randevu_Kaynak_Whatsapp_Flag_012", 
	   COALESCE(HR."Randevu_Kaynak_Whatsapp_Flag_024", 0) AS "Randevu_Kaynak_Whatsapp_Flag_024", 
	   coalesce(MH."Hizmet_03", 0) AS "MisafirHekim_03", 
	   coalesce(MH."Hizmet_06", 0) AS "MisafirHekim_06", 
	   coalesce(MH."Hizmet_012", 0) AS "MisafirHekim_012", 
	   coalesce(MH."Hizmet_13_24", 0) AS "MisafirHekim_013_024", 
	   coalesce(MH."Hizmet_024", 0) AS "MisafirHekim_024", 
	   MH."MisafirDoktorId" AS "MisafirDoktorId", 
	   MH."MisafirDoktorAdi" AS "MisafirDoktorAdi", 
	   COALESCE(HK."Kurum_Tip_OSS_03", 0) AS "Kurum_Tip_OSS_03", 
	   COALESCE(HK."Kurum_Tip_OSS_06", 0) AS "Kurum_Tip_OSS_06", 
	   COALESCE(HK."Kurum_Tip_OSS_012", 0) AS "Kurum_Tip_OSS_012",
	   COALESCE(HK."Kurum_Tip_OSS_013_024", 0) AS "Kurum_Tip_OSS_013_024",
	   COALESCE(HK."Kurum_Tip_OSS_024", 0) AS "Kurum_Tip_OSS_024", 
	   COALESCE(HK."Kurum_Tip_OSS_Ever", 0) AS "Kurum_Tip_OSS_Ever", 
	   COALESCE(HK."Kurum_Tip_AKK_03", 0) AS "Kurum_Tip_AKK_03",
	   COALESCE(HK."Kurum_Tip_AKK_06", 0) AS "Kurum_Tip_AKK_06", 
	   COALESCE(HK."Kurum_Tip_AKK_012", 0) AS "Kurum_Tip_AKK_012", 
	   COALESCE(HK."Kurum_Tip_AKK_013_024", 0) AS "Kurum_Tip_AKK_013_024", 
	   COALESCE(HK."Kurum_Tip_AKK_024", 0) AS "Kurum_Tip_AKK_024", 
	   COALESCE(HK."Kurum_Tip_AKK_Ever", 0) AS "Kurum_Tip_AKK_Ever", 
	   COALESCE(HK."Kurum_Tip_Ucretli_03", 0) AS "Kurum_Tip_Ucretli_03", 
	   COALESCE(HK."Kurum_Tip_Ucretli_06", 0) AS "Kurum_Tip_Ucretli_06", 
	   COALESCE(HK."Kurum_Tip_Ucretli_012", 0) AS "Kurum_Tip_Ucretli_012",
	   COALESCE(HK."Kurum_Tip_Ucretli_013_024", 0) AS "Kurum_Tip_Ucretli_013_024",
	   COALESCE(HK."Kurum_Tip_Ucretli_024", 0) AS "Kurum_Tip_Ucretli_024",
	   COALESCE(HK."Kurum_Tip_Ucretli_Ever", 0) AS "Kurum_Tip_Ucretli_Ever", 
	   COALESCE(HK."Kurum_Tip_SGK_03", 0) AS "Kurum_Tip_SGK_03", 
	   COALESCE(HK."Kurum_Tip_SGK_06", 0) AS "Kurum_Tip_SGK_06",
	   COALESCE(HK."Kurum_Tip_SGK_012", 0) AS "Kurum_Tip_SGK_012",
	   COALESCE(HK."Kurum_Tip_SGK_013_024", 0) AS "Kurum_Tip_SGK_013_024",
	   COALESCE(HK."Kurum_Tip_SGK_024", 0) AS "Kurum_Tip_SGK_024",
	   COALESCE(HK."Kurum_Tip_SGK_Ever", 0) AS "Kurum_Tip_SGK_Ever",
	   HK."SonKurumTipi" AS "SonKurumTipi",
	   HK."BaskinKurumTipi" AS "BaskinKurumTipi", 
	   HK."SonOSSKurumAdi" AS "SonOSSKurumAdi", 
	   HK."SonAKKKurumAdi" AS "SonAKKKurumAdi", 
	   COALESCE(HD."AktifPersonelFlag", 0) AS "AktifPersonelFlag", 
	   COALESCE(HT."Organ_Nakli_03", 0) AS "Organ_Nakli_03", 
	   COALESCE(HT."Organ_Nakli_06", 0) AS "Organ_Nakli_06", 
	   COALESCE(HT."Organ_Nakli_012", 0) AS "Organ_Nakli_012", 
	   COALESCE(HT."Organ_Nakli_024", 0) AS "Organ_Nakli_024", 
	   COALESCE(HT."Lazer_Flag_03", 0) AS "Lazer_Flag_03", 
	   COALESCE(HT."Lazer_Flag_06", 0) AS "Lazer_Flag_06", 
	   COALESCE(HT."Lazer_Flag_012", 0) AS "Lazer_Flag_012", 
	   COALESCE(HT."Lazer_Flag_024", 0) AS "Lazer_Flag_024", 
	   COALESCE(HT."Botox_Flag_03", 0) AS "Botox_Flag_03", 
	   COALESCE(HT."Botox_Flag_06", 0) AS "Botox_Flag_06", 
	   COALESCE(HT."Botox_Flag_012", 0) AS "Botox_Flag_012",
	   COALESCE(HT."Botox_Flag_024", 0) AS "Botox_Flag_024", 
	   COALESCE(HT."EvdeBakim_Flag_03", 0) AS "EvdeBakim_Flag_03",
	   COALESCE(HT."EvdeBakim_Flag_06", 0) AS "EvdeBakim_Flag_06",
	   COALESCE(HT."EvdeBakim_Flag_012", 0) AS "EvdeBakim_Flag_012",
	   COALESCE(HT."EvdeBakim_Flag_24", 0) AS "EvdeBakim_Flag_024",
	   COALESCE(HT."Onkoloji_Flag", 0) AS "Onkoloji_Flag",
	   COALESCE(HT."Pcr_Flag", 0) AS "PCRFlag", 
	   COALESCE(HD."VipFlag", 0) AS "VipFlag", 
	   cast (now() AS timestamp) AS "ETLDate" 
FROM "MEMOBI_DWH"."DIMHastaDetails" HD 
LEFT JOIN "MEMOBI_DWH"."DIMHastaFlag" HFA ON HFA."HastaMerkezId" = HD."HastaMerkezId" 
LEFT JOIN "MEMOBI_DWH"."DIMHastaFlag24" HF ON HF."HastaMerkezId" = HD."HastaMerkezId"  
LEFT JOIN "MEMOBI_DWH"."DIMHastaCiro" HC ON HC."HastaMerkezId" = HD."HastaMerkezId"  
LEFT JOIN "MEMOBI_DWH"."DIMHastaTedavi" HT ON HT."HastaMerkezId" = HD."HastaMerkezId"  
LEFT JOIN "MEMOBI_DWH"."DIMHastaSubeBolumDoktor" SBD ON SBD."HastaMerkezId" = HD."HastaMerkezId"  
LEFT JOIN "MEMOBI_DWH"."DIMHastaRandevu" HR ON HR."HastaMerkezId"=HD."HastaMerkezId"  
LEFT JOIN "MEMOBI_DWH"."DIMHastaKurum" HK ON HK."HastaMerkezId" = HD."HastaMerkezId"  
LEFT JOIN "MEMOBI_DWH"."DIMHastaMisafirHekim" MH ON MH."HastaMerkezId" = HD."HastaMerkezId" 
LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1=1

--HastaDetails
SELECT distinct "HastaMerkezId",
	   (SUBSTR("HastaTCKimlikNo", 1, CAST(2 AS INTEGER)) || '*******' || CASE WHEN LENGTH("HastaTCKimlikNo")<2 THEN "HastaTCKimlikNo" ELSE SUBSTR("HastaTCKimlikNo", (LENGTH("HastaTCKimlikNo") - CAST(2 AS INTEGER) + 1)) END) AS "HastaTCKimlikNo",
	   case when "CinsiyetAdi" is null then 'Cinsiyet Girilmemiş' else "CinsiyetAdi" end as "CinsiyetAdi", 
	   "DogumTarihi", "Yas",
	   case when length(TRIM("TCKN_Yeni")) > 11 then 0  
	   	    when cast(substring("TCKN_Yeni" FROM 1 FOR 1) as INT)= 0 then 0
	   	    when mod(((cast(substring("TCKN_Yeni" FROM 1 FOR 1) as INT) + 
							cast(substring("TCKN_Yeni" FROM 3 FOR 1) as INT)+ 
				 		    cast(substring("TCKN_Yeni" FROM 5 FOR 1) as INT)+
				   		    cast(substring("TCKN_Yeni" FROM 7 FOR 1) as INT)+
				   	        cast(substring("TCKN_Yeni" FROM 9 FOR 1) as INT))*7)-
							(cast(substring("TCKN_Yeni" FROM 2 FOR 1) as INT) + 
							cast(substring("TCKN_Yeni" FROM 4 FOR 1) as INT)+ 
				 		    cast(substring("TCKN_Yeni" FROM 6 FOR 1) as INT)+
				   		    cast(substring("TCKN_Yeni" FROM 8 FOR 1) as INT)
				   	        ),10) = cast(substring("TCKN_Yeni" FROM 10 FOR 1) as INT) 
   	        		and mod(cast(substring("TCKN_Yeni" FROM 1 FOR 1) as INT) +  
			   	        cast(substring("TCKN_Yeni" FROM 2 FOR 1) as INT) +
   	        			cast(substring("TCKN_Yeni" FROM 3 FOR 1) as INT) +
			   	        cast(substring("TCKN_Yeni" FROM 4 FOR 1) as INT) +
   	        			cast(substring("TCKN_Yeni" FROM 5 FOR 1) as INT) +
			   	        cast(substring("TCKN_Yeni" FROM 6 FOR 1) as INT) +
   	        			cast(substring("TCKN_Yeni" FROM 7 FOR 1) as INT) +
			   	        cast(substring("TCKN_Yeni" FROM 8 FOR 1) as INT) +
   	        			cast(substring("TCKN_Yeni" FROM 9 FOR 1) as INT) +
			   	        cast(substring("TCKN_Yeni" FROM 10 FOR 1) as INT),10) = cast(substring("TCKN_Yeni" FROM 11 FOR 1) as INT)  	then 1
	   else 0 end  as "TCKNDogrulama",
	   CASE WHEN "Yas"<6 THEN 'A_0-5' 
		    WHEN "Yas"<18 THEN 'B_6-17' 
		    WHEN "Yas"<30 THEN 'C_18-29'
			WHEN "Yas"<40 THEN 'D_30-39' 
			WHEN "Yas"<60 THEN 'E_40-59' 
			WHEN "Yas"<80 THEN 'F_60-79' 
	   ELSE 'G_80+' END AS "YasGrubu", 
	   CASE WHEN "Yas">77 THEN '1-Gelenekselci' 
			WHEN "Yas" BETWEEN 59 AND 77 THEN '2-Baby Boomer' 
			WHEN "Yas" BETWEEN 44 AND 58 THEN '3-X Kuşağı' 
			WHEN "Yas" BETWEEN 24 AND 43 THEN '4-Y Kuşağı' 
			WHEN "Yas" BETWEEN 0 AND 23 THEN '5-Z Kuşağı' END AS "Kusak", 
		"UlkeAdi", 
		"IlAdi", 
		"IlceAdi",
		"VipFlag",
		"AktifPersonelFlag", 
		cast(now() AS timestamp) AS "ETLDate" 
FROM (SELECT HC."HastaMerkezId", 
			 HC."HastaTCKimlikNo", 
			 dcinsiyet."CinsiyetAdi", 
			 HC."DogumTarihi", 
			 CASE WHEN date_part('year',age(h."DogumTarihi")) >100 OR date_part('year',age(HC."DogumTarihi")) is NULL THEN '40' 
			 	   ELSE DATE_PART('YEAR', T."OncekiAySonGun":: DATE) - DATE_PART('YEAR', HC."DogumTarihi" :: DATE) END AS "Yas", 
			 CASE WHEN DATE_PART('YEAR', T."OncekiAySonGun":: DATE) - DATE_PART('YEAR', HC."DogumTarihi" :: DATE)<6 THEN 'A_0-5' 
 				  WHEN DATE_PART('YEAR', T."OncekiAySonGun":: DATE) - DATE_PART('YEAR', HC."DogumTarihi" :: DATE)<18 THEN 'B_6-17' 
				  WHEN DATE_PART('YEAR', T."OncekiAySonGun":: DATE) - DATE_PART('YEAR', HC."DogumTarihi" :: DATE)<30 THEN 'C_18-29'
				  WHEN DATE_PART('YEAR', T."OncekiAySonGun":: DATE) - DATE_PART('YEAR', HC."DogumTarihi" :: DATE)<40 THEN 'D_30-39' 
				  WHEN DATE_PART('YEAR', T."OncekiAySonGun":: DATE) - DATE_PART('YEAR', HC."DogumTarihi" :: DATE)<60 THEN 'E_40-59' 
				  WHEN DATE_PART('YEAR', T."OncekiAySonGun":: DATE) - DATE_PART('YEAR', HC."DogumTarihi" :: DATE)<80 THEN 'F_60-79' 
			 ELSE 'G_80+' END AS "YasGrubu", 
			 CASE WHEN DATE_PART('YEAR', T."OncekiAySonGun":: DATE) - DATE_PART('YEAR', HC."DogumTarihi" :: DATE)>77 THEN '1-Gelenekselci' 
				  WHEN DATE_PART('YEAR', T."OncekiAySonGun":: DATE) - DATE_PART('YEAR', HC."DogumTarihi" :: DATE) BETWEEN 59 AND 77 THEN '2-Baby Boomer' 
				  WHEN DATE_PART('YEAR', T."OncekiAySonGun":: DATE) - DATE_PART('YEAR', HC."DogumTarihi" :: DATE) BETWEEN 44 AND 58 THEN '3-X Kuşağı' 
				  WHEN DATE_PART('YEAR', T."OncekiAySonGun":: DATE) - DATE_PART('YEAR', HC."DogumTarihi" :: DATE) BETWEEN 24 AND 43 THEN '4-Y Kuşağı' 
				  WHEN DATE_PART('YEAR', T."OncekiAySonGun":: DATE) - DATE_PART('YEAR', HC."DogumTarihi" :: DATE)BETWEEN 0 AND 23 THEN '5-Z Kuşağı' END AS "Kusak", 
			 CASE WHEN DUlke."UlkeAdi" = 'Tanimsiz' AND h."UyrukId" = 1 THEN 'Türkiye' 
			      WHEN DUlke."UlkeAdi" = 'Tanimsiz' AND h."UyrukId" <> 1 THEN 'Tanimsiz' 
			ELSE DUlke."UlkeAdi" END AS "UlkeAdi", 
			DIL."IlAdi", 
			DILCE."IlceAdi", 
			CASE WHEN HC."HastaTipiId" =2 THEN 1 ELSE 0 END AS "VipFlag", 
			CASE WHEN IKP."TCKimlikNo" is NOT NULL THEN 1 ELSE 0 END AS "AktifPersonelFlag",
			LPAD(regexp_replace(replace(replace(TRIM(HC."HastaTCKimlikNo"),'-',''),'','98'), '[[:alpha:]]','0','g')::varchar,11,'98') as "TCKN_Yeni"
		FROM "MEMOBI_DWH"."DIMHasta" h
		LEFT JOIN "MEMOBI_DWH"."DIMHastaCurrent" HC on HC."HastaTCKimlikNo" = h."HastaTCKimlikNo"
		LEFT JOIN "MEMOBI_DWH"."DIMCinsiyet" DCinsiyet ON DCinsiyet."CinsiyetId" =h."CinsiyetId" 
		LEFT JOIN "MEMOBI_DWH"."DIMUlke" DUlke ON DUlke."UlkeId" =h."UlkeId" 
		LEFT JOIN "MEMOBI_DWH"."DIMIl" DIL ON DIL."IlId" =h."IlIdEv" 
		LEFT JOIN "MEMOBI_DWH"."DIMIlce" DILCE ON DILce."IlceId" =h."IlceIdEv" 
		LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T on 1 = 1 
		LEFT JOIN "MEMOBI_ODS_MRKZ"."IK_Personel" IKP ON IKP."TCKimlikNo" = h."HastaTCKimlikNo" AND IKP."State" =1 AND IKP."CikisTarihi" IS null AND IKP."Id">4 
		WHERE h."IsCurrent" =1 
			  AND h."HastaTCKimlikNo" is NOT null 
		)y
--HastaProtokol
SELECT x."HastaMerkezId", 
	   x."ProtokolId", 
	   cast(x."IslemTarihi" AS date) AS "IslemTarihi", 
	   cast(x."AcilisTarihi" AS date) AS "AcilisTarihi", 
	   x."SubeId",
	   x."BolumId", 
	   DBolum2."BolumAdi", 
	   x."UygulayanPersonelId", 
	   x."FormTip", 
	   max(x."Lab_Rad_Haric_Flag") AS "Lab_Rad_Haric_Flag", 
	   max(x."Laboratuvar_Flag") AS "Laboratuvar_Flag", 
	   max(x."Radyoloji_Flag") AS "Radyoloji_Flag",
	   x."KaynakSys" as "KaynakSys", 
	   cast(now() AS timestamp) AS "ETLDate" 
FROM(SELECT distinct HC."HastaMerkezId", 
			FP."ProtokolId", 
			FP."IslemTarihi" AS "IslemTarihi", 
			FP."ProtokolAcilisTarihi" AS "AcilisTarihi", 
			FP."SubeId", 
			coalesce (case WHEN oh."HizmetTipiId" = 2 THEN 762 
						   WHEN oh."HizmetTipiId" = 3 THEN 625 
						   WHEN oh."HizmetTipiId" = 21 THEN 621 
					  ELSE FP."UygulayanBolumId" end,FP."BolumId") AS "BolumId", 
			FP."UygulayanPersonelId", 
			CASE WHEN FP."GelisTipiId" = 'Y' THEN 'Yatan' 
				 WHEN FP."GelisTipiId" = 'A' AND DBolum."BolumAdi" NOT LIKE '%Acil%' THEN 'Ayaktan' 
				 WHEN FP."GelisTipiId" = 'A' AND DBolum."BolumAdi" LIKE '%Acil%' THEN 'Acil' END AS "FormTip", 
			CASE WHEN oh."HizmetTipiId" <> 2 AND oh."HizmetTipiId" <> 3 THEN 1 ELSE 0 END AS "Lab_Rad_Haric_Flag", 
			CASE WHEN oh."HizmetTipiId" = 2 THEN 1 ELSE 0 END AS "Laboratuvar_Flag", 
			CASE WHEN oh."HizmetTipiId" = 3 THEN 1 ELSE 0 END AS "Radyoloji_Flag", 
			FP."KaynakSys" 
	FROM "FCTProtokol" FP 
	left join "MEMOBI_DWH"."DIMHasta" h on h."HastaId" = FP."HastaId"
	LEFT JOIN "MEMOBI_DWH"."DIMHastaCurrent" HC on HC."HastaTCKimlikNo" = h."HastaTCKimlikNo"
	LEFT JOIN "MEMOBI_DWH"."DIMBolum" DBolum ON DBolum."BolumId" = FP."UygulayanBolumId" 
	LEFT JOIN "MEMOBI_ODS_MRKZ"."Ortak_Hizmet" OH ON OH."Id" = FP."HizmetId" 
	LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1=1 
	WHERE cast (fp."IslemTarihi" AS date) <= T."OncekiAySonGun"

	) x 
LEFT JOIN "MEMOBI_DWH"."DIMBolum" DBolum2 ON DBolum2."BolumId" = x."BolumId" 
GROUP BY x."HastaMerkezId", x."ProtokolId", cast(x."IslemTarihi" AS date), cast(x."AcilisTarihi" AS date),x."SubeId",x."FormTip",x."BolumId",DBolum2."BolumAdi",x."UygulayanPersonelId", x."KaynakSys"
--HastaProtokol24
select "HastaMerkezId", 
	   "ProtokolId", 
	   "IslemTarihi", 
	   "AcilisTarihi", 
	   "SubeId", 
	   "BolumId", 
	   "BolumAdi", 
	   "UygulayanPersonelId", 
	   "FormTip", 
	   "Lab_Rad_Haric_Flag", 
	   "Laboratuvar_Flag", 
	   "Radyoloji_Flag", 
	   "KaynakSys", 
	   "ETLDate" 
from "MEMOBI_DWH"."DIMHastaProtokol" fp 
LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1=1 
WHERE cast(fp."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun"and T."OncekiAySonGun"
--HastaMisafirHekim
select "HastaMerkezId",
	    MAX("Hizmet_03") as "Hizmet_03",
		MAX("Hizmet_06") as "Hizmet_06",
		MAX("Hizmet_012") as "Hizmet_012",
		MAX("Hizmet_13_24") as "Hizmet_13_24",
		MAX("Hizmet_024") "Hizmet_024" ,
		max("MisafirDoktorId") as "MisafirDoktorId",
		max("MisafirDoktorAdi") as "MisafirDoktorAdi", 
		CURRENT_DATE as "ETLDate" 
from(select "HastaMerkezId", 
		     MAX(case WHEN "Min_Tarih" between T."UcAyOnceIlkGun" and T."UcAyOnceSonGun" then 1 else 0 END) as "Hizmet_03", 
			 MAX(case WHEN "Min_Tarih" between T."AltiAyOnceIlkGun" and T."AltiAyOnceSonGun" then 1 else 0 END ) as "Hizmet_06", 
			 MAX(case WHEN "Min_Tarih" between T."OnIkiAyOnceIlkGun" and T."OnIkiAyOnceSonGun" then 1 else 0 END ) as "Hizmet_012", 
			 MAX(case WHEN "Min_Tarih" between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 END ) as "Hizmet_13_24", 
			 MAX(case WHEN "Min_Tarih" between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "Hizmet_024", 
			 0 as "MisafirDoktorId", 
			 '' as "MisafirDoktorAdi" 
	FROM( select hp."HastaMerkezId" as "HastaMerkezId", 
		         MIN(cast(HP."IslemTarihi" as DATE)) as "Min_Tarih" 
		 from "MEMOBI_DWH"."DIMHastaProtokol" HP 
		 where HP."BolumAdi" like '%Misafir%' 
		 group by hp."HastaMerkezId",HP."UygulayanPersonelId" 
		 )X 
         LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T on 1=1 
		 group by "HastaMerkezId" 
		 union ALL 
		 select "HastaMerkezId", 
				 0 as "Hizmet_03", 
				 0 as "Hizmet_06", 
				 0 as "Hizmet_012", 
				 0 as "Hizmet_13_24", 
				 0 as "Hizmet_0240", 
				 z."DoktorId" as "MisafirDoktorId", 
				 IKP."Adi"||' '||IKP."Soyadi" as "MisafirDoktorAdi" 
		from( select * 
			  from(select "HastaMerkezId", 
						   "DoktorId", 
						   ROW_NUMBER() OVER(PARTITION BY "HastaMerkezId" ORDER BY "Sayi" DESC) "Sira" 
					from (select HP."HastaMerkezId", 
								 HP."UygulayanPersonelId" as "DoktorId", 
								 COUNT(1) as "Sayi" 
						  from "MEMOBI_DWH"."DIMHastaProtokol" HP 
						  LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T on 1=1 
						  where HP."BolumAdi" like '%Misafir%' 
								AND cast(HP."IslemTarihi" as DATE) BETWEEN T."YirmiDortAyOnceIlkGun" AND T."OncekiAySonGun" 
						  group by HP."HastaMerkezId",HP."UygulayanPersonelId" 
						  )x 
				  )y 
			where "Sira" = 1 
			)z 
			LEFT JOIN "MEMOBI_ODS_MRKZ"."IK_Personel" IKP on IKP."Id" = z."DoktorId" 
			)mh 
group by mh."HastaMerkezId" 
--HastaFlag
select HC."HastaMerkezId", 
	   max(CASE WHEN FP."SubeId"=7 THEN 1 ELSE 0 end) AS "Sisli_Flag", 
	   max(CASE WHEN FP."SubeId"=23 THEN 1 ELSE 0 end) AS "Atasehir_Flag", 
	   max(CASE WHEN FP."SubeId"=24 THEN 1 ELSE 0 end) AS "Antalya_Flag", 
	   max( CASE WHEN FP."SubeId"=31 THEN 1 ELSE 0 end) AS "Hizmet_Flag", 
	   max(CASE WHEN FP."SubeId"=37 THEN 1 ELSE 0 end) AS "Diyarbakir_Flag", 
	   max(CASE WHEN FP."SubeId"=79 THEN 1 ELSE 0 end) AS "MedStarAntalya_Flag", 
	   max(CASE WHEN FP."SubeId"=80 THEN 1 ELSE 0 end) AS "Topcular_Flag", 
	   max(CASE WHEN FP."SubeId"=95 THEN 1 ELSE 0 end) AS "Kayseri_Flag",
	   max(CASE WHEN FP."SubeId"=105 THEN 1 ELSE 0 end) AS "Ankara_Flag", 
	   max(CASE WHEN FP."SubeId"=116 THEN 1 ELSE 0 END) AS "Dicle_Flag", 
	   max(CASE WHEN FP."SubeId"=158 THEN 1 ELSE 0 end) AS "Bahcelievler_Flag", 
	   max(case when FP."GelisTipiId" = 'A' then 1 else 0 end) as "Ayaktan_Flag", 
	   max(case when FP."GelisTipiId" = 'Y' then 1 else 0 end) as "Yatan_Flag", 
	   max(case when DBolum."BolumAdi" LIKE '%Acil%' then 1 else 0 end) as "Acil_Flag", 
	   max(case when DBolum."BolumAdi" LIKE '%Lab%' then 1 else 0 end) as "Lab_Flag", 
	   max(case when DBolum."BolumAdi" LIKE '%Radyoloji%' then 1 else 0 end) as "Rad_Flag", 
	   min(case when FP."SubeId" in(7,23,88,103,105,136,147,158,44,52,62,155,159,176,228,2,36) then 1 when FP."SubeId" in (24,31,95) then 2 when FP."SubeId" in (37,79,80,116) then 23 end) as "SubeSegment", 
	   cast (now() AS timestamp) AS "ETLDate" 
from "FCTProtokol" FP 
left join "MEMOBI_DWH"."DIMHasta" h on h."HastaId" = FP."HastaId"
LEFT JOIN "MEMOBI_DWH"."DIMHastaCurrent" HC on HC."HastaTCKimlikNo" = h."HastaTCKimlikNo"
left join "MEMOBI_DWH"."DIMBolum" DBolum ON DBolum."BolumId" = FP."UygulayanBolumId"
--LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T on 1 = 1  
--where cast (fp."IslemTarihi" as date) <= T."OncekiAySonGun" 
group by FP."HastaMerkezId"
--HastaFlag24
SELECT distinct hc."HastaMerkezId", 
	   MAX(FP."IslemTarihi") AS "Max_ProtokolIslemTarih_024", 
	   MIN(FP."IslemTarihi") AS "Min_ProtokolIslemTarih_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Lab%' and cast(fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end) as "Lab_Flag_03", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Lab%' and cast(fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Lab_Flag_06", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Lab%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Lab_Flag_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Lab%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Lab_Flag_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Radyoloji%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Rad_Flag_03", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Radyoloji%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Rad_Flag_06", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Radyoloji%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Rad_Flag_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Radyoloji%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Rad_Flag_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Acil%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Acil_Flag_03", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Acil%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Acil_Flag_06", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Acil%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Acil_Flag_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Acil%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Acil_Flag_024", 
	   MAX( case WHEN FP."FormTip" = 'Ayaktan' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Ayaktan_Flag_03", 
	   MAX( case WHEN FP."FormTip" = 'Ayaktan' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Ayaktan_Flag_06", 
	   MAX( case WHEN FP."FormTip" = 'Ayaktan' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Ayaktan_Flag_012", 
	   MAX( case WHEN FP."FormTip" = 'Ayaktan' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Ayaktan_Flag_024", 
	   MAX( case WHEN FP."FormTip" = 'Yatan' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Yatan_Flag_03", 
	   MAX( case WHEN FP."FormTip" = 'Yatan' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Yatan_Flag_06", 
	   MAX( case WHEN FP."FormTip" = 'Yatan' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Yatan_Flag_012", 
	   MAX( case WHEN FP."FormTip" = 'Yatan' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Yatan_Flag_024", 
	   MAX( case WHEN FP."SubeId" = 7 and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "Sisli_Flag_03", 
	   MAX( case WHEN FP."SubeId" = 7 and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Sisli_Flag_06", 
	   MAX( case WHEN FP."SubeId" = 7 and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Sisli_Flag_012",
	   MAX( case WHEN FP."SubeId" = 7 and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Sisli_Flag_024", 
	   MAX( case WHEN FP."SubeId" = 23 and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "Atasehir_Flag_03", 
	   MAX( case WHEN FP."SubeId" = 23 and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Atasehir_Flag_06", 
	   MAX( case WHEN FP."SubeId" = 23 and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Atasehir_Flag_012", 
	   MAX( case WHEN FP."SubeId" = 23 and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Atasehir_Flag_024", 
	   MAX( case WHEN FP."SubeId" = 24 and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "Antalya_Flag_03", 
	   MAX( case WHEN FP."SubeId" = 24 and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Antalya_Flag_06", 
	   MAX( case WHEN FP."SubeId" = 24 and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Antalya_Flag_012", 
	   MAX( case WHEN FP."SubeId" = 24 and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Antalya_Flag_024", 
	   MAX( case WHEN FP."SubeId" = 31 and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "Hizmet_Flag_03", 
	   MAX( case WHEN FP."SubeId" = 31 and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Flag_06", 
	   MAX( case WHEN FP."SubeId" = 31 and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Flag_012", 
	   MAX( case WHEN FP."SubeId" = 31 and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Flag_024", 
	   MAX( case WHEN FP."SubeId" = 37 and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "Diyarbakir_Flag_03", 
	   MAX( case WHEN FP."SubeId" = 37 and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Diyarbakir_Flag_06", 
	   MAX( case WHEN FP."SubeId" = 37 and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Diyarbakir_Flag_012", 
	   MAX( case WHEN FP."SubeId" = 37 and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Diyarbakir_Flag_024", 
	   MAX( case WHEN FP."SubeId" = 79 and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "MedStarAntalya_Flag_03", 
	   MAX( case WHEN FP."SubeId" = 79 and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "MedStarAntalya_Flag_06", 
	   MAX( case WHEN FP."SubeId" = 79 and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "MedStarAntalya_Flag_012", 
	   MAX( case WHEN FP."SubeId" = 79 and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "MedStarAntalya_Flag_024", 
	   MAX( case WHEN FP."SubeId" = 80 and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "Topcular_Flag_03", 
	   MAX( case WHEN FP."SubeId" = 80 and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Topcular_Flag_06", 
	   MAX( case WHEN FP."SubeId" = 80 and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Topcular_Flag_012", 
	   MAX( case WHEN FP."SubeId" = 80 and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Topcular_Flag_024", 
	   MAX( case WHEN FP."SubeId" = 95 and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "Kayseri_Flag_03", 
	   MAX( case WHEN FP."SubeId" = 95 and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Kayseri_Flag_06", 
	   MAX( case WHEN FP."SubeId" = 95 and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Kayseri_Flag_012", 
	   MAX( case WHEN FP."SubeId" = 95 and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Kayseri_Flag_024", 
	   MAX( case WHEN FP."SubeId" = 105 and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "Ankara_Flag_03", 
	   MAX( case WHEN FP."SubeId" = 105 and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Ankara_Flag_06", 
	   MAX( case WHEN FP."SubeId" = 105 and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Ankara_Flag_012", 
	   MAX( case WHEN FP."SubeId" = 105 and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Ankara_Flag_024", 
	   MAX( case WHEN FP."SubeId" = 116 and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "Dicle_Flag_03", 
	   MAX( case WHEN FP."SubeId" = 116 and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Dicle_Flag_06", 
	   MAX( case WHEN FP."SubeId" = 116 and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Dicle_Flag_012", 
	   MAX( case WHEN FP."SubeId" = 116 and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Dicle_Flag_024", 
	   MAX( case WHEN FP."SubeId" = 158 and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "Bahcelievler_Flag_03", 
	   MAX( case WHEN FP."SubeId" = 158 and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Bahcelievler_Flag_06", 
	   MAX( case WHEN FP."SubeId" = 158 and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Bahcelievler_Flag_012", 
	   MAX( case WHEN FP."SubeId" = 158 and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Bahcelievler_Flag_024", 
	   COUNT( DISTINCT case WHEN cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" THEN FP."ProtokolId" END ) AS "Adet_03", 
	   COUNT( DISTINCT case WHEN cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" THEN FP."ProtokolId" END ) AS "Adet_06", 
	   COUNT( DISTINCT case WHEN cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" THEN FP."ProtokolId" END ) AS "Adet_012", 
	   COUNT( DISTINCT case WHEN cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" THEN FP."ProtokolId" END ) AS "Adet_024", 
	   COUNT( DISTINCT DATE_PART('YEAR', FP."IslemTarihi" :: date) || '_' || DATE_PART('MONTH', FP."IslemTarihi" :: date) ) AS "Adet_Ay", 
	   COUNT( DISTINCT case WHEN cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" THEN DATE_PART('YEAR', FP."IslemTarihi" :: date) || '_' || DATE_PART('MONTH', FP."IslemTarihi" :: date) END ) AS "Adet_Ay_03", 
	   COUNT( DISTINCT case WHEN cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" THEN DATE_PART('YEAR', FP."IslemTarihi" :: date) || '_' || DATE_PART('MONTH', FP."IslemTarihi" :: date) END ) AS "Adet_Ay_06", 
	   COUNT( DISTINCT case WHEN cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" THEN DATE_PART('YEAR', FP."IslemTarihi" :: date) || '_' || DATE_PART('MONTH', FP."IslemTarihi" :: date) END ) AS "Adet_Ay_012", 
	   COUNT( DISTINCT case WHEN cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" THEN DATE_PART('YEAR', FP."IslemTarihi" :: date) || '_' || DATE_PART('MONTH', FP."IslemTarihi" :: date) END ) AS "Adet_Ay_024", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."OncekiAyIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "Hizmet_01", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."IkiAyOnceIlkGun" and T."IkiAyOnceSonGun" then 1 else 0 END ) as "Hizmet_02", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."UcAyOnceSonGun" then 1 else 0 END ) as "Hizmet_03", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."DortAyOnceIlkGun" and T."DortAyOnceSonGun" then 1 else 0 END ) as "Hizmet_04", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."BesAyOnceIlkGun" and T."BesAyOnceSonGun" then 1 else 0 END ) as "Hizmet_05", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."AltiAyOnceSonGun" then 1 else 0 END ) as "Hizmet_06", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."YediAyOnceIlkGun" and T."YediAyOnceSonGun" then 1 else 0 END ) as "Hizmet_07", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."SekizAyOnceIlkGun" and T."SekizAyOnceSonGun" then 1 else 0 END ) as "Hizmet_08", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."DokuzAyOnceIlkGun" and T."DokuzAyOnceSonGun" then 1 else 0 END ) as "Hizmet_09", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."OnAyOnceIlkGun" and T."OnAyOnceSonGun" then 1 else 0 END ) as "Hizmet_010", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."OnBirAyOnceIlkGun" and T."OnBirAyOnceSonGun" then 1 else 0 END ) as "Hizmet_011", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OnIkiAyOnceSonGun" then 1 else 0 END ) as "Hizmet_012", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "Hizmet_12", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 END ) as "Hizmet_13_24", 
	   MAX( case WHEN cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 END ) as "Hizmet_24", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Dahiliye%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Dahiliye_03", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Dahiliye%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Dahiliye_06", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Dahiliye%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Dahiliye_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Dahiliye%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 end ) as "Hizmet_Dahiliye_013_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Dahiliye%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Dahiliye_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Dermatolo%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Dermatoloji_03", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Dermatolo%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Dermatoloji_06", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Dermatolo%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Dermatoloji_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Dermatolo%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 end ) as "Hizmet_Dermatoloji_013_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Dermatolo%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Dermatoloji_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Endokrinoloji%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Endokrinoloji_03", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Endokrinoloji%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Endokrinoloji_06", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Endokrinoloji%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Endokrinoloji_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Endokrinoloji%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 end ) as "Hizmet_Endokrinoloji_013_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Endokrinoloji%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Endokrinoloji_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Gastro%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Gastroentoroloji_03", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Gastro%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Gastroentoroloji_06", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Gastro%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Gastroentoroloji_012",
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Gastro%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 end ) as "Hizmet_Gastroentoroloji_013_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Gastro%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Gastroentoroloji_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Genel C%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_GenelCerrahi_03", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Genel C%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_GenelCerrahi_06",
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Genel C%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_GenelCerrahi_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Genel C%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 end ) as "Hizmet_GenelCerrahi_013_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Genel C%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_GenelCerrahi_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Göğüs H%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_GogusHastaliklari_03", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Göğüs H%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_GogusHastaliklari_06", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Göğüs H%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_GogusHastaliklari_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Göğüs H%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 end ) as "Hizmet_GogusHastaliklari_013_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Göğüs H%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_GogusHastaliklari_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Göz%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Goz_03", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Göz%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Goz_06", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Göz%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Goz_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Göz%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 end ) as "Hizmet_Goz_013_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Göz%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Goz_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Kardiyoloji%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Kardiyoloji_03", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Kardiyoloji%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Kardiyoloji_06", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Kardiyoloji%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Kardiyoloji_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Kardiyoloji%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 end ) as "Hizmet_Kardiyoloji_013_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Kardiyoloji%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Kardiyoloji_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%KBB%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_KBB_03",
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%KBB%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_KBB_06", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%KBB%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_KBB_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%KBB%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 end ) as "Hizmet_KBB_013_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%KBB%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_KBB_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Nöroloji%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Noroloji_03",
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Nöroloji%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Noroloji_06", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Nöroloji%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Noroloji_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Nöroloji%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 end ) as "Hizmet_Noroloji_013_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Nöroloji%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Noroloji_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Nöroşirür%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Norosijurji_03", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Nöroşirür%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Norosijurji_06",
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Nöroşirür%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Norosijurji_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Nöroşirür%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 end ) as "Hizmet_Norosijurji_013_024",
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Nöroşirür%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Norosijurji_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Ortopedi%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Ortopedi_03", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Ortopedi%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Ortopedi_06", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Ortopedi%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Ortopedi_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Ortopedi%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 end ) as "Hizmet_Ortopedi_013_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Ortopedi%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Ortopedi_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Üroloji%' and cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Uroloji_03", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Üroloji%' and cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Uroloji_06", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Üroloji%' and cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Uroloji_012", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Üroloji%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OnUcAyOnceSonGun" then 1 else 0 end ) as "Hizmet_Uroloji_013_024", 
	   MAX( case WHEN DBolum."BolumAdi" LIKE '%Üroloji%' and cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then 1 else 0 end ) as "Hizmet_Uroloji_024", 
	   COUNT(distinct DBolum."BolumId") as "Farkli_BolumAdet", COUNT( distinct case WHEN cast (fp."IslemTarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" then DBolum."BolumId" end ) as "Farkli_BolumAdet_03", 
	   COUNT( distinct case WHEN cast (fp."IslemTarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" then DBolum."BolumId" end ) as "Farkli_BolumAdet_06", 
	   COUNT( distinct case WHEN cast (fp."IslemTarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" then DBolum."BolumId" end ) as "Farkli_BolumAdet_012", 
	   COUNT( distinct case WHEN cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" then DBolum."BolumId" end ) as "Farkli_BolumAdet_24", 
	   cast (now() AS timestamp) AS "ETLDate" 
FROM "DIMHastaProtokol" FP 
left JOIN "MEMOBI_DWH"."DIMBolum" DBolum ON DBolum."BolumId" = FP."BolumId"
left join "MEMOBI_DWH"."DIMHasta" h on h."HastaId" = FP."HastaId"
LEFT JOIN "MEMOBI_DWH"."DIMHastaCurrent" HC on HC."HastaTCKimlikNo" = h."HastaTCKimlikNo" 
LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T on 1 = 1 
where cast (fp."IslemTarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" 
GROUP BY FP."HastaMerkezId" 
--HastaCiro
SELECT "HastaMerkezId", 
	   SUM("Total_Ciro_Kdvli_USD") AS "Total_Ciro_Kdvli_Usd", 
	   SUM("Total_Ciro_Kdvli_USD_03") AS "Total_Ciro_Kdvli_USD_03", 
	   SUM("Total_Ciro_Kdvli_USD_06") AS "Total_Ciro_Kdvli_USD_06", 
	   SUM("Total_Ciro_Kdvli_USD_012") AS "Total_Ciro_Kdvli_USD_012", 
	   SUM("Total_Ciro_Kdvli_USD_024") AS "Total_Ciro_Kdvli_USD_024", 
	   SUM("Total_Ciro_Kdvli_USD_03_Ayaktan") AS "Total_Ciro_Kdvli_USD_03_Ayaktan", 
	   SUM("Total_Ciro_Kdvli_USD_03_Yatan") AS "Total_Ciro_Kdvli_USD_03_Yatan", 
	   SUM("Total_Ciro_Kdvli_USD_06_Ayaktan") AS "Total_Ciro_Kdvli_USD_06_Ayaktan", 
	   SUM("Total_Ciro_Kdvli_USD_06_Yatan") AS "Total_Ciro_Kdvli_USD_06_Yatan", 
	   SUM("Total_Ciro_Kdvli_USD_012_Ayaktan") AS "Total_Ciro_Kdvli_USD_012_Ayaktan", 
	   SUM("Total_Ciro_Kdvli_USD_012_Yatan") AS "Total_Ciro_Kdvli_USD_012_Yatan", 
	   SUM("Total_Ciro_Kdvli_USD_024_Ayaktan") AS "Total_Ciro_Kdvli_USD_024_Ayaktan", 
	   SUM("Total_Ciro_Kdvli_USD_024_Yatan") AS "Total_Ciro_Kdvli_USD_024_Yatan", 
	   SUM("Total_Ciro_Kdvli_USD_Ayaktan") AS "Total_Ciro_Kdvli_USD_Ayaktan", 
	   SUM("Total_Ciro_Kdvli_USD_Yatan") AS "Total_Ciro_Kdvli_USD_Yatan", 
	   SUM("Total_Ciro_Kdvli_USD") AS "Total_Ciro_Kdvsiz_Usd", 
	   SUM("Total_Ciro_Kdvli_USD_03") AS "Total_Ciro_Kdvsiz_USD_03", 
	   SUM("Total_Ciro_Kdvli_USD_06") AS "Total_Ciro_Kdvsiz_USD_06", 
	   SUM("Total_Ciro_Kdvli_USD_012") AS "Total_Ciro_Kdvsiz_USD_012", 
	   SUM("Total_Ciro_Kdvli_USD_024") AS "Total_Ciro_Kdvsiz_USD_024", 
	   SUM("Total_Ciro_Kdvli_USD_03_Ayaktan") AS "Total_Ciro_Kdvsiz_USD_03_Ayaktan", 
	   SUM("Total_Ciro_Kdvli_USD_03_Yatan") AS "Total_Ciro_Kdvsiz_USD_03_Yatan", 
	   SUM("Total_Ciro_Kdvli_USD_06_Ayaktan") AS "Total_Ciro_Kdvsiz_USD_06_Ayaktan", 
	   SUM("Total_Ciro_Kdvli_USD_06_Yatan") AS "Total_Ciro_Kdvsiz_USD_06_Yatan", 
	   SUM("Total_Ciro_Kdvli_USD_012_Ayaktan") AS "Total_Ciro_Kdvsiz_USD_012_Ayaktan", 
	   SUM("Total_Ciro_Kdvli_USD_012_Yatan") AS "Total_Ciro_Kdvsiz_USD_012_Yatan", 
	   SUM("Total_Ciro_Kdvli_USD_024_Ayaktan") AS "Total_Ciro_Kdvsiz_USD_024_Ayaktan", 
	   SUM("Total_Ciro_Kdvli_USD_024_Yatan") AS "Total_Ciro_Kdvsiz_USD_024_Yatan", 
	   SUM("Total_Ciro_Kdvli_USD_Ayaktan") AS "Total_Ciro_Kdvsiz_USD_Ayaktan", 
	   SUM("Total_Ciro_Kdvli_USD_Yatan") AS "Total_Ciro_Kdvsiz_USD_Yatan", 
	   cast(now() AS timestamp) AS "ETLDate" 
	   FROM 
(SELECT distinct HC."HastaMerkezId", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) <=T."OncekiAySonGun" THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) <=T."OncekiAySonGun" THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) <=T."OncekiAySonGun" THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) <=T."OncekiAySonGun" THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD_03", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD_03",
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL_03", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL_03", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD_06", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD_06", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL_06", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL_06", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD_012", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD_012", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL_012", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL_012", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD_024", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD_024", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL_024", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T. "OncekiAySonGun" THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL_024", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD_03_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD_03_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL_03_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL_03_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD_03_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD_03_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL_03_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL_03_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD_06_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD_06_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL_06_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL_06_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD_06_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD_06_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL_06_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL_06_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD_012_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD_012_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL_012_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL_012_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD_012_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD_012_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL_012_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL_012_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD_024_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD_024_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL_024_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='A' THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL_024_Ayaktan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD_024_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD_024_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL_024_Yatan", 
		SUM(CASE WHEN cast(FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T. "OncekiAySonGun" AND FP."GelisTipiId"='Y' THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL_024_Yatan", 
		SUM(CASE WHEN FP."GelisTipiId"='A' THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD_Ayaktan", 
		SUM(CASE WHEN FP."GelisTipiId"='A' THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD_Ayaktan", 
		SUM(CASE WHEN FP."GelisTipiId"='A' THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL_Ayaktan", 
		SUM(CASE WHEN FP."GelisTipiId"='A' THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL_Ayaktan", 
		SUM(CASE WHEN FP."GelisTipiId"='Y' THEN "KdvliHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvli_USD_Yatan", 
		SUM(CASE WHEN FP."GelisTipiId"='Y' THEN "KdvsizHizmetTutari" ELSE 0 end) /GK."DovizAlis" AS "Total_Ciro_Kdvsiz_USD_Yatan", 
		SUM(CASE WHEN FP."GelisTipiId"='Y' THEN "KdvliHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvli_TL_Yatan", 
		SUM(CASE WHEN FP."GelisTipiId"='Y' THEN "KdvsizHizmetTutari" ELSE 0 end) AS "Total_Ciro_Kdvsiz_TL_Yatan" 
FROM "FCTProtokol" FP 
left join "MEMOBI_DWH"."DIMHasta" h on h."HastaId" = FP."HastaId"
LEFT JOIN "MEMOBI_DWH"."DIMHastaCurrent" HC on HC."HastaTCKimlikNo" = h."HastaTCKimlikNo"
LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1=1 
LEFT JOIN "MEMOBI_ODS_MRKZ"."Finans_GunlukKur" GK ON cast(GK."Tarih" AS Date)= cast(FP."IslemTarihi" AS date) AND GK."ParaBirimiId" = 2 
GROUP BY FP."HastaMerkezId",GK."DovizAlis") T1 GROUP BY "HastaMerkezId"
--HastaTedavi
SELECT distinct HC."HastaMerkezId", 
	   MIN(FP."IslemTarihi") AS "Min_IslemTarihi", 
	   MAX(FP."IslemTarihi") AS "Max_IslemTarihi", 
	   MAX(case WHEN OH."Kodu" in('INLMB0443', 'INLMB0544', 'GNTAR0782', 'GRBGH0024', 'GNGEN0552', 'GNTAR0781', 'GNTAR0779', 'GNTAR0769/4', 'INLMB0548', 'INLMB0443/2', 'INLMB0541', 'INLMB0540', 'INLMB0547', 'INLPN1850', 'GNTAR0791', 'INLMB0548/1', 'INLMB0444', 'GNTAR6197', 'INLPN1849', 'GNMCU0259') THEN 1 ELSE 0 END) AS "Pcr_Flag", 
	   MAX( CASE WHEN DBolum."BolumAdi" LIKE '%Trans%' AND cast(FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Organ_Nakli_03", 
	   MAX( CASE WHEN DBolum."BolumAdi" LIKE '%Trans%' AND cast(FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Organ_Nakli_06", 
	   MAX( CASE WHEN DBolum."BolumAdi" LIKE '%Trans%' AND cast (FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Organ_Nakli_012",
	   MAX( CASE WHEN DBolum."BolumAdi" LIKE '%Trans%' AND cast (FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Organ_Nakli_024", 
	   MAX( CASE WHEN OH."Kodu" LIKE 'GRBDK%' AND ( OH."Adi" LIKE '%lazer%' OR OH."Adi" LIKE '%Epilas%' ) AND cast (FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Lazer_Flag_03", 
	   MAX( CASE WHEN OH."Kodu" LIKE 'GRBDK%' AND ( OH."Adi" LIKE '%lazer%' OR OH."Adi" LIKE '%Epilas%' ) AND cast (FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Lazer_Flag_06", 
	   MAX( CASE WHEN OH."Kodu" LIKE 'GRBDK%' AND ( OH."Adi" LIKE '%lazer%' OR OH."Adi" LIKE '%Epilas%' ) AND cast (FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Lazer_Flag_012", 
	   MAX( CASE WHEN OH."Kodu" LIKE 'GRBDK%' AND ( OH."Adi" LIKE '%lazer%' OR OH."Adi" LIKE '%Epilas%' ) AND cast (FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Lazer_Flag_024", 
	   MAX( CASE WHEN OH."Kodu" LIKE 'GRBDK%' AND (OH."Adi" LIKE '%botox%') AND cast (FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Botox_Flag_03", 
	   MAX( CASE WHEN OH."Kodu" LIKE 'GRBDK%' AND (OH."Adi" LIKE '%botox%') AND cast (FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Botox_Flag_06", 
	   MAX( CASE WHEN OH."Kodu" LIKE 'GRBDK%' AND (OH."Adi" LIKE '%botox%') AND cast (FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Botox_Flag_012", 
	   MAX( CASE WHEN OH."Kodu" LIKE 'GRBDK%' AND (OH."Adi" LIKE '%botox%') AND cast (FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Botox_Flag_024", 
	   MAX( CASE WHEN ICD."Kodu" IN ( 'C34.9', 'C18.9', 'C26', 'C50.9', 'C53.9', 'C62.9', 'C02.9', 'C22', 'C25.9', 'C11.9', 'C16.9', 'C20', 'C22.9', 'C24.9', 'C45.0', 'C49.2', 'C50.9', 'C56', 'C61', 'C64', 'C65', 'C67.9', 'C71.9', 'C34.9' ) THEN 1 ELSE 0 END ) AS "Onkoloji_Flag", 
	   MAX( CASE WHEN OH."Adi" LIKE '%Evde%' AND cast (FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "EvdeBakim_Flag_03", 
	   MAX( CASE WHEN OH."Adi" LIKE '%Evde%' AND cast (FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "EvdeBakim_Flag_06",
	   MAX( CASE WHEN OH."Adi" LIKE '%Evde%' AND cast (FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "EvdeBakim_Flag_012", 
	   MAX( CASE WHEN OH."Adi" LIKE '%Evde%' AND cast (FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "EvdeBakim_Flag_24", 
	   MAX( CASE WHEN OH."HizmetTipiId" = 21 AND cast (FP."IslemTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Checkup_Flag_03", 
	   MAX( CASE WHEN OH."HizmetTipiId" = 21 AND cast (FP."IslemTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Checkup_Flag_06", 
	   MAX( CASE WHEN OH."HizmetTipiId" = 21 AND cast (FP."IslemTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Checkup_Flag_012", 
	   MAX( CASE WHEN OH."HizmetTipiId" = 21 AND cast (FP."IslemTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T."OncekiAySonGun" THEN 1 ELSE 0 END ) AS "Checkup_Flag_024", 
	   ( DATE_PART( 'YEAR', MAX(T."OncekiAySonGun"):: date ) - DATE_PART( 'YEAR', MAX(FP."IslemTarihi"):: date ) ) * 12 + DATE_PART( 'MONTH', MAX(T."OncekiAySonGun"):: date ) - DATE_PART( 'MONTH', MAX(FP."IslemTarihi"):: date ) + 1 AS "Recency_Month", 
	   ( DATE_PART( 'YEAR', MAX(T."OncekiAySonGun"):: date ) - DATE_PART( 'YEAR', MIN(FP."IslemTarihi"):: date ) ) * 12 + DATE_PART( 'MONTH', MAX(T."OncekiAySonGun"):: date ) - DATE_PART( 'MONTH', MIN(FP."IslemTarihi"):: date )+ 1 AS "Tenure_Month", 
	   count ( distinct CASE WHEN cast (FP."IslemTarihi" AS date) <= T."OncekiAySonGun" THEN FP."ProtokolId" END ) AS "Frekans", 
	   cast (now() AS timestamp) AS "ETLDate" 
FROM "FCTProtokol" FP
left join "MEMOBI_DWH"."DIMHasta" h on h."HastaId" = FP."HastaId"
LEFT JOIN "MEMOBI_DWH"."DIMHastaCurrent" HC on HC."HastaTCKimlikNo" = h."HastaTCKimlikNo" 
LEFT JOIN "MEMOBI_ODS_MRKZ"."Ortak_Hizmet" OH ON OH."Id" = FP."HizmetId" 
LEFT JOIN "MEMOBI_DWH"."DIMBolum" DBolum ON DBolum."BolumId" = FP."UygulayanBolumId" 
LEFT JOIN "MEMOBI_DM"."Tedavi_ProtokolICD" TID ON TID."ProtokolId" = FP."ProtokolId" AND TID."SubeId" = FP."SubeId" 
LEFT JOIN "MEMOBI_DM"."Tedavi_ICD" ICD ON ICD."Id" = TID."ICDId" 
LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1 = 1 
where cast (FP."IslemTarihi" AS date) <= T."OncekiAySonGun" 
GROUP BY FP."HastaMerkezId" 
--HastaSubeBolumDoktor
SELECT "HastaMerkezId", 
		max("SubeUstId24") AS "SubeUstId2Yil", 
		max("Lokasyon24") AS "Lokasyon2Yil", 
		max("DoktorId24") AS "DoktorId2Yil", 
		coalesce(MAX(IKP2Yil."Adi"||' '||IKP2Yil."Soyadi"),max("DoktorAdi24")) AS "DoktorAdi2Yil", 
		max("BolumAdi24") AS "BolumAdi2Yil", 
		max("SubeUstId") AS "EnCokSubeUstId", 
		max("Lokasyon") AS "EnCokLokasyon",
		max("DoktorId") AS "EnCokDoktorId", 
		coalesce(MAX(IKPEnCok."Adi"||' '||IKPEnCok."Soyadi"),max("DoktorAdi")) AS "EnCokDoktorAdi", 
		max("BolumAdi") AS "EnCokBolumAdi", 
		max("BolumId22") AS "EnCokBolumId", 
		max("EnSonSubeUstId") AS "EnSonSubeUstId", 
		max("EnSonLokasyon") AS "EnSonLokasyon", 
		max("EnSonDoktorId") AS "EnSonDoktorId", 
		coalesce(MAX(IKPEnSon."Adi"||' '||IKPEnSon."Soyadi"),max("EnSonDoktorAdi"))AS "EnSonDoktorAdi", 
		max("EnSonBolumAdi") AS "EnSonBolumAdi", 
		max("EnSonBolumId") AS "EnSonBolumId", 
		cast(now() AS timestamp) AS "ETLDate" 
from ( SELECT "HastaMerkezId", 
		      MAX("SubeUstId") AS "SubeUstId24", 
			  MAX(Lokasyon) AS "Lokasyon24", 
			  MAX("DoktorId") AS "DoktorId24", 
			  MAX("DoktorAdi") AS "DoktorAdi24", 
			  MAX("BolumAdi") AS "BolumAdi24", 
			  0 AS "SubeUstId", 
			  '' AS "Lokasyon", 
			  0 AS "DoktorId", 
			  '' AS "DoktorAdi", 
			  '' AS "BolumAdi", 
			  0 AS "BolumId22", 
			  0 AS "EnSonSubeUstId",
			  '' AS "EnSonLokasyon", 
			  0 AS "EnSonDoktorId", 
			  '' AS "EnSonDoktorAdi", 
			  '' AS "EnSonBolumAdi", 
			  0 AS "EnSonBolumId" 
		FROM ( SELECT C."HastaMerkezId", 
			          C."SubeUstId", 
					  C."SubeUstAdi" AS Lokasyon, 
					  0 AS "DoktorId", 
					  '' AS "DoktorAdi", 
					  '' AS "BolumAdi", 
					  0 AS "BolumId" 
				FROM ( SELECT B."HastaMerkezId" AS "HastaMerkezId", 
						      B."SubeId" AS "SubeUstId", 
							  SU."SubeUstAdi" AS "SubeUstAdi", 
							  ROW_NUMBER() OVER( PARTITION BY B."HastaMerkezId" ORDER BY B."SAY" DESC, "MAX_ISLEM_TAR" DESC) "SIRA" 
						FROM ( SELECT A."HastaMerkezId" AS "HastaMerkezId", 
								      A."SubeId" AS "SubeId", 
									  MAX("IslemTarihi") AS "MAX_ISLEM_TAR", 
									  COUNT(DISTINCT A."ProtokolId") AS "SAY" 
							    FROM ( SELECT HP."HastaMerkezId" AS "HastaMerkezId", 
											  HP."ProtokolId" AS "ProtokolId", 
											  HP."IslemTarihi" AS "IslemTarihi", 
											  HP."SubeId" AS "SubeId" 
									    FROM "DIMHastaProtokol24" HP 
										LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1 = 1 
										) A 
										GROUP BY A."HastaMerkezId", A."SubeId" 
							 ) B LEFT JOIN "MEMOBI_DWH"."DIMSube" S ON S."SubeUstId" = B."SubeId" JOIN "MEMOBI_DWH"."DIMSubeUst" SU ON SU."SubeUstId" = S."SubeUstId" 
					 ) C WHERE C."SIRA" = 1 
					 UNION all 
					    SELECT C."HastaMerkezId", 
							   0 AS "SubeUstId", 
							   '' AS "Lokasyon", 
							   C."DoktorId", 
							   C."DoktorAdi", 
							   '' AS "BolumAdi", 
							   0 AS "BolumId" 
						FROM ( SELECT B."HastaMerkezId" AS "HastaMerkezId", 
									  B."DoktorId" AS "DoktorId", 
									  IK."DoktorAdi" AS "DoktorAdi", 
									  ROW_NUMBER() OVER( PARTITION BY B."HastaMerkezId" ORDER BY B."SAY" DESC, "MAX_ISLEM_TAR" DESC ) "SIRA" 
								FROM ( SELECT A."HastaMerkezId" AS "HastaMerkezId", 
										      A."DoktorId" AS "DoktorId", 
											  MAX("IslemTarihi") AS "MAX_ISLEM_TAR", 
											  COUNT(DISTINCT A."ProtokolId") AS "SAY" 
										FROM ( SELECT HP."HastaMerkezId" AS "HastaMerkezId", 
													  HP."ProtokolId" AS "ProtokolId", 
													  HP."IslemTarihi" AS "IslemTarihi",
													  HP."UygulayanPersonelId" AS "DoktorId"
										       FROM "DIMHastaProtokol24" HP 
											   LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1 = 1 
											   WHERE 1 = 1 AND HP."BolumAdi" NOT IN ( 'Laboratuvar', 'Radyoloji', 'Anestezi' ) 
											         AND HP."UygulayanPersonelId" IS NOT NULL 
											  ) A 
											  GROUP BY A."HastaMerkezId", A."DoktorId" 
									 ) B 
									 LEFT JOIN "MEMOBI_DWH"."DM_XLS_Doktor" IK ON IK."MasterDoktorId" = B."DoktorId" 
							) C 
							WHERE 1 = 1 
								AND C."SIRA" = 1 
						UNION all 
						SELECT C."HastaMerkezId", 
							   0 AS "SubeUstId", 
							   '' AS "Lokasyon", 
							   0 AS "DoktorId", 
							   '' AS "DoktorAdi", 
							   C."BolumAdi" AS "Son2YılBaskınBolum", 
							   0 AS "BolumId" 
						FROM ( SELECT B."HastaMerkezId", 
								      B."BolumAdi", 
									  B."SIRA" 
								FROM ( SELECT X."HastaMerkezId", 
											  X."BolumAdi", 
											  MAX(X."MAX_ISLEM_TAR") AS "MAX_ISLEM_TAR", 
											  SUM(X."SAY") AS "SAY", 
											  ROW_NUMBER() OVER( PARTITION BY X."HastaMerkezId" ORDER BY SUM(X."SAY") DESC ) AS "SIRA" 
										FROM ( SELECT A."HastaMerkezId", 
													  A."BolumAdi", 
													  MAX(A."IslemTarihi") AS "MAX_ISLEM_TAR", 
													  COUNT(DISTINCT A."ProtokolId") AS "SAY" 
												FROM ( SELECT HP."HastaMerkezId" AS "HastaMerkezId", 
															  HP."ProtokolId" AS "ProtokolId", 
															  HP."IslemTarihi" AS "IslemTarihi", 
															  HP."BolumAdi" 
														FROM "DIMHastaProtokol24" HP 
														LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1 = 1 
														WHERE HP."BolumAdi" NOT IN ( 'Laboratuvar', 'Radyoloji', 'Anestezi' ) 
													  ) A GROUP BY A."HastaMerkezId", A."BolumAdi" 
												) X GROUP BY X."HastaMerkezId", X."BolumAdi" 
										) B WHERE B."SIRA" = 1 
							  ) C 
							  ) D GROUP BY "HastaMerkezId" 
							  UNION all 
							  SELECT "HastaMerkezId", 
									 0 AS "SubeUstId24", 
									 '' AS "Lokasyon24", 
									 0 AS "DoktorId24", 
									 '' AS "DoktorAdi24", 
									 '' AS "BolumAdi24", 
									 MAX("SubeUstId") AS "SubeUstId", 
									 MAX(Lokasyon) AS "Lokasyon", 
									 MAX("DoktorId") AS "DoktorId", 
									 MAX("DoktorAdi") AS "DoktorAdi", 
									 MAX("BolumAdi") AS "BolumAdi", 
									 MAX("BolumId") AS "BolumId22", 
									 0 AS "EnSonSubeUstId", 
									 '' AS "EnSonLokasyon", 
									 0 AS "EnSonDoktorId", 
									 '' AS "EnSonDoktorAdi", 
									 '' AS "EnSonBolumAdi", 
									 0 AS "EnSonBolumId" 
							  FROM ( SELECT C."HastaMerkezId", 
											C."SubeUstId", 
											C."SubeUstAdi" AS Lokasyon, 
											0 AS "DoktorId", 
											'' AS "DoktorAdi", 
											'' AS "BolumAdi", 
											0 AS "BolumId" 
									FROM ( SELECT B."HastaMerkezId" AS "HastaMerkezId", 
											      B."SubeId" AS "SubeUstId", 
												  SU."SubeUstAdi" AS "SubeUstAdi", 
												  ROW_NUMBER() OVER( PARTITION BY B."HastaMerkezId" ORDER BY B."SAY" DESC, "MAX_ISLEM_TAR" DESC ) "SIRA" 
											FROM ( SELECT A."HastaMerkezId" AS "HastaMerkezId", 
														  A."SubeId" AS "SubeId", 
														  MAX("IslemTarihi") AS "MAX_ISLEM_TAR", 
														  COUNT(DISTINCT A."ProtokolId") AS "SAY" 
													FROM ( SELECT HP."HastaMerkezId" AS "HastaMerkezId", 
																  HP."ProtokolId" AS "ProtokolId", 
																  HP."IslemTarihi" AS "IslemTarihi", 
																  HP."SubeId" AS "SubeId" 
															FROM "DIMHastaProtokol" HP 
															LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1 = 1 
															) A 
													GROUP BY A."HastaMerkezId", A."SubeId" 
													) B 
											LEFT JOIN "MEMOBI_DWH"."DIMSube" S ON S."SubeUstId" = B."SubeId" 
											JOIN "MEMOBI_DWH"."DIMSubeUst" SU ON SU."SubeUstId" = S."SubeUstId" 
											) C WHERE C."SIRA" = 1 
									union all 
									SELECT C."HastaMerkezId", 
											0 AS "SubeUstId", 
											'' AS "Lokasyon", 
											C."DoktorId", 
											C."DoktorAdi", 
											'' AS "BolumAdi",
											0 AS "BolumId"
									FROM ( SELECT B."HastaMerkezId" AS "HastaMerkezId", 
												  B."DoktorId" AS "DoktorId", 
												 IK."DoktorAdi" AS "DoktorAdi", 
												 ROW_NUMBER() OVER( PARTITION BY B."HastaMerkezId" ORDER BY B."SAY" DESC, "MAX_ISLEM_TAR" DESC ) "SIRA" 
											FROM ( SELECT A."HastaMerkezId" AS "HastaMerkezId", 
														  A."DoktorId" AS "DoktorId", 
														  MAX("IslemTarihi") AS "MAX_ISLEM_TAR", 
														  COUNT(DISTINCT A."ProtokolId") AS "SAY" 
													FROM ( SELECT HP."HastaMerkezId" AS "HastaMerkezId", 
																  HP."ProtokolId" AS "ProtokolId", 
																  HP."IslemTarihi" AS "IslemTarihi", 
																  HP."UygulayanPersonelId" AS "DoktorId" 
															FROM "DIMHastaProtokol" HP 
															LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1 = 1 
															WHERE 1 = 1 AND HP."BolumAdi" NOT IN ( 'Laboratuvar', 'Radyoloji', 'Anestezi' ) 
																  AND HP."UygulayanPersonelId" IS NOT NULL 
														  ) A GROUP BY A."HastaMerkezId", A."DoktorId" 
													) B LEFT JOIN "MEMOBI_DWH"."DM_XLS_Doktor" IK ON IK."MasterDoktorId" = B."DoktorId" 
											) C WHERE 1 = 1 AND C."SIRA" = 1 
										UNION all 
										SELECT C."HastaMerkezId", 
											   0 AS "SubeUstId", 
											   '' AS "Lokasyon", 
											   0 AS "DoktorId", 
											   '' AS "DoktorAdi", 
											   C."BolumAdi" AS "EverBaskınBolum", 
											   C."BolumId" AS "BolumId" 
										FROM ( SELECT B."HastaMerkezId", 
													  B."BolumAdi", 
													  B."BolumId", 
													  B."SIRA" 
												FROM ( SELECT X."HastaMerkezId", 
															  X."BolumAdi", 
															  X."BolumId", 
															  MAX(X."MAX_ISLEM_TAR") AS "MAX_ISLEM_TAR", 
															  SUM(X."SAY") AS "SAY", 
															  ROW_NUMBER() OVER( PARTITION BY X."HastaMerkezId" ORDER BY SUM(X."SAY") DESC ) AS "SIRA" 
														FROM ( SELECT A."HastaMerkezId", 
																	  A."BolumAdi", 
																	  A."BolumId", 
																	  MAX(A."IslemTarihi") AS "MAX_ISLEM_TAR", 
																	  COUNT(DISTINCT A."ProtokolId") AS "SAY" 
																FROM ( SELECT HP."HastaMerkezId" AS "HastaMerkezId", 
																			  HP."ProtokolId" AS "ProtokolId", 
																			  HP."IslemTarihi" AS "IslemTarihi", 
																			  HP."BolumAdi", 
																			  HP."BolumId" 
																		FROM "DIMHastaProtokol" HP 
																		LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1 = 1 
																		WHERE HP."BolumAdi" NOT IN ( 'Laboratuvar', 'Radyoloji', 'Anestezi' ) 
																		) A GROUP BY A."HastaMerkezId", A."BolumAdi", A."BolumId" 
															  ) X GROUP BY X."HastaMerkezId", X."BolumAdi", X."BolumId" 
															  ) B WHERE B."SIRA" = 1 
												) C ) D GROUP BY "HastaMerkezId" 
										   UNION all 
										SELECT "HastaMerkezId", 
												0 AS "SubeUstId24", 
												'' AS "Lokasyon24", 
												0 AS "DoktorId24", 
												'' AS "DoktorAdi24", 
												'' AS "BolumAdi24", 
												0 AS "SubeUstId", 
												'' AS "Lokasyon", 
												0 AS "DoktorId", 
												'' AS "DoktorAdi", 
												'' AS "BolumAdi", 
												0 AS "BolumId22", 
												MAX("SubeUstId") AS "EnSonSubeUstId", 
												MAX(Lokasyon) AS "EnSonLokasyon", 
												MAX("DoktorId") AS "EnSonDoktorId", 
												MAX("DoktorAdi") AS "EnSonDoktorAdi", 
												MAX("BolumAdi") AS "EnSonBolumAdi", 
												MAX("BolumId") AS "EnSonBolumId" 
										FROM ( SELECT C."HastaMerkezId", 
											          C."SubeUstId", 
													  C."SubeUstAdi" AS Lokasyon, 
													  0 AS "DoktorId", 
													  '' AS "DoktorAdi", 
													  '' AS "BolumAdi", 
													  0 AS "BolumId" 
												FROM ( SELECT B."HastaMerkezId" AS "HastaMerkezId", 
															  B."SubeId" AS "SubeUstId", 
															  SU."SubeUstAdi" AS "SubeUstAdi", 
															  ROW_NUMBER() OVER( PARTITION BY B."HastaMerkezId" ORDER BY "MAX_ISLEM_TAR" DESC ) "SIRA" 
														FROM ( SELECT A."HastaMerkezId" AS "HastaMerkezId", 
																	  A."SubeId" AS "SubeId", 
																	  MAX("IslemTarihi") AS "MAX_ISLEM_TAR", 
																	  COUNT(DISTINCT A."ProtokolId") AS "SAY" 
																FROM ( SELECT HP."HastaMerkezId" AS "HastaMerkezId", 
																			  HP."ProtokolId" AS "ProtokolId", 
																			  HP."IslemTarihi" AS "IslemTarihi", 
																			  HP."SubeId" AS "SubeId" 
																		FROM "DIMHastaProtokol" HP 
																	  ) A GROUP BY A."HastaMerkezId", A."SubeId" 
															  ) B 
															  LEFT JOIN "MEMOBI_DWH"."DIMSube" S ON S."SubeUstId" = B."SubeId" 
															  JOIN "MEMOBI_DWH"."DIMSubeUst" SU ON SU."SubeUstId" = S."SubeUstId" 
														) C WHERE C."SIRA" = 1 
											UNION all 
											SELECT C."HastaMerkezId", 
												   0 AS "SubeUstId", 
												   '' AS "Lokasyon", 
												   C."DoktorId", 
												   C."DoktorAdi", 
												   '' AS "BolumAdi", 
												   0 AS "BolumId" 
											FROM ( SELECT B."HastaMerkezId" AS "HastaMerkezId", 
														  B."DoktorId" AS "DoktorId", 
														  IK."DoktorAdi" AS "DoktorAdi", 
														  ROW_NUMBER() OVER( PARTITION BY B."HastaMerkezId" ORDER BY "MAX_ISLEM_TAR" DESC ) "SIRA" 
													FROM ( SELECT A."HastaMerkezId" AS "HastaMerkezId", 
																  A."DoktorId" AS "DoktorId", 
																  MAX("IslemTarihi") AS "MAX_ISLEM_TAR", 
																  COUNT(DISTINCT A."ProtokolId") AS "SAY" 
													       FROM ( SELECT HP."HastaMerkezId" AS "HastaMerkezId", 
																		 HP."ProtokolId" AS "ProtokolId", 
																		 HP."IslemTarihi" AS "IslemTarihi", 
																		 HP."UygulayanPersonelId" AS "DoktorId" 
																	FROM "DIMHastaProtokol" HP 
																	LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1 = 1 WHERE 1 = 1 
																) A GROUP BY A."HastaMerkezId", A."DoktorId" 
														   ) B LEFT JOIN "MEMOBI_DWH"."DM_XLS_Doktor" IK ON IK."MasterDoktorId" = B."DoktorId" 
													) C WHERE 1 = 1 AND C."SIRA" = 1 
											UNION all 
											SELECT C."HastaMerkezId", 
											0 AS "SubeUstId", 
											'' AS "Lokasyon", 
											0 AS "DoktorId", 
											'' AS "DoktorAdi", 
											C."BolumAdi" AS "Son2YılBaskınBolum", 
											C."BolumId" AS "BolumId" 
											FROM ( SELECT B."HastaMerkezId", B."BolumAdi", B."BolumId", B."SIRA" 
												   FROM ( SELECT X."HastaMerkezId", 
													             X."BolumAdi", 
																 X."BolumId", 
														   MAX(X."MAX_ISLEM_TAR") AS "MAX_ISLEM_TAR", 
														   SUM(X."SAY") AS "SAY", 
														   ROW_NUMBER() OVER( PARTITION BY X."HastaMerkezId" ORDER BY SUM(X."SAY") DESC ) AS "SIRA" 
														 FROM ( SELECT A."HastaMerkezId", 
																	   A."BolumAdi", 
																	   A."BolumId", 
																	   MAX(A."IslemTarihi") AS "MAX_ISLEM_TAR", 
																	   COUNT(DISTINCT A."ProtokolId") AS "SAY" 
																FROM ( SELECT HP."HastaMerkezId" AS "HastaMerkezId", 
																			  HP."ProtokolId" AS "ProtokolId", 
																			  HP."IslemTarihi" AS "IslemTarihi", 
																			  HP."BolumAdi", 
																			  HP."BolumId" 
																		FROM "DIMHastaProtokol" HP 
																		LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1 = 1 
																	 ) A GROUP BY A."HastaMerkezId", A."BolumAdi", A."BolumId" 
																) X GROUP BY X."HastaMerkezId", X."BolumAdi", X."BolumId" 
														) B WHERE B."SIRA" = 1 ) C 
														) D GROUP BY "HastaMerkezId" 
	) Y 
left join "MEMOBI_ODS_MRKZ"."IK_Personel" IKP2Yil on IKP2Yil."Id" =y."DoktorId24" 
left join "MEMOBI_ODS_MRKZ"."IK_Personel" IKPEnCok on IKPEnCok."Id" =y."DoktorId" 
left join "MEMOBI_ODS_MRKZ"."IK_Personel" IKPEnSon on IKPEnSon."Id" =y."EnSonDoktorId" 
GROUP BY y."HastaMerkezId" 
--HastaRandevu
SELECT HD."HastaMerkezId",
	  MAX(CASE WHEN cast(PRO."Randevu_Tarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Mobil Hasta' THEN 1 ELSE 0 END) AS "Randevu_Kaynak_Mobil_Flag_03" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Mobil Hasta' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Mobil_Flag_06" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Mobil Hasta' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Mobil_Flag_012" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Mobil Hasta' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Mobil_Flag_024" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Pusula HBYS' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Pusula_HBYS_Flag_03" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Pusula HBYS' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Pusula_HBYS_Flag_06" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Pusula HBYS' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Pusula_HBYS_Flag_012" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Pusula HBYS' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Pusula_HBYS_Flag_024" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Websitesi' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Websitesi_Flag_03" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Websitesi' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Websitesi_Flag_06" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Websitesi' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Websitesi_Flag_012" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Websitesi' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Websitesi_Flag_024" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Çağrı Merkezi' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_CagriMerkezi_Flag_03" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Çağrı Merkezi' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_CagriMerkezi_Flag_06" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Çağrı Merkezi' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_CagriMerkezi_Flag_012" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Çağrı Merkezi' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_CagriMerkezi_Flag_024" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."UcAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Whatsapp' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Whatsapp_Flag_03" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."AltiAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Whatsapp' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Whatsapp_Flag_06" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."OnIkiAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Whatsapp' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Whatsapp_Flag_012" ,
	  MAX(CASE WHEN cast (PRO."Randevu_Tarihi" as date) between T."YirmiDortAyOnceIlkGun" and T."OncekiAySonGun" AND PRO."Text_Kaynak"='Whatsapp' THEN 1 ELSE 0 END ) AS "Randevu_Kaynak_Whatsapp_Flag_024" 
FROM "MEMOBI_DWH"."DIMHastaDetails" HD 
left join "MEMOBI_DM"."DM_Prm_Appointment" PRO on HD."HastaMerkezId"=PRO."HastaId" 
LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T on 1=1 
GROUP BY HD."HastaMerkezId" 
--HastaKurum
SELECT "HastaMerkezId",
	   MAX("Kurum_Tip_OSS_03") AS"Kurum_Tip_OSS_03",
	   MAX("Kurum_Tip_OSS_06") AS"Kurum_Tip_OSS_06",
	   MAX("Kurum_Tip_OSS_012") AS "Kurum_Tip_OSS_012",
	   MAX("Kurum_Tip_OSS_013_024") AS "Kurum_Tip_OSS_013_024",
	   MAX("Kurum_Tip_OSS_024") AS "Kurum_Tip_OSS_024",
	   MAX("Kurum_Tip_OSS_Ever") AS "Kurum_Tip_OSS_Ever",
	   MAX("Kurum_Tip_AKK_03") AS "Kurum_Tip_AKK_03",
	   MAX("Kurum_Tip_AKK_06") AS "Kurum_Tip_AKK_06",
	   MAX("Kurum_Tip_AKK_012") AS "Kurum_Tip_AKK_012",
	   MAX("Kurum_Tip_AKK_013_024") AS "Kurum_Tip_AKK_013_024",
	   MAX("Kurum_Tip_AKK_024") AS "Kurum_Tip_AKK_024",
	   MAX("Kurum_Tip_AKK_Ever") AS "Kurum_Tip_AKK_Ever",
	   MAX("Kurum_Tip_Ucretli_03") AS "Kurum_Tip_Ucretli_03" ,
	   MAX("Kurum_Tip_Ucretli_06") AS "Kurum_Tip_Ucretli_06",
	   MAX("Kurum_Tip_Ucretli_012") AS "Kurum_Tip_Ucretli_012",
	   MAX("Kurum_Tip_Ucretli_013_024") AS "Kurum_Tip_Ucretli_013_024",
	   MAX("Kurum_Tip_Ucretli_024") AS "Kurum_Tip_Ucretli_024" ,
	   MAX("Kurum_Tip_Ucretli_Ever") AS "Kurum_Tip_Ucretli_Ever",
	   MAX("Kurum_Tip_SGK_03") AS "Kurum_Tip_SGK_03",
	   MAX("Kurum_Tip_SGK_06") AS "Kurum_Tip_SGK_06",
	   MAX("Kurum_Tip_SGK_012") AS "Kurum_Tip_SGK_012",
	   MAX("Kurum_Tip_SGK_013_024") AS "Kurum_Tip_SGK_013_024",
	   MAX("Kurum_Tip_SGK_024") AS "Kurum_Tip_SGK_024",
	   MAX("Kurum_Tip_SGK_Ever") as"Kurum_Tip_SGK_Ever", 
	   MAX("SonKurumTipi") AS "SonKurumTipi", 
	   MAX("SonOSSKurumAdi") AS "SonOSSKurumAdi", 
	   MAX("SonAKKKurumAdi") AS "SonAKKKurumAdi", 
	   MAX("BaskınKurumTipi") AS "BaskinKurumTipi", 
	   cast(now() AS timestamp) AS "ETLDate" 
FROM( SELECT distinct HC."HastaMerkezId",
		    MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=2 THEN 1 ELSE 0 END) AS "Kurum_Tip_OSS_03" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=2 THEN 1 ELSE 0 END) AS "Kurum_Tip_OSS_06" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=2 THEN 1 ELSE 0 END) AS "Kurum_Tip_OSS_012" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T."OnUcAyOnceSonGun" AND KT."KurumTipiId"=2 THEN 1 ELSE 0 END) AS "Kurum_Tip_OSS_013_024" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=2 THEN 1 ELSE 0 END) AS "Kurum_Tip_OSS_024" ,
			MAX(CASE WHEN KT."KurumTipiId"=2 THEN 1 ELSE 0 END) AS "Kurum_Tip_OSS_Ever" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=3 THEN 1 ELSE 0 END ) AS "Kurum_Tip_AKK_03" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=3 THEN 1 ELSE 0 END ) AS "Kurum_Tip_AKK_06" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=3 THEN 1 ELSE 0 END ) AS "Kurum_Tip_AKK_012" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T."OnUcAyOnceSonGun" AND KT."KurumTipiId"=3 THEN 1 ELSE 0 END ) AS "Kurum_Tip_AKK_013_024" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=3 THEN 1 ELSE 0 END ) AS "Kurum_Tip_AKK_024" ,
			MAX(CASE WHEN KT."KurumTipiId"=3 THEN 1 ELSE 0 END ) AS "Kurum_Tip_AKK_Ever" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=0 THEN 1 ELSE 0 END ) AS "Kurum_Tip_Ucretli_03" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=0 THEN 1 ELSE 0 END ) AS "Kurum_Tip_Ucretli_06" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=0 THEN 1 ELSE 0 END ) AS "Kurum_Tip_Ucretli_012" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T."OnUcAyOnceSonGun" AND KT."KurumTipiId"=0 THEN 1 ELSE 0 END ) AS "Kurum_Tip_Ucretli_013_024" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=0 THEN 1 ELSE 0 END ) AS "Kurum_Tip_Ucretli_024" ,
			MAX(CASE WHEN KT."KurumTipiId"=0 THEN 1 ELSE 0 END ) AS "Kurum_Tip_Ucretli_Ever" ,MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."UcAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=1 THEN 1 ELSE 0 END ) AS "Kurum_Tip_SGK_03" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."AltiAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=1 THEN 1 ELSE 0 END ) AS "Kurum_Tip_SGK_06" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."OnIkiAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=1 THEN 1 ELSE 0 END ) AS "Kurum_Tip_SGK_012" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T."OnUcAyOnceSonGun" AND KT."KurumTipiId"=1 THEN 1 ELSE 0 END ) AS "Kurum_Tip_SGK_013_024" ,
			MAX(CASE WHEN cast (FP."ProtokolAcilisTarihi" AS date) BETWEEN T."YirmiDortAyOnceIlkGun" AND T."OncekiAySonGun" AND KT."KurumTipiId"=1 THEN 1 ELSE 0 END ) AS "Kurum_Tip_SGK_024" ,
			MAX(CASE WHEN KT."KurumTipiId"=1 THEN 1 ELSE 0 END ) AS "Kurum_Tip_SGK_Ever", 
			'' AS "SonKurumTipi", 
			'' AS "SonOSSKurumAdi", 
			'' AS "SonAKKKurumAdi", 
			'' AS "BaskınKurumTipi" 
	  FROM "FCTProtokol" FP
	  left join "MEMOBI_DWH"."DIMHasta" h on h."HastaId" = FP."HastaId"
	  LEFT JOIN "MEMOBI_DWH"."DIMHastaCurrent" HC on HC."HastaTCKimlikNo" = h."HastaTCKimlikNo"	  
	  LEFT JOIN "MEMOBI_DWH"."DIMKurumTipi" KT ON KT."KurumTipiId" = FP."KurumTipiId" 
	  LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1=1 
	  GROUP BY FP."HastaMerkezId" 
	  UNION all 
	  SELECT y."HastaMerkezId",
		     0 AS "Kurum_Tip_OSS_03",
			 0 AS "Kurum_Tip_OSS_06",
			 0 AS "Kurum_Tip_OSS_012",
			 0 AS "Kurum_Tip_OSS_013_024",
			 0 AS "Kurum_Tip_OSS_024",
			 0 AS "Kurum_Tip_OSS_Ever",
			 0 AS "Kurum_Tip_AKK_03",
			 0 AS "Kurum_Tip_AKK_06",
			 0 AS "Kurum_Tip_AKK_012",
			 0 AS "Kurum_Tip_AKK_013_024",
			 0 AS "Kurum_Tip_AKK_024",
			 0 AS "Kurum_Tip_AKK_Ever",
			 0 AS "Kurum_Tip_Ucretli_03",
			 0 AS "Kurum_Tip_Ucretli_06",
			 0 AS "Kurum_Tip_Ucretli_012",
			 0 AS "Kurum_Tip_Ucretli_013_024",
			 0 AS "Kurum_Tip_Ucretli_024",
			 0 AS "Kurum_Tip_Ucretli_Ever",
			 0 AS "Kurum_Tip_SGK_03",
			 0 AS "Kurum_Tip_SGK_06",
			 0 AS "Kurum_Tip_SGK_012",
			 0 AS "Kurum_Tip_SGK_013_024",
			 0 AS "Kurum_Tip_SGK_024",
			 0 AS "Kurum_Tip_SGK_Ever", 
			 CASE WHEN max(y."KurumTipiId") = 0 THEN 'Ucretli' 
				  WHEN max(y."KurumTipiId") = 1 THEN 'SGK' 
				  WHEN max(y."KurumTipiId") = 2 THEN 'OSS' 
				  WHEN max(y."KurumTipiId") = 3 THEN 'AKK' END AS "SonKurumTipi", 
			'' AS "SonOSSKurumAdi", 
			'' AS "SonAKKKurumAdi", 
			'' AS "BaskınKurumTipi" 
		FROM (SELECT distinct hc."HastaMerkezId", 
					 "KurumTipiId" AS "KurumTipiId", 
					 ROW_NUMBER() OVER(PARTITION BY FP."HastaMerkezId" ORDER BY cast(FP."ProtokolAcilisTarihi" AS date) desc) "Sira" 
			  FROM "FCTProtokol" FP 
			  left join "MEMOBI_DWH"."DIMHasta" h on h."HastaId" = FP."HastaId"
			  LEFT JOIN "MEMOBI_DWH"."DIMHastaCurrent" HC on HC."HastaTCKimlikNo" = h."HastaTCKimlikNo"	  	  
			  GROUP BY hc."HastaMerkezId",cast(FP."ProtokolAcilisTarihi" AS date),"KurumTipiId" 
			  ) y WHERE "Sira"= 1 
		GROUP BY y."HastaMerkezId" 
		UNION all 
		select z."HastaMerkezId", 
			   0 AS "Kurum_Tip_OSS_03",
			   0 AS "Kurum_Tip_OSS_06",
			   0 AS "Kurum_Tip_OSS_012",
			   0 AS "Kurum_Tip_OSS_013_024",
			   0 AS "Kurum_Tip_OSS_024",
			   0 AS "Kurum_Tip_OSS_Ever",
			   0 AS "Kurum_Tip_AKK_03",
			   0 AS "Kurum_Tip_AKK_06",
			   0 AS "Kurum_Tip_AKK_012",
			   0 AS "Kurum_Tip_AKK_013_024",
			   0 AS "Kurum_Tip_AKK_024",
			   0 AS "Kurum_Tip_AKK_Ever",
			   0 AS "Kurum_Tip_Ucretli_03",
			   0 AS "Kurum_Tip_Ucretli_06",
			   0 AS "Kurum_Tip_Ucretli_012",
			   0 AS "Kurum_Tip_Ucretli_013_024",
			   0 AS "Kurum_Tip_Ucretli_024",
			   0 AS "Kurum_Tip_Ucretli_Ever",
			   0 AS "Kurum_Tip_SGK_03",
			   0 AS "Kurum_Tip_SGK_06",
			   0 AS "Kurum_Tip_SGK_012",
			   0 AS "Kurum_Tip_SGK_013_024",
			   0 AS "Kurum_Tip_SGK_024",
			   0 AS "Kurum_Tip_SGK_Ever",
			   '' AS "SonKurumTipi", 
			   max(OSS."Adi") as "SonOSSKurumAdi",
			   max(AKK."Adi") as "SonAKKKurumAdi", 
			   '' AS "BaskınKurumTipi" 
		from ( select y."HastaMerkezId",
					  MAX("OSSKurumId") as "OSSKurumId",
					  MAX("AKKurumId") as "AKKurumId" 
				from( select HP."HastaMerkezId",
							 HP."SubeId",
							 HP."KaynakSys", 
							 MAX("ProtokolId") as "ProtokolIC" 
						from "DIMHastaProtokol" HP 
						LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1=1 
						where cast (HP."AcilisTarihi" AS date) <=T."OncekiAySonGun" 
						group by HP."HastaMerkezId",HP."SubeId",HP."KaynakSys" 
					 ) y inner join "FCTProtokol" FP on fp."ProtokolId" = y."ProtokolIC" and fp."SubeId" =y."SubeId" and fp."KaynakSys" = y."KaynakSys" 
				group by y."HastaMerkezId" 
			   )z 
		left join "MEMOBI_DM"."DM_XLS_Kurum" OSS on OSS."KurumId" = z."OSSKurumId" 
		left join "MEMOBI_DM"."DM_XLS_Kurum" AKK on AKK."KurumId" = z."AKKurumId" 
		group by z."HastaMerkezId" 
		union all 
		SELECT y."HastaMerkezId",
				0 AS "Kurum_Tip_OSS_03",
				0 AS "Kurum_Tip_OSS_06",
				0 AS "Kurum_Tip_OSS_012",
				0 AS "Kurum_Tip_OSS_013_024",
				0 AS "Kurum_Tip_OSS_024",
				0 AS "Kurum_Tip_OSS_Ever",
				0 AS "Kurum_Tip_AKK_03",
				0 AS "Kurum_Tip_AKK_06",
				0 AS "Kurum_Tip_AKK_012",
				0 AS "Kurum_Tip_AKK_013_024",
				0 AS "Kurum_Tip_AKK_024",
				0 AS "Kurum_Tip_AKK_Ever",
				0 AS "Kurum_Tip_Ucretli_03",
				0 AS "Kurum_Tip_Ucretli_06",
				0 AS "Kurum_Tip_Ucretli_012",
				0 AS "Kurum_Tip_Ucretli_013_024",
				0 AS "Kurum_Tip_Ucretli_024",
				0 AS "Kurum_Tip_Ucretli_Ever",
				0 AS "Kurum_Tip_SGK_03",
				0 AS "Kurum_Tip_SGK_06",
				0 AS "Kurum_Tip_SGK_012",
				0 AS "Kurum_Tip_SGK_013_024",
				0 AS "Kurum_Tip_SGK_024",
				0 AS "Kurum_Tip_SGK_Ever",
				'' AS "SonKurumTipi" ,
				'' AS "SonOSSKurumAdi" ,
				'' AS "SonAKKKurumAdi", 
				CASE WHEN max(y."KurumTipiId") = 0 THEN 'Ucretli' 
				WHEN max(y."KurumTipiId") = 1 THEN 'SGK' 
				WHEN max(y."KurumTipiId") = 2 THEN 'OSS' 
				WHEN max(y."KurumTipiId") = 3 THEN 'AKK' END AS "BaskınKurumTipi" 
		FROM (SELECT distinct hc."HastaMerkezId", 
					 "KurumTipiId" AS "KurumTipiId", 
					 ROW_NUMBER() OVER(PARTITION BY FP."HastaMerkezId" ORDER BY SUM("KdvsizHizmetTutari") desc) "Sira" 
			 FROM "FCTProtokol" FP 
			 left join "MEMOBI_DWH"."DIMHasta" h on h."HastaId" = FP."HastaId"
			  LEFT JOIN "MEMOBI_DWH"."DIMHastaCurrent" HC on HC."HastaTCKimlikNo" = h."HastaTCKimlikNo"	  	  			  
			 GROUP BY hc."HastaMerkezId",cast(FP."ProtokolAcilisTarihi" AS date),"KurumTipiId" 
			 ) y 
			 WHERE "Sira"= 1 GROUP BY y."HastaMerkezId" 
			 ) t 
			 GROUP BY t."HastaMerkezId"
		from ( 
		select y."HastaMerkezId",
			  MAX("OSSKurumId") as "OSSKurumId",
			  MAX("AKKurumId") as "AKKurumId" 
			  from( select HP."HastaMerkezId",
						   HP."SubeId",
						   HP."KaynakSys", 
						   MAX("ProtokolId") as "ProtokolIC" 
					from "DIMHastaProtokol" HP 
					LEFT JOIN "MEMOBI_DM"."DM_HastaDataMartTarih" T ON 1=1 
					where cast (HP."AcilisTarihi" AS date) <=T."OncekiAySonGun" 
					group by HP."HastaMerkezId",HP."SubeId",HP."KaynakSys" 
		) y inner join "FCTProtokol" FP on fp."ProtokolId" = y."ProtokolIC" and fp."SubeId" =y."SubeId" and fp."KaynakSys" = y."KaynakSys" 
		group by y."HastaMerkezId" 
		)z 
		left join "MEMOBI_DM"."DM_XLS_Kurum" OSS on OSS."KurumId" = z."OSSKurumId" 
		left join "MEMOBI_DM"."DM_XLS_Kurum" AKK on AKK."KurumId" = z."AKKurumId" 
		group by z."HastaMerkezId" 
		union all 
		SELECT y."HastaMerkezId",
			  0 AS "Kurum_Tip_OSS_03",
			  0 AS "Kurum_Tip_OSS_06",
			  0 AS "Kurum_Tip_OSS_012",
			  0 AS "Kurum_Tip_OSS_013_024",
			  0 AS "Kurum_Tip_OSS_024",
			  0 AS "Kurum_Tip_OSS_Ever",
			  0 AS "Kurum_Tip_AKK_03",
			  0 AS "Kurum_Tip_AKK_06",
			  0 AS "Kurum_Tip_AKK_012",
			  0 AS "Kurum_Tip_AKK_013_024",
			  0 AS "Kurum_Tip_AKK_024",
			  0 AS "Kurum_Tip_AKK_Ever",
			  0 AS "Kurum_Tip_Ucretli_03",
			  0 AS "Kurum_Tip_Ucretli_06",
			  0 AS "Kurum_Tip_Ucretli_012",
			  0 AS "Kurum_Tip_Ucretli_013_024",
			  0 AS "Kurum_Tip_Ucretli_024",
			  0 AS "Kurum_Tip_Ucretli_Ever",
			  0 AS "Kurum_Tip_SGK_03",
			  0 AS "Kurum_Tip_SGK_06",
			  0 AS "Kurum_Tip_SGK_012",
			  0 AS "Kurum_Tip_SGK_013_024",
			  0 AS "Kurum_Tip_SGK_024",
			  0 AS "Kurum_Tip_SGK_Ever",
			  '' AS "SonKurumTipi" ,
			  '' AS "SonOSSKurumAdi" ,
			  '' AS "SonAKKKurumAdi", 
			  CASE WHEN max(y."KurumTipiId") = 0 THEN 'Ucretli' 
				   WHEN max(y."KurumTipiId") = 1 THEN 'SGK' 
				   WHEN max(y."KurumTipiId") = 2 THEN 'OSS' 
				   WHEN max(y."KurumTipiId") = 3 THEN 'AKK' END AS "BaskınKurumTipi" 
		FROM (SELECT distinct HC."HastaMerkezId", 
					 "KurumTipiId" AS "KurumTipiId", 
					 ROW_NUMBER() OVER(PARTITION BY FP."HastaMerkezId" ORDER BY SUM("KdvsizHizmetTutari") desc) "Sira" 
			  FROM "FCTProtokol" FP
			  left join "MEMOBI_DWH"."DIMHasta" h on h."HastaId" = FP."HastaId"
			  LEFT JOIN "MEMOBI_DWH"."DIMHastaCurrent" HC on HC."HastaTCKimlikNo" = h."HastaTCKimlikNo"			  
			  GROUP BY HC."HastaMerkezId",cast(FP."ProtokolAcilisTarihi" AS date),"KurumTipiId" 
			  ) y WHERE "Sira"= 1 
		GROUP BY y."HastaMerkezId" 
		) t GROUP BY t."HastaMerkezId"
--HastaSegment
select  "HastaMerkezId", "HastaTCKimlikNo",
		y."SegmentId",
		ST."SegmentAdi" as "Segment",
		ST2."SegmentAdi" as "GolgeSegment",
		y."OncekiAySegmentId" as "GolgeSegmentId",
		case when y."SegmentId" <> y."OncekiAySegmentId" then 1 else 0 end as "SegmentDegisikligi",
		"Max_Ref_Tarih"
from( 
select "HastaMerkezId", 
	   "HastaTCKimlikNo",MAX("Ref_Tarih") as "Max_Ref_Tarih","Sira",
	   case when "Sira" = 1 and "Recency" <= 12  and "Frekans_024">=10 and "SubeSegment" = 1 and "Ciro_024_USD" >= 1500 then 1 
	        WHEN "Sira" = 1 and "Recency" <= 12  and "Frekans_024">=10 AND "SubeSegment" in (2,3) and "Ciro_024_USD" >= 1000    THEN 1
	        WHEN "Sira" = 1 and "Recency" <= 12  and "Frekans_024">=5 AND "SubeSegment" =1 and "Ciro_024_USD" >= 2000    THEN 2
	        WHEN "Sira" = 1 and "Recency" <= 12  and "Frekans_024">=5 AND "SubeSegment" in (2,3) and "Ciro_024_USD" >= 1500    THEN 2
	        WHEN "Sira" = 1 and "Recency" <= 12  and "Frekans_024">=2 AND "SubeSegment" =1 and "Ciro_024_USD" >= 5000    THEN 3
	        WHEN "Sira" = 1 and "Recency" <= 12  and "Frekans_024">=2 AND "SubeSegment" in (2,3) and "Ciro_024_USD" >= 3000    THEN 3
  			WHEN "Sira" = 1 and "Recency" <= 24  and "Frekans_024">=5 AND "SubeSegment" =1 and "Ciro_024_USD" >= 1000    THEN 4
	        WHEN "Sira" = 1 and "Recency" <= 24  and "Frekans_024">=5 AND "SubeSegment" in (2,3) and "Ciro_024_USD" >= 500    THEN 4
          	WHEN "Sira" = 1 and "Recency" <= 24  and "Frekans_024">=2 AND "SubeSegment" =1 and "Ciro_024_USD" >= 1500    THEN 5
	        WHEN "Sira" = 1 and "Recency" <= 24  and "Frekans_024">=2 AND "SubeSegment" in (2,3) and "Ciro_024_USD" >= 1000 THEN 5
     	    WHEN "Sira" = 1 and "Recency" <= 24  and "Frekans_024">=2 AND "SubeSegment" =1 and "Ciro_024_USD" >= 500    THEN 6
	        WHEN "Sira" = 1 and "Recency" <= 24  and "Frekans_024">=2 AND "SubeSegment" in (2,3) and "Ciro_024_USD" >= 250    THEN 6
	        else 7 end as "SegmentId",
	   case when "Sira" = 2 and "Recency" <= 12  and "Frekans_024">=10 and "SubeSegment" = 1 and "Ciro_024_USD" >= 1500 then 1 
	        WHEN "Sira" = 2 and "Recency" <= 12  and "Frekans_024">=10 AND "SubeSegment" in (2,3) and "Ciro_024_USD" >= 1000    THEN 1
	        WHEN "Sira" = 2 and "Recency" <= 12  and "Frekans_024">=5 AND "SubeSegment" =1 and "Ciro_024_USD" >= 2000    THEN 2
	        WHEN "Sira" = 2 and "Recency" <= 12  and "Frekans_024">=5 AND "SubeSegment" in (2,3) and "Ciro_024_USD" >= 1500    THEN 2
	        WHEN "Sira" = 2 and "Recency" <= 12  and "Frekans_024">=2 AND "SubeSegment" =1 and "Ciro_024_USD" >= 5000    THEN 3
	        WHEN "Sira" = 2 and "Recency" <= 12  and "Frekans_024">=2 AND "SubeSegment" in (2,3) and "Ciro_024_USD" >= 3000    THEN 3
  			WHEN "Sira" = 2 and "Recency" <= 24  and "Frekans_024">=5 AND "SubeSegment" =1 and "Ciro_024_USD" >= 1000    THEN 4
	        WHEN "Sira" = 2 and "Recency" <= 24  and "Frekans_024">=5 AND "SubeSegment" in (2,3) and "Ciro_024_USD" >= 500    THEN 4
          	WHEN "Sira" = 2 and "Recency" <= 24  and "Frekans_024">=2 AND "SubeSegment" =1 and "Ciro_024_USD" >= 1500    THEN 5
	        WHEN "Sira" = 2 and "Recency" <= 24  and "Frekans_024">=2 AND "SubeSegment" in (2,3) and "Ciro_024_USD" >= 1000 THEN 5
     	    WHEN "Sira" = 2 and "Recency" <= 24  and "Frekans_024">=2 AND "SubeSegment" =1 and "Ciro_024_USD" >= 500    THEN 6
	        WHEN "Sira" = 2 and "Recency" <= 24  and "Frekans_024">=2 AND "SubeSegment" in (2,3) and "Ciro_024_USD" >= 250    THEN 6
	        else 7 end as "OncekiAySegmentId"
from 
(select "Ref_Tarih","HastaMerkezId","HastaTCKimlikNo",
        coalesce("Recency_Month",0) as "Recency",
        coalesce("Frekans_024",0) as "Frekans_024" ,
        "SubeSegment","Ciro_024_USD",
	   	ROW_NUMBER() OVER( PARTITION BY "HastaMerkezId" ORDER BY "Ref_Tarih" DESC) "Sira"
from "MEMOBI_DWH"."DIMHastaDatamart" 
)x 
where "Sira" in (1,2)
group by "HastaMerkezId", "HastaTCKimlikNo","Sira","Recency","Frekans_024","SubeSegment","Ciro_024_USD"
) y 
left join "MEMOBI_DWH"."DIMHastaSegmentTipi" ST on ST."Id" =  y."SegmentId"
left join "MEMOBI_DWH"."DIMHastaSegmentTipi" ST2 on ST2."Id" =  y."OncekiAySegmentId"
where "Sira" =1 