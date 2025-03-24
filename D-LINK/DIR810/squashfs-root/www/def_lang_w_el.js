//Version=1.03b02
//Language=Greek
//Date=Tue, 30, Jul, 2013
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Ακύρωση", //_cancel
	"Αντιγραφή της διεύθυνσης MAC του Η/Υ σας", //_clone
	"Σύνδεση DHCP (Διεύθυνση δυναμικού IP)", //_dhcpconn
	"Διεύθυνση IP", //_ipaddr
	"L2TP", //_L2TP
	"Διεύθυνση IP πύλης L2TP", //_L2TPgw
	"Διεύθυσνη IP L2TP", //_L2TPip
	"Μάσκα Υποδικτύου L2TP", //_L2TPsubnet
	"Γλώσσα", //_Language
	"Διεύθυνση MAC", //_macaddr
	"Επόμενο", //_next
	"Όχι", //_no
	"(Προαιρετικά)", //_optional
	"Κωδικός πρόσβασης", //_password
	"Διεύθυνση IP πύλης PPTP", //_PPTPgw
	"Διεύθυνση IP PPTP", //_PPTPip
	"Μάσκα Υποδικτύου PPTP", //_PPTPsubnet
	"Προηγ.", //_prev
	"Τοποθετήστε ίδιους και τους δύο κωδικούς πρόσβασης και επαναλάβετε", //_pwsame_admin
	"Στατική IP", //_sdi_staticip
	"Μάσκα υποδικτύου", //_subnet
	"Όνομα χρήστη", //_username
	"Επαλήθευση κωδικού πρόσβασης", //_verifypw
	"Επιθυμείτε να εγκαταλείψετε όλες τις αλλαγές που πραγματοποιήσατε σε αυτόν τον οδηγό;", //_wizquit
	"Ναι", //_yes
	"Άκυρο διεύθυνση IP Iδιακομιστή L2TP", //bwn_alert_17
	"Διεύθυνση κατάστασης λειτουργίας", //bwn_AM
	"Διακομιστής BigPond", //bwn_BPS
	"TKIP και AES", //bws_CT_3
	"Δυναμική IP", //carriertype_ct_0
	"Ο δρομολογητής εντοπίζει τον τύπο της σύνδεσής σας στο internet, περιμένετε...", //ES_auto_detect_desc
	"Ο δρομολογητής δεν μπορεί να εντοπίσει τον τύπο της σύνδεσής σας στο Internet.", //ES_auto_detect_failed_desc
	"Επιθυμείτε να ορίσετε σελιδοδείκτη το \"Διαχείριση ιστού δρομολογητή D-Link\";", //ES_bookmark
	"Επαναλάβετε", //ES_btn_try_again
	"Συνδέστε το ένα άκρο του συμπεριλαμβανόμενου καλωδίου Ethernet που παρέχεται μαζί με το δρομολογητή σας στη θύρα με την ένδειξη INTERNET στο πίσω μέρος του δρομολογητή. Συνδέστε το άλλο άκρο αυτού του καλωδίου στη θύρα Ethernet του μόντεμ σας και ενεργοποιήστε το μόντεμ.", //ES_cable_lost_desc
	"Βήμα 2: Ρυθμίστε την ασύρματη ασφάλειά σας", //ES_step_wifi_security
	"Βήμα 3: Ρύθμιση του κωδικού πρόσβασής σας", //ES_title_s3
	"Βήμα 4: Επιλέξτε τη Ζώνη ώρας σας", //ES_title_s4
	"Βήμα 5: Αποθήκευση ρυθμίσεων", //ES_title_s5
	"Βήμα 5: Επιβεβαίωση των ασύρματων ρυθμίσεών σας", //ES_title_s5_0
	"Βήμα 6: εγγραφή MYDLINK", //ES_title_s6
	"εγγραφή MYDLINK", //ES_title_s6_myd
	"Βήμα 1: Ρύθμιση της σύνδεσής σας στο Internet", //ES_wwa_title_s1
	"Άκυρο όνομα υπολογιστή πελάτη DHCP", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Άκυρο DHCP+ κωδικός πρόσβασης", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Άκυρο DHCP+ όνομα χρήστη", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"Το όνομα χρήστη L2TP ΠΡΕΠΕΙ να καθορίζεται", //GW_WAN_L2TP_USERNAME_INVALID
	"Ένας κωδικός πρόσβασης PPTP ΠΡΕΠΕΙ να καθορίζεται", //GW_WAN_PPTP_PASSWORD_INVALID
	"Άκυρο κλειδί δικτύου.", //IPV6_TEXT2
	"Άκυρη διεύθυνση MAC.", //KR3
	"Αυτόματο (WPA ή WPA2) - Προσωπικό", //KR48
	"Adelphia Power Link", //manul_conn_01
	"ALLTEL DSL", //manul_conn_02
	"Υπηρεσία DSL ATAT", //manul_conn_03
	"Bell Sympatico", //manul_conn_04
	"Bellsouth", //manul_conn_05
	"Charter High-Speed", //manul_conn_06
	"Comcast", //manul_conn_07
	"Covad", //manul_conn_08
	"Cox Communications", //manul_conn_09
	"Earthlink Cable", //manul_conn_10
	"Earthlink DSL", //manul_conn_11
	"FrontierNet", //manul_conn_12
	"Optimum Online", //manul_conn_13
	"RCN", //manul_conn_14
	"Road Runner", //manul_conn_15
	"Rogers Yahoo!", //manul_conn_16
	"SBC Yahoo! DSL", //manul_conn_17
	"Shaw", //manul_conn_18
	"Speakeasy", //manul_conn_19
	"Sprint FastConnect", //manul_conn_20
	"Telus", //manul_conn_21
	"Time Warner Cable", //manul_conn_22
	"US West / Qwest", //manul_conn_23
	"Verizon Online DSL", //manul_conn_24
	"XO Communications", //manul_conn_25
	"Η εγγραφή του προϊόντος σας στο mydlink θα σας προσφέρει τη δυνατότητα να χρησιμοποιήσετε τις λειτουργίες με δυνατότητα mydlink, συμπεριλαμβανομένης της απευθείας πρόσβασης στο δίκτυο και της διαχείρισης της συσκευής σας μέσω του ιστότοπου mydlink.", //mydlink_tx01
	"Θα επιθυμούσατε να εγγράψετε τη συσκευή σας στο mydlink;", //mydlink_tx02
	"Εισάγετε ένα όνομα χρήστη.", //PPP_USERNAME_EMPTY
	"Υποστηρίζεται PPPoE Plus", //pppoe_plus_dail
	"Ο κωδικός πρόσβασης μπορεί να περιέχει μόνο εκτυπώσιμους χαρακτήρες.", //S493
	"ΑΠΟΘΗΚΕΥΣΗ ΡΥΘΜΙΣΕΩΝ", //save_settings
	"Οι ρυθμίσεις σας αποθηκεύονται.", //save_wait
	"Έκδοση υλικολογισμικού", //sd_FWV
	"Σελίδα προϊόντος", //TA2
	"Έκδοση υλικού", //TA3
	"(GMT-12:00) Ενεγουέτακ, Κουάτζαλεϊν", //up_tz_00
	"(GMT-11:00) Νήσος Μίντγουεϊ, Σαμόα", //up_tz_01
	"(GMT-10:00) Χαβάη", //up_tz_02
	"(GMT-09:00) Αλάσκα", //up_tz_03
	"(GMT-08:00) Ώρα Ειρηνικού (ΗΠΑ/ Καναδάς), Τιχουάνα", //up_tz_04
	"(GMT-07:00) Αριζόνα", //up_tz_05
	"(GMT-07:00) Ορεινή Ώρα (ΗΠΑ/ Καναδάς)", //up_tz_06
	"(GMT-06:00) Κεντρική Αμερική", //up_tz_07
	"(GMT-06:00) Κεντρική Ώρα (ΗΠΑ/ Καναδάς)", //up_tz_08
	"(GMT-06:00) Πόλη του Μεξικού", //up_tz_09
	"(GMT-06:00) Σασκάτσιουαν", //up_tz_10
	"(GMT-05:00) Μπογκότα, Λίμα, Κίτο", //up_tz_11
	"(GMT-05:00) Ανατολική Ώρα (ΗΠΑ/ Καναδάς)", //up_tz_12
	"(GMT-05:00) Ιντιάνα (Ανατολή)", //up_tz_13
	"(GMT-04:00) Ώρα Ατλαντικού (Καναδάς)", //up_tz_14
	"(GMT-04:00) Καράκας, Λα Παζ", //up_tz_15
	"(GMT-04:00) Σαντιάγκο", //up_tz_16
	"(GMT-03:30) Νιουφάουντλαντ", //up_tz_17
	"(GMT-03:00) Μπραζίλια", //up_tz_18
	"(GMT-03:00) Μπουένος Άιρες, Τζόρτζταουν", //up_tz_19
	"(GMT-03:00) Γροιλανδία", //up_tz_20
	"(GMT-02:00) Κεντρικός Ατλαντικός", //up_tz_21
	"(GMT-01:00) Αζόρες", //up_tz_22
	"(GMT-01:00) Πράσινο Ακρωτήριο", //up_tz_23
	"(GMT) Καζαμπλάνκα, Μονρόβια", //up_tz_24
	"(GMT) Μέση Ώρα Γκρίνουιτς: Δουβλίνο, Εδιμβούργο, Λισαβόνα, Λονδίνο", //up_tz_25
	"(GMT+01:00) Άμστερνταμ, Βερολίνο, Βέρνη, Ρώμη, Στοκχόλμη, Βιέννη", //up_tz_26
	"(GMT+01:00) Βελιγράδι, Μπρατισλάβα, Βουδαπέστη, Λιουμπλιάνα, Πράγα", //up_tz_27
	"(GMT+01:00) Βρυξέλλες, Κοπεγχάγη, Μαδρίτη, Παρίσι", //up_tz_28
	"(GMT+01:00) Σαράγεβο, Σκόπια, Σόφια, Βίλνιους, Ζάγκρεμπ", //up_tz_29
	"(GMT+01:00) Βουδαπέστη, Βιέννη, Πράγα, Βαρσοβία", //up_tz_29b
	"(GMT+01:00) Δυτική Κεντρική Αφρική", //up_tz_30
	"(GMT+02:00) Αθήνα, Κωνσταντινούπολη, Μινσκ", //up_tz_31
	"(GMT+02:00) Βουκουρέστι", //up_tz_32
	"(GMT+02:00) Κάιρο", //up_tz_33
	"(GMT+02:00) Χαράρε, Πρετόρια", //up_tz_34
	"(GMT+02:00) Ελσίνκι, Ρίγα, Ταλίν", //up_tz_35
	"(GMT+02:00) Ιερουσαλήμ", //up_tz_36
	"(GMT+03:00) Βαγδάτη", //up_tz_37
	"(GMT+03:00) Κουβέιτ, Ριάντ", //up_tz_38
	"(GMT+04:00) Μόσχα, Αγία Πετρούπολη, Βόλγκογκραντ", //up_tz_39
	"(GMT+03:00) Ναϊρόμπι", //up_tz_40
	"(GMT+03:30) Τεχεράνη", //up_tz_41
	"(GMT+04:00) Άμπου Ντάμπι, Μουσκάτ", //up_tz_42
	"(GMT+04:00) Μπακού, Τιφλίδα, Ερεβάν", //up_tz_43
	"(GMT+04:30) Καμπούλ", //up_tz_44
	"(GMT+06:00) Εκατερίνμπουργκ", //up_tz_45
	"(GMT+05:00) Ισλαμαμπάντ, Καράτσι, Τασκένδη", //up_tz_46
	"(GMT+05:30) Καλκούτα, Χενάι, Μουμπάι, Νέο Δελχί", //up_tz_47
	"(GMT+05:45) Κατμαντού", //up_tz_48
	"(GMT+06:00) Νοβοσιμπίρσκ", //up_tz_49
	"(GMT+06:00) Αστάνα, Ντάκα", //up_tz_50
	"(GMT+06:00) Κόττε", //up_tz_51
	"(GMT+06:30) Ρανγκούν", //up_tz_52
	"(GMT+07:00) Μπανγκόκ, Ανόι, Τζακάρτα", //up_tz_53
	"(GMT+08:00) Κρασνογιάρσκ", //up_tz_54
	"(GMT+08:00) Πεκίνο, Τσονγκίνγκ, Χονγκ Κονγκ, Ουρούμκι", //up_tz_55
	"(GMT+09:00) Ιρκούτσκ, Ουλάν Μπατόρ", //up_tz_56
	"(GMT+08:00) Κουάλα Λουμπούρ, Σιγκαπούρη", //up_tz_57
	"(GMT+08:00) Περθ", //up_tz_58
	"(GMT+08:00) Ταϊπέι", //up_tz_59
	"(GMT+09:00) Οσάκα, Σαπόρο, Τόκιο", //up_tz_60
	"(GMT+09:00) Σεούλ", //up_tz_61
	"(GMT+10:00) Γιακούτσκ", //up_tz_62
	"(GMT+09:30) Αδελαΐδα", //up_tz_63
	"(GMT+09:30) Ντάργουιν", //up_tz_64
	"(GMT+10:00) Μπρίζμπεϊν", //up_tz_65
	"(GMT+10:00) Καμπέρα, Μελβούρνη, Σίδνεϊ", //up_tz_66
	"(GMT+10:00) Γκουάμ, Πορτ Μόρεσμπι", //up_tz_67
	"(GMT+10:00) Χόμπαρτ", //up_tz_68
	"(GMT+11:00) Βλαδιβοστόκ", //up_tz_69
	"(GMT+11:00) Νησιά Σολομώντα, Νέα Καληδονία", //up_tz_70
	"(GMT+12:00) Ώκλαντ, Ουέλλινγκτον", //up_tz_71
	"(GMT+12:00) Φίτζι, Καμτσάτκα, Νήσοι Μάρσαλ", //up_tz_72
	"(GMT+13:00) Νουκουαλόφα, Τόνγκα", //up_tz_73
	"(GMT+07:00) Νοβοσιμπίρσκ", //up_tz_74
	"(GMT+12:00) Μάγκανταν", //up_tz_75
	"(GMT-12:00) Δυτική διεθνής γραμμή ημερομηνίας", //up_tz_76
	"(GMT-11:00) Νήσος Μίντγουεϊ", //up_tz_77
	"(GMT-07:00) Τσιουάουα, Λα Παζ, Μαζατλάν", //up_tz_78
	"(GMT-06:00) Γκουανταλαχάρα, Πόλη του Μεξικού, Μοντερέυ", //up_tz_79
	"(GMT-05:00) Μπογκοτά, Λίμα, Κίτο, Ιντιάνα (Ανατολή)", //up_tz_80
	"(GMT-04:30) Καράκας", //up_tz_81
	"(GMT-04:00) Τζόρτζταουν, Λα Παζ", //up_tz_82
	"(GMT-03:00) Μπουένος Άιρες", //up_tz_83
	"(GMT+01:00) Σαράγιεβο, Σκόπια, Βαρσοβία, Ζάγκρεμπ", //up_tz_84
	"(GMT+02:00) Ελσίνκι, Κίεβο, Ρίγα, Σόφια, Ταλίν, Βίλνιους", //up_tz_85
	"(GMT+05:30) Τσενάι, Καλκούτα, Μουμπάι, Νέο Δελχί", //up_tz_86
	"(GMT+07:00) Αλμάτι, Νοβοσιμπίρσκ", //up_tz_87
	"(GMT+05:30) Σρι Τζαγιαβαρδενεπούρα", //up_tz_88
	"(GMT+08:00) Ουλάν Μπατόρ", //up_tz_89
	"(GMT+09:00) Ιρκούτσκ", //up_tz_90
	"(GMT+13:00) Νουκουαλόφα", //up_tz_91
	"(GMT+13:00) Σαμόα", //up_tz_92
	"Ρυθμίσεις DNS", //wwa_dnsset
	"Διεύθυνση πύλης", //wwa_gw
	"Εκ προεπιλογής, ο νέος δρομολογητής της D-Link σας δεν διαθέτει διαμορφωμένο κωδικό πρόσβασης για πρόσβαση του διαχειριστή σε σελίδες διαμόρφωσης με βάση τον ιστό. Για την ασφάλεια της νέας συσκευής δικτύωσής σας, ρυθμίστε και επαληθεύστε τον παρακάτω κωδικό πρόσβασης καθώς και η ενεργοποίηση της Γραφικής πιστοποίησης CAPTCHA παρέχει προστασία για την αποτροπή μη εξουσιοδοτημένων χρηστών στο δίκτυο και υποκλοπής λογισμικού από πρόσβαση στις ρυθμίσεις δικτύου σας.", //wwa_intro_s1
	"Επιλέξτε την κατάλληλη ζώνη ώρας για την τοποθεσία σας. Οι πληροφορίες αυτές απαιτούνται για τη διαμόρφωση ρυθμίσεων που βασίζονται στην ώρα. Ο δρομολογητής θα ενημερώσει αυτόματα το εσωτερικό ρολόι του από έναν διακομιστή ώρας NTP.", //wwa_intro_s2
	"Παρακαλώ επιλέξτε τον τύπο σύνδεσής σας στο Internet παρακάτω:", //wwa_intro_s3
	"Αυτός ο οδηγός θα σας οδηγήσει βήμα προς βήμα στη διαδικασία διαμόρφωσης που απαιτείται για τη ρύθμιση του δρομολογητή D-Link σας και για τη σύνδεσή σας στο Internet.", //wwa_intro_wel
	"Διεύθυνση IP διακομιστή L2TP (ενδέχεται να είναι η ίδια με της πύλης)", //wwa_l2tp_svra
	"Επιλέξτε εάν η σύνδεσή σας στο Internet σάς προσφέρει αυτόματα μια διεύθυνση IP. Τα περισσότερα καλωδιακά μόντεμ χρησιμοποιούν αυτόν τον τύπο σύνδεσης.", //wwa_msg_dhcp
	"Εάν ο Πάροχος υπηρεσίων Internet δεν είναι καταχωρισμένος ή δεν τον γνωρίζετε, επιλέξτε τον παρακάτω τύπο σύνδεσης στο Internet:", //wwa_msg_ispnot
	"Επιλέξτε αυτήν την επιλογή εάν απαιτείται ένα όνομα χρήστη και ένας κωδικός πρόσβασης για τη σύνδεσή σας στο Internet. Τα περισσότερα μόντεμ DSL χρησιμοποιούν αυτόν τον τύπο σύνδεσης.", //wwa_msg_pppoe
	"Υπολογιστής πελάτης PPTP.", //wwa_msg_pptp
	"Για τη ρύθμιση αυτής της σύνδεσης, βεβαιωθείτε ότι έχετε συνδεθεί στο Δρομολογητή D-Link με τον Η/Υ που ήταν αρχικά συνδεδεμένος στην ευρυζωνική σύνδεσή σας. Εάν έχετε συνδεθεί, στη συνέχεια κάντε κλικ στο κουμπί κλώνοποίηση MAC για την αντιγραφή της Διεύθυνσης MAC του υπολογιστή σας στο Δρομολογητή D-Link.", //wwa_msg_set_dhcp
	"Για τη ρύθμιση αυτής της σύνδεσης, θα χρειαστείτε ένα Όνομα χρήστη και έναν Κωδικό πρόσβασης από τον Πάροχο υπηρεσιών Internet. Εάν δεν διαθέτετε αυτές τις πληροφορίες, επικοινωνήστε με το ISP σας.", //wwa_msg_set_pppoe
	"Για τη ρύθμιση αυτής της σύνδεσης, θα χρειαστείτε ένα Όνομα χρήστη και έναν Κωδικό πρόσβασης από τον Πάροχο υπηρεσιών Internet. Θα χρειαστείτε επίσης μια διεύθυνση IP PPTP. Εάν δεν διαθέτετε αυτές τις πληροφορίες, επικοινωνήστε με το ISP σας.", //wwa_msg_set_pptp
	"Επιλέξτε αυτήν την επιλογή εάν ο Πάροχος υπηρεσιών Internet σάς παραχώρησε τις πληροφορίες της διεύθυνσης IP που έπρεπε να διαμορφωθούν χειροκίνητα.", //wwa_msg_sipa
	" Σημείωση: Μπορεί επίσης να χρειαστείτε ένα Όνομα κεντρικού υπολογιστή. Εάν δεν διαθέτετε ή δεν γνωρίζετε αυτές τις πληροφορίες, επικοινωνήστε με το ISP σας.", //wwa_note_hostname
	"Διεύθυνση πρωτεύοντος DNS", //wwa_pdns
	"Διεύθυνση IP διακομιστή PPTP (ενδέχεται να είναι η ίδια με της πύλης)", //wwa_pptp_svraddr
	"Διεύθυνση δευτερεύοντος DNS", //wwa_sdns
	"Δεν υπάρχει καταχώριση ή δεν γνωρίζω", //wwa_selectisp_not
	"Ρύθμιση σύνδεσης Ονόματος χρήστη και κωδικού πρόσβασης (L2TP)", //wwa_set_l2tp_title
	"Για τη ρύθμιση αυτής της σύνδεσης, θα χρειαστείτε μια ολοκληρωμένη λίστα πληροφοριών IP και έναν Κωδικό πρόσβασης από τον Πάροχο υπηρεσιών Internet. Εάν διαθέτετε σύνδεση στατικού IP και δεν έχετε αυτές τις πληροφορίες, επικοινωνήστε με το ISP σας.", //wwa_set_sipa_msg
	"Ρύθμιση σύνδεσης διεύθυνσης στατικού IP", //wwa_set_sipa_title
	"Ρύθμιση καλωδιακής σύνδεσης BigPond", //wwa_title_set_bigpond
	"Ρύθμιση σύνδεσης Ονόματος χρήστη και κωδικού πρόσβασης (PPPoE)", //wwa_title_set_pppoe
	"Ρύθμιση σύνδεσης Ονόματος χρήστη και κωδικού πρόσβασης (PPTP)", //wwa_title_set_pptp
	"Καλωσορίσατε στον Οδηγό ρύθμισης της D-Link", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Σύνδεση Ονόματος χρήστη / Κωδικού πρόσβασης (L2TP)", //wwa_wanmode_l2tp
	"Σύνδεση Ονόματος χρήστη / Κωδικού πρόσβασης (L2TP)", //wwa_wanmode_pppoe
	"Σύνδεση Ονόματος χρήστη / Κωδικού πρόσβασης (PPTP)", //wwa_wanmode_pptp
	"Σύνδεση διεύθυνσης στατικού IP", //wwa_wanmode_sipa
	"Ονοματοδοσία του ασύρματου δικτύου σας.", //wwz_wwl_intro_s2_1
	"Αναγνωριστικό ασύρματου δικτύου (SSID)", //wwz_wwl_intro_s2_1_1
	"(έως 32 χαρακτήρες)", //wwz_wwl_intro_s2_1_2
	"Δημιουργήστε έναν κωδικό πρόσβασης για το ασύρματο δίκτυό σας.", //wwz_wwl_intro_s2_2
	"Κωδικός πρόσβασης Wi-Fi", //wwz_wwl_intro_s2_2_1
	"(μεταξύ 8 και 63 χαρακτήρων)", //wwz_wwl_intro_s2_2_2
	"Ονομάστε το δίκτυό σας, χρησιμοποιώντας έως 32 χαρακτήρες.", //wwz_wwl_intro_s3_1
	"Βήμα 1: Καλωσορίσατε στον ΟΔΗΓΟ ΡΥΘΜΙΣΗΣ ΑΣΥΡΜΑΤΗΣ ΠΡΟΣΤΑΣΙΑΣ ΤΗΣ D-LINK", //wwz_wwl_title_s3
	"Άκυρη διεύθυνση IP διακομιστή PPTP", //YM108
	"Χρησιμοποιήστε τον ίδιο κωδικό πρόσβασης ασύρματης προστασίας στις ζώνες 2.4GHz και 5GHz", //wwl_SSP
	"Εκχωρήστε στο ασύρματο δίκτυό σας ένα όνομα χρήστη και έναν κωδικό πρόσβασης.", //wwz_wwl_intro_s0
	"Η 1η διεύθυνση του %s πρέπει να είναι ακέραια τιμή.", //MSG002
	"Η 2η διεύθυνση του %s πρέπει να είναι ακέραια τιμή.", //MSG003
	"Η 3η διεύθυνση του %s πρέπει να είναι ακέραια τιμή.", //MSG004
	"Η 4η διεύθυνση του %s πρέπει να είναι ακέραια τιμή.", //MSG005
	"Το %s είναι μη έγκυρη διεύθυνση.", //MSG006
	"Το %s δεν μπορεί να είναι μηδέν.", //MSG007
	"Η θύρα %s που καταχωρήθηκε δεν είναι έγκυρη.", //MSG008
	"Το καταχωρισμένο μυστικό %s δεν είναι έγκυρο.", //MSG009
	"Το %s δεν μπορεί να επιτρέπει την εισαγωγή σε IP αναύκλωσης βρόγχου ή IP πολλαπλής μετάδοσης (multicast) (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Εισαγάγετε μια άλλη τιμή %s.", //MSG012
	"Η τιμή %s πρέπει να είναι αριθμητική.", //MSG013
	"Το εύρος του %s είναι %1n ~ %2n.", //MSG014
	"Η τιμή του %s πρέπει να είναι άρτιος αριθμός.", //MSG015
	"Το Κλειδί δεν είναι έγκυρο. Το Κλειδί πρέπει να είναι ένας δεκαεξαδικός αριθμός 5 ή 10 χαρακτήρων. Εισάγατε:", //MSG016
	"Το Κλειδί δεν είναι έγκυρο. Το Κλειδί πρέπει να είναι ένας δεκαεξαδικός αριθμός 13 ή 26 χαρακτήρων. Εισάγατε:", //MSG017
	"Η 1η διεύθυνση του %s πρέπει να είναι δεκαεξαδική.", //MSG018
	"Η 2η διεύθυνση του %s πρέπει να είναι δεκαεξαδική.", //MSG019
	"Η 3η διεύθυνση του %s πρέπει να είναι δεκαεξαδική.", //MSG020
	"Η 4η διεύθυνση του %s πρέπει να είναι δεκαεξαδική.", //MSG021
	"Η 5η διεύθυνση του %s πρέπει να είναι δεκαεξαδική.", //MSG022
	"Η 6η διεύθυνση του %s πρέπει να είναι δεκαεξαδική.", //MSG023
	"Η 7η διεύθυνση του %s πρέπει να είναι δεκαεξαδική.", //MSG024
	"Η 8η διεύθυνση του %s πρέπει να είναι δεκαεξαδική.", //MSG025
	"Το 1ο εύρος του %s πρέπει να είναι μεταξύ", //MSG026
	"Το 2ο εύρος του %s πρέπει να είναι μεταξύ", //MSG027
	"Το 3ο εύρος του %s πρέπει να είναι μεταξύ", //MSG028
	"Το 4ο εύρος του %s πρέπει να είναι μεταξύ", //MSG029
	"Το 5ο εύρος του %s πρέπει να είναι μεταξύ", //MSG030
	"Το 6ο εύρος του %s πρέπει να είναι μεταξύ", //MSG031
	"Το 7ο εύρος του %s πρέπει να είναι μεταξύ", //MSG032
	"Το 8ο εύρος του %s πρέπει να είναι μεταξύ", //MSG033
	"Το %s δεν μπορεί να επιτρέπει την εισαγωγή IP ανακύκλωσης βρόγχου ( ::1 ).", //MSG034
	"Το %s δεν μπορεί να επιτρέπει την εισαγωγή IP πολλαπλής μετάδοσης (multicast) ( FFxx:0:0:0:0:0:0:2 or ffxx:0:0:0:0:0:0:2.", //MSG035
	"Άκυρη μετρική", //MSG043
	"Η μετρική τιμή πρέπει να είναι μεταξύ (1..16).", //ar_alert_3
	"Άκυρη μάσκα δικτύου.", //ar_alert_5
	"Το Κλειδί", //TEXT042_1
	" είναι εσφαλμένο, οι νομικοί χαρακτήρες είναι 0~9, A~F, ή a~f.", //TEXT042_2
	" Σημείωση: Μπορεί επίσης να χρειαστείτε ένα Όνομα υπηρεσίας. Εάν δεν διαθέτετε ή δεν γνωρίζετε αυτές τις πληροφορίες, επικοινωνήστε με το ISP σας.", //wwa_note_svcn
	"Υπολογιστήε πελάτης L2TP.", //wwa_msg_l2tp
	"Για τη ρύθμιση αυτής της σύνδεσης, θα χρειαστείτε ένα Όνομα χρήστη και έναν Κωδικό πρόσβασης από τον Πάροχο υπηρεσιών Internet. Θα χρειαστείτε επίσης μια διεύθυνση IP L2TP. Εάν δεν διαθέτετε αυτές τις πληροφορίες, επικοινωνήστε με το ISP σας.", //wwa_set_l2tp_msg
	"Για τη ρύθμιση αυτής της σύνδεσης, θα χρειαστείτε ένα Όνομα χρήστη και έναν Κωδικό πρόσβασης από τον Πάροχο υπηρεσιών Internet. Θα χρειαστείτε επίσης μια διεύθυνση IP Διακομιστή BigPond. Εάν δεν διαθέτετε αυτές τις πληροφορίες, επικοινωνήστε με το ISP σας", //wwa_msg_set_bigpond
	"Όνομα κεντρικού υπολογιστή", //_hostname
	"Ζώνη 2,4GHz", //GW_WLAN_RADIO_0_NAME
	"Ζώνη 5GHz", //GW_WLAN_RADIO_1_NAME
	"Ακολουθεί μια λεπτομερής σύνοψη των ασύρματων ρυθμίσεων ασφάλειάς σας. Εκτυπώστε αυτήν τη σελίδα ή καταγράψτε τις πληροφορίες σε κάποιο χαρτί, ώστε να μπορείτε να διαμορφώσετε τις σωστές ρυθμίσεις στις συσκευές Wi-Fi σας.", //wwl_intro_end
	"Αναμείνατε.", //_please_wait
	"Copyright &copy; 2014 D-Link Corporation. All rights reserved.", //_copyright
	"Σύνδεση", //_connect
	"Οδηγήστε με στις ρυθμίσεις σύνδεσης Internet", //ES_btn_guide_me
	"Ενεργοποίηση γραφικού ελέγχου ταυτότητας", //_graph_auth
	"D-LINK CORPORATION, INC | ΑΣΥΡΜΑΤΟΣ ΔΡΟΜΟΛΟΓΗΤΗΣ | ΑΡΧΙΚΗ", //TEXT000
	"Ο κωδικός πρόσβασης L2TP ΠΡΕΠΕΙ να καθορίζεται", //GW_WAN_L2TP_PASSWORD_INVALID
	"Δεν εντοπίστηκε internet, επιθυμείτε την επανεκκίνηση του οδηγού;", //mydlink_tx03
	"Ο κωδικός πρόσβασης δεν μπορεί να μείνει κενός.", //mydlink_tx04
	"Έλεγχος συνδεσιμότητας WAN.", //mydlink_tx05
	"δευτερόλεπτα.", //sec_left
	"Επανάληψη", //_retry
	"Διαθέτετε λογαριασμό mydlink;", //mydlink_tx06
	"Ναι, διαθέτω ήδη ένα λογαριασμό mydlink.", //mydlink_tx07
	"Όχι, επιθυμώ να εγγραφώ και να συνδεθώ με ένα νέο λογαριασμό mydlink.", //mydlink_tx08
	"Ηλεκτρονική διεύθυνση (Όνομα λογαριασμού)", //mydlink_tx09
	"Συμπληρώστε τις επιλογές για να ολοκληρωθεί η εγγραφή.", //mydlink_tx10
	"Επιβεβαίωση κωδικού πρόσβασης", //chk_pass
	"Επώνυμο", //Lname
	"Όνομα", //Fname
	"Αποδέχομαι τους όρους και τις προϋποθέσεις της mydlink.", //mydlink_tx12
	"Για να ολοκληρώσετε την εγγραφή mydlink, ελέγξτε τα μηνύματά σας στα Εισερχόμενα για οδηγίες επιβεβαίωσης.", //mydlink_tx13_1
	" Μετά την επιβεβαίωση της ηλετρονικής διεύθυνσή σας, κάντε κλικ στο κουμπί Σύνδεση.", //mydlink_tx13_2
	"Σύνδεση", //_login
	"Ok", //_ok
	"Αποθήκευση", //_save
	"Ορίστε δύο ίδιους κωδικούς πρόσβασης και επαναλάβετε", //_pwsame
	"Για να χρησιμοποιήσετε τις λειτουργίες του  <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> και του mydlink Lite app, χρειάζεστε ένα λογαριασμό με <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>.", //mydlink_reg_into_1
	"Εάν διαθέτετε ήδη λογαριασμό, επιλέξτε <strong>Ναι, διαθέτω λογαριασμό mydlink</strong> και κάντε κλικ στο Επόμενο για εγγραφή του δρομολογητή στο <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>.", //mydlink_reg_into_2
	"Εάν δεν διαθέτετε λογαριασμό, επιλέξτε <strong>Όχι, επιθυμώ να εγγραφώ και να συνδεθώ με ένα νέο λογαριασμό mydlink</strong> και κάντε κλικ στο Επόμενο για τη δημιουργία λογαριασμού.", //mydlink_reg_into_3
	" Εάν δεν επιθυμείτε να εγγραφείτε στην υπηρεσία mydlink, κάντε κλικ στο Ακύρωση.", //mydlink_reg_into_4_a
	"Αυτή η ηλεκτρονική διεύθυνση είναι συνδεδεμένη ήδη με ένα λογαριασμό mydlink. Προσπαθήστε με διαφορετική ηλεκτρονική διεύθυνση.", //mydlink_pop_01
	"Πρέπει να αποδεχτείτε τους όρους και τις προύποθέσεις για να συνεχίσετε.", //mydlink_pop_02
	"δεν πρέπει να είναι κενό.", //mydlink_pop_03
	"είναι άκυρο.", //mydlink_pop_04
	"Μπορείτε να χρησιμοποιήσετε την υπηρεσία mydlink με αυτήν τη συσκυεή", //mydlink_pop_05
	"Η σύνδεση απέτυχε", //mydlink_pop_06
	"εγγραφείτε", //_signup
	"Μετά την ολοκλήρωση της εγγραφής mydlink, η προεπιλεγμένη ρύθμιση PPPoE, L2TP, PPTP του δρομολογητή σας θα έχει ρυθμιστεί σε \"Πάντα ενεργοποιημένη\" . Εάν το  ISP σας χρεώσει για τη χρήση, μπορεί να επιθυμήσετε να επιλέξετε χεροκίνητα το \"Σύνδεση μέσω τηλεφώνου /Dial (Απομακρυσμένη)", //mydlink_pop_09
	"Δεν είναι δυνατή η σύνδεση", //mdl_errmsg_01
	"Αποστολή σύνδεσης", //mdl_errmsg_02
	"Δεν είναι δυνατή η αποστολή", //mdl_errmsg_03
	"Αποστολή εγγραφής", //mdl_errmsg_04
	"Δεν είναι δυνατή η αποστολή", //mdl_errmsg_05
	"Το SSID", //SSID_EMPTY_ERROR
	"Οι κωδικοί πρόσβασης που εισάγατε δεν είναι ίδιοι", //YM102
	"Ένας κωδικός πρόσβασης PPPoE ΠΡΕΠΕΙ να καθορίζεται", //GW_WAN_PPPoE_PASSWORD_INVALID
	"Ο λογαριασμός", //limit_pass_msg
	"Παράκαμψη", //_skip
	"Εάν δεν επιθυμείτε να εγγραφείτε στην υπηρεσία mydlink, κάντε κλικ στο Παράκαμψη.", //mydlink_reg_into_4
	"Αποθήκευση ασύρματης ρύθμισης (Wi-Fi)", //mydlink_WiFi_save
	"Russia PPTP (Dual Access)", //rus_wan_pptp
	"Russia PPTP (Dual Access) internet connection type", //rus_wan_pptp_01
	"Russia L2TP (Dual Access)", //rus_wan_l2tp
	"Russia L2TP (Dual Access) internet connection type", //rus_wan_l2tp_01
	"Russia PPPoE (Dual Access)", //rus_wan_pppoe
	"Russia PPPoE (Dual Access) internet connection type", //rus_wan_pppoe_02
	"Wan Physical Setting", //rus_wan_pppoe_03
	"Αυτή η συσκευή έχει δυνατότητα mydlink, η οποία προσφέρει απομακρυσμένη παρακολούθηση και διαχείριση του δικτύου σας μέσω του ιστοτόπου mydlink.com ή μέσω της εφαρμογής κινητού τηλεφώνου mydlink.", //_wz_mydlink_into_1
	"Θα έχετε τη δυνατότητα να ελέγχετε τις ταχύτητες δικτύου, να γνωρίζετε ποιοι χρήστες είναι συνδεδεμένοι, να προβάλλετε το ιστορικό περιήγησης συσκευών και να λαμβάνετε ειδοποιήσεις σχετικά με νέους χρήστες ή με απόπειρες εισβολής.", //_wz_mydlink_into_2
	"Μπορείτε να καταχωρήσετε αυτήν τη συσκευή με τον υπάρχοντα λογαριασμό σας στο mydlink. Εάν δεν έχετε λογαριασμό, μπορείτε να δημιουργήσετε έναν τώρα.", //_wz_mydlink_into_3
	"Ελέγξτε στο γραμματοκιβώτιό σας για λήψη μηνύματος ηλεκτρονικού ταχυδρομείου με οδηγίες επιβεβαίωσης.", //_wz_mydlink_email_1
	"Ο δρομολογητής ελέγχει τη συνδεσιμότητα στο Internet, περιμένετε.", //_chk_wanconn_msg_00
	"Would you like to skip mydlink registration?", //_wz_skip_mydlink
	"Metric value should be in between (1..15).", //ar_alert_3a
	"Server IP Address", //SERVER_IP_DESC
	"%s Gateway IP address %s must be within the WAN subnet.", //TEXT043
	"WAN", //WAN
	"SSID should be represent with ASCII character from code 32 to 126.", //ssid_ascii_range
	"IP Address should not be same as Default Gateway.", //ip_gateway_check
	"" //MAX
);
var _cancel=0;
var _clone=1;
var _dhcpconn=2;
var _ipaddr=3;
var _L2TP=4;
var _L2TPgw=5;
var _L2TPip=6;
var _L2TPsubnet=7;
var _Language=8;
var _macaddr=9;
var _next=10;
var _no=11;
var _optional=12;
var _password=13;
var _PPTPgw=14;
var _PPTPip=15;
var _PPTPsubnet=16;
var _prev=17;
var _pwsame_admin=18;
var _sdi_staticip=19;
var _subnet=20;
var _username=21;
var _verifypw=22;
var _wizquit=23;
var _yes=24;
var bwn_alert_17=25;
var bwn_AM=26;
var bwn_BPS=27;
var bws_CT_3=28;
var carriertype_ct_0=29;
var ES_auto_detect_desc=30;
var ES_auto_detect_failed_desc=31;
var ES_bookmark=32;
var ES_btn_try_again=33;
var ES_cable_lost_desc=34;
var ES_step_wifi_security=35;
var ES_title_s3=36;
var ES_title_s4=37;
var ES_title_s5=38;
var ES_title_s5_0=39;
var ES_title_s6=40;
var ES_title_s6_myd=41;
var ES_wwa_title_s1=42;
var GW_DHCP_CLIENT_CLIENT_NAME_INVALID=43;
var GW_WAN_DHCPPLUS_PASSWORD_INVALID=44;
var GW_WAN_DHCPPLUS_USERNAME_INVALID=45;
var GW_WAN_L2TP_USERNAME_INVALID=46;
var GW_WAN_PPTP_PASSWORD_INVALID=47;
var IPV6_TEXT2=48;
var KR3=49;
var KR48=50;
var manul_conn_01=51;
var manul_conn_02=52;
var manul_conn_03=53;
var manul_conn_04=54;
var manul_conn_05=55;
var manul_conn_06=56;
var manul_conn_07=57;
var manul_conn_08=58;
var manul_conn_09=59;
var manul_conn_10=60;
var manul_conn_11=61;
var manul_conn_12=62;
var manul_conn_13=63;
var manul_conn_14=64;
var manul_conn_15=65;
var manul_conn_16=66;
var manul_conn_17=67;
var manul_conn_18=68;
var manul_conn_19=69;
var manul_conn_20=70;
var manul_conn_21=71;
var manul_conn_22=72;
var manul_conn_23=73;
var manul_conn_24=74;
var manul_conn_25=75;
var mydlink_tx01=76;
var mydlink_tx02=77;
var PPP_USERNAME_EMPTY=78;
var pppoe_plus_dail=79;
var S493=80;
var save_settings=81;
var save_wait=82;
var sd_FWV=83;
var TA2=84;
var TA3=85;
var up_tz_00=86;
var up_tz_01=87;
var up_tz_02=88;
var up_tz_03=89;
var up_tz_04=90;
var up_tz_05=91;
var up_tz_06=92;
var up_tz_07=93;
var up_tz_08=94;
var up_tz_09=95;
var up_tz_10=96;
var up_tz_11=97;
var up_tz_12=98;
var up_tz_13=99;
var up_tz_14=100;
var up_tz_15=101;
var up_tz_16=102;
var up_tz_17=103;
var up_tz_18=104;
var up_tz_19=105;
var up_tz_20=106;
var up_tz_21=107;
var up_tz_22=108;
var up_tz_23=109;
var up_tz_24=110;
var up_tz_25=111;
var up_tz_26=112;
var up_tz_27=113;
var up_tz_28=114;
var up_tz_29=115;
var up_tz_29b=116;
var up_tz_30=117;
var up_tz_31=118;
var up_tz_32=119;
var up_tz_33=120;
var up_tz_34=121;
var up_tz_35=122;
var up_tz_36=123;
var up_tz_37=124;
var up_tz_38=125;
var up_tz_39=126;
var up_tz_40=127;
var up_tz_41=128;
var up_tz_42=129;
var up_tz_43=130;
var up_tz_44=131;
var up_tz_45=132;
var up_tz_46=133;
var up_tz_47=134;
var up_tz_48=135;
var up_tz_49=136;
var up_tz_50=137;
var up_tz_51=138;
var up_tz_52=139;
var up_tz_53=140;
var up_tz_54=141;
var up_tz_55=142;
var up_tz_56=143;
var up_tz_57=144;
var up_tz_58=145;
var up_tz_59=146;
var up_tz_60=147;
var up_tz_61=148;
var up_tz_62=149;
var up_tz_63=150;
var up_tz_64=151;
var up_tz_65=152;
var up_tz_66=153;
var up_tz_67=154;
var up_tz_68=155;
var up_tz_69=156;
var up_tz_70=157;
var up_tz_71=158;
var up_tz_72=159;
var up_tz_73=160;
var up_tz_74=161;
var up_tz_75=162;
var up_tz_76=163;
var up_tz_77=164;
var up_tz_78=165;
var up_tz_79=166;
var up_tz_80=167;
var up_tz_81=168;
var up_tz_82=169;
var up_tz_83=170;
var up_tz_84=171;
var up_tz_85=172;
var up_tz_86=173;
var up_tz_87=174;
var up_tz_88=175;
var up_tz_89=176;
var up_tz_90=177;
var up_tz_91=178;
var up_tz_92=179;
var wwa_dnsset=180;
var wwa_gw=181;
var wwa_intro_s1=182;
var wwa_intro_s2=183;
var wwa_intro_s3=184;
var wwa_intro_wel=185;
var wwa_l2tp_svra=186;
var wwa_msg_dhcp=187;
var wwa_msg_ispnot=188;
var wwa_msg_pppoe=189;
var wwa_msg_pptp=190;
var wwa_msg_set_dhcp=191;
var wwa_msg_set_pppoe=192;
var wwa_msg_set_pptp=193;
var wwa_msg_sipa=194;
var wwa_note_hostname=195;
var wwa_pdns=196;
var wwa_pptp_svraddr=197;
var wwa_sdns=198;
var wwa_selectisp_not=199;
var wwa_set_l2tp_title=200;
var wwa_set_sipa_msg=201;
var wwa_set_sipa_title=202;
var wwa_title_set_bigpond=203;
var wwa_title_set_pppoe=204;
var wwa_title_set_pptp=205;
var wwa_title_wel=206;
var wwa_wanmode_bigpond=207;
var wwa_wanmode_l2tp=208;
var wwa_wanmode_pppoe=209;
var wwa_wanmode_pptp=210;
var wwa_wanmode_sipa=211;
var wwz_wwl_intro_s2_1=212;
var wwz_wwl_intro_s2_1_1=213;
var wwz_wwl_intro_s2_1_2=214;
var wwz_wwl_intro_s2_2=215;
var wwz_wwl_intro_s2_2_1=216;
var wwz_wwl_intro_s2_2_2=217;
var wwz_wwl_intro_s3_1=218;
var wwz_wwl_title_s3=219;
var YM108=220;
var wwl_SSP=221;
var wwz_wwl_intro_s0=222;
var MSG002=223;
var MSG003=224;
var MSG004=225;
var MSG005=226;
var MSG006=227;
var MSG007=228;
var MSG008=229;
var MSG009=230;
var MSG010=231;
var MSG012=232;
var MSG013=233;
var MSG014=234;
var MSG015=235;
var MSG016=236;
var MSG017=237;
var MSG018=238;
var MSG019=239;
var MSG020=240;
var MSG021=241;
var MSG022=242;
var MSG023=243;
var MSG024=244;
var MSG025=245;
var MSG026=246;
var MSG027=247;
var MSG028=248;
var MSG029=249;
var MSG030=250;
var MSG031=251;
var MSG032=252;
var MSG033=253;
var MSG034=254;
var MSG035=255;
var MSG043=256;
var ar_alert_3=257;
var ar_alert_5=258;
var TEXT042_1=259;
var TEXT042_2=260;
var wwa_note_svcn=261;
var wwa_msg_l2tp=262;
var wwa_set_l2tp_msg=263;
var wwa_msg_set_bigpond=264;
var _hostname=265;
var GW_WLAN_RADIO_0_NAME=266;
var GW_WLAN_RADIO_1_NAME=267;
var wwl_intro_end=268;
var _please_wait=269;
var _copyright=270;
var _connect=271;
var ES_btn_guide_me=272;
var _graph_auth=273;
var TEXT000=274;
var GW_WAN_L2TP_PASSWORD_INVALID=275;
var mydlink_tx03=276;
var mydlink_tx04=277;
var mydlink_tx05=278;
var sec_left=279;
var _retry=280;
var mydlink_tx06=281;
var mydlink_tx07=282;
var mydlink_tx08=283;
var mydlink_tx09=284;
var mydlink_tx10=285;
var chk_pass=286;
var Lname=287;
var Fname=288;
var mydlink_tx12=289;
var mydlink_tx13_1=290;
var mydlink_tx13_2=291;
var _login=292;
var _ok=293;
var _save=294;
var _pwsame=295;
var mydlink_reg_into_1=296;
var mydlink_reg_into_2=297;
var mydlink_reg_into_3=298;
var mydlink_reg_into_4_a=299;
var mydlink_pop_01=300;
var mydlink_pop_02=301;
var mydlink_pop_03=302;
var mydlink_pop_04=303;
var mydlink_pop_05=304;
var mydlink_pop_06=305;
var _signup=306;
var mydlink_pop_09=307;
var mdl_errmsg_01=308;
var mdl_errmsg_02=309;
var mdl_errmsg_03=310;
var mdl_errmsg_04=311;
var mdl_errmsg_05=312;
var SSID_EMPTY_ERROR=313;
var YM102=314;
var GW_WAN_PPPoE_PASSWORD_INVALID=315;
var limit_pass_msg=316;
var _skip=317;
var mydlink_reg_into_4=318;
var mydlink_WiFi_save=319;
var rus_wan_pptp=320;
var rus_wan_pptp_01=321;
var rus_wan_l2tp=322;
var rus_wan_l2tp_01=323;
var rus_wan_pppoe=324;
var rus_wan_pppoe_02=325;
var rus_wan_pppoe_03=326;
var _wz_mydlink_into_1=327;
var _wz_mydlink_into_2=328;
var _wz_mydlink_into_3=329;
var _wz_mydlink_email_1=330;
var _chk_wanconn_msg_00=331;
var _wz_skip_mydlink=332;
var ar_alert_3a=333;
var SERVER_IP_DESC=334;
var TEXT043=335;
var WAN=336;
var ssid_ascii_range=337;
var ip_gateway_check=338;