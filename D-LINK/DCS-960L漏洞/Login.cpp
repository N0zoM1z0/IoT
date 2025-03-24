int __fastcall Login(int a1)
{
  int v2; // $s0
  int v3; // $s2
  int v4; // $v0
  int v5; // $s3
  const char *v6; // $v0
  char *v7; // $v0
  int v8; // $a0
  char *v9; // $v0
  char *v10; // $v0
  const char *v11; // $s1
  char *v12; // $v0
  const char *v13; // $s1
  int v14; // $v0
  int v15; // $a0
  const char *v16; // $s4
  const char *v17; // $s1
  size_t v18; // $s3
  size_t v19; // $v0
  size_t v20; // $v0
  _BOOL4 v21; // $s1
  int v22; // $a0
  time_t v23; // $s3
  _QWORD *v24; // $v0
  int v25; // $s1
  int v26; // $v1
  bool v27; // dc
  _BOOL4 v28; // $v1
  int *v29; // $s4
  int v30; // $a1
  __pid_t v31; // $v0
  time_t v32; // $s1
  int v33; // $s1
  int v34; // $s1
  _QWORD v36[2]; // [sp+0h] [-14A30h] BYREF
  int v37[8]; // [sp+20h] [-14A10h] BYREF
  char v38; // [sp+40h] [-149F0h]
  _DWORD v39[8]; // [sp+44h] [-149ECh] BYREF
  char v40; // [sp+64h] [-149CCh]
  _DWORD v41[2]; // [sp+68h] [-149C8h] BYREF
  __int16 v42; // [sp+70h] [-149C0h]
  char v43; // [sp+72h] [-149BEh]
  _DWORD v44[4]; // [sp+74h] [-149BCh] BYREF
  char v45[128]; // [sp+84h] [-149ACh] BYREF
  _DWORD v46[8]; // [sp+104h] [-1492Ch] BYREF
  char v47; // [sp+124h] [-1490Ch]
  int v48; // [sp+128h] [-14908h] BYREF
  int v49; // [sp+12Ch] [-14904h]
  int v50; // [sp+130h] [-14900h]
  int v51; // [sp+134h] [-148FCh]
  _DWORD v52[8]; // [sp+138h] [-148F8h] BYREF
  char v53; // [sp+158h] [-148D8h]
  _DWORD v54[8]; // [sp+15Ch] [-148D4h] BYREF
  char v55; // [sp+17Ch] [-148B4h]
  _DWORD v56[13]; // [sp+180h] [-148B0h] BYREF
  char v57; // [sp+1B4h] [-1487Ch]
  _QWORD v58[10509]; // [sp+1B8h] [-14878h] BYREF
  const char *v59; // [sp+14A20h] [-10h]
  const char *v60; // [sp+14A24h] [-Ch]
  const char *v61; // [sp+14A28h] [-8h]

  v37[0] = 0;
  v37[1] = 0;
  v37[2] = 0;
  v37[3] = 0;
  v37[4] = 0;
  v37[5] = 0;
  v37[6] = 0;
  v37[7] = 0;
  v38 = 0;
  v39[0] = 0;
  v39[1] = 0;
  v39[2] = 0;
  v39[3] = 0;
  v39[4] = 0;
  v39[5] = 0;
  v39[6] = 0;
  v39[7] = 0;
  v40 = 0;
  v41[0] = 0;
  v41[1] = 0;
  v42 = 0;
  v43 = 0;
  v44[0] = 0;
  v44[1] = 0;
  v44[2] = 0;
  v44[3] = 0;
  v46[0] = 0;
  v46[1] = 0;
  v46[2] = 0;
  v46[3] = 0;
  v46[4] = 0;
  v46[5] = 0;
  v46[6] = 0;
  v46[7] = 0;
  v47 = 0;
  v2 = ixmlDocument_createDocument();
  v3 = ixmlDocument_createElement(v2, "LoginResponse");
  ixmlElement_setAttribute(v3, "xmlns", "http://purenetworks.com/HNAP1/");
  ixmlNode_appendChild(v2, v3);
  v4 = ixmlGetElementByTag(a1, "Login");
  v5 = v4;
  if ( !v4 )
  {
    ixmlAppendNewElement(v2, v3, "LoginResult", "failed");
    v15 = v2;
    goto LABEL_49;
  }
  v6 = (const char *)ixmlGetElementValueByTag(v4, "Action");
  if ( v6 )
    strcpy((char *)v44, v6);
  fprintf(stderr, "Login action: %s\n", (const char *)v44);
  memset(v58, 0, sizeof(v58));
  SIReadBin(63, v58, 84072);
  if ( strcasecmp((const char *)v44, "login") )
  {
    if ( !strcasecmp((const char *)v44, "request") && HIBYTE(v58[0]) && BYTE4(v58[4]) )
    {
      v32 = time(0);
      v31 = getpid();
      srand(v31 + v32);
      v33 = rand();
      ixmlAppendNewElement(v2, v3, "LoginResult", "OK");
      ixmlAppendNewElement(v2, v3, "Challenge", (char *)&v58[4] + 4);
      ixmlAppendNewElement(v2, v3, "Cookie", (char *)&v58[9] + 12 * (v33 % 1000));
      ixmlAppendNewElement(v2, v3, "PublicKey", v58);
      v15 = v2;
    }
    else
    {
      ixmlAppendNewElement(v2, v3, "LoginResult", "failed");
      v15 = v2;
    }
    goto LABEL_49;
  }
  v7 = getenv("COOKIE");
  if ( v7 && *v7 )
  {
    memset(v45, 0, sizeof(v45));
    v9 = getenv("COOKIE");
    snprintf(v45, 0x80u, "%s", v9);
    v10 = strstr(v45, "uid=");
    if ( v10 )
    {
      v11 = v10 + 4;
      v12 = strchr(v10 + 4, 59);
      if ( v12 )
        *v12 = 0;
      snprintf((char *)v41, 0xBu, v11);
      v13 = (const char *)&v58[9];
    }
    else
    {
      snprintf((char *)v41, 0xBu, v45);
      v13 = (const char *)&v58[9];
    }
    while ( 1 )
    {
      v14 = strcmp((const char *)v41, v13);
      v13 += 12;
      if ( !v14 )
        break;
      v8 = v2;
      if ( v13 == (const char *)&v58[1509] )
        goto LABEL_15;
    }
    v22 = v2;
    if ( HIBYTE(v58[0]) )
    {
      if ( BYTE4(v58[4]) )
      {
        v16 = (const char *)ixmlGetElementValueByTag(v5, "Username");
        v17 = (const char *)ixmlGetElementValueByTag(v5, "LoginPassword");
        if ( v16 )
        {
          strcpy((char *)v37, v16);
          if ( !strcmp((const char *)v37, "Admin") )
            snprintf((char *)v37, 0x20u, "%s", "admin");
        }
        if ( v17 )
          strcpy((char *)v39, v17);
        v59 = (const char *)v37;
        fprintf(stderr, "username: %s\n", (const char *)v37);
        v61 = (const char *)v39;
        fprintf(stderr, "loginPassword: %s\n", (const char *)v39);
        v56[0] = 0;
        v56[1] = 0;
        v56[2] = 0;
        v56[3] = 0;
        v56[4] = 0;
        v56[5] = 0;
        v56[6] = 0;
        v56[7] = 0;
        v56[8] = 0;
        v56[9] = 0;
        v56[10] = 0;
        v56[11] = 0;
        v56[12] = 0;
        v57 = 0;
        v52[0] = 0;
        v52[1] = 0;
        v52[2] = 0;
        v52[3] = 0;
        v52[4] = 0;
        v52[5] = 0;
        v52[6] = 0;
        v52[7] = 0;
        v53 = 0;
        v54[0] = 0;
        v54[1] = 0;
        v54[2] = 0;
        v54[3] = 0;
        v54[4] = 0;
        v54[5] = 0;
        v54[6] = 0;
        v54[7] = 0;
        v55 = 0;
        v48 = 0;
        v49 = 0;
        v50 = 0;
        v51 = 0;
        usrInit(0);
        usrGetPass(v59, v54, 33);
        usrFree();
        v60 = (const char *)v58;
        sprintf((char *)v56, "%s%s", (const char *)v58, (const char *)v54);
        v59 = (char *)&v58[4] + 4;
        fprintf(stderr, "My challenge: %s\n", (const char *)&v58[4] + 4);
        fprintf(stderr, "My public_key: %s\n", v60);
        fprintf(stderr, "My password: %s\n", (const char *)v54);
        v18 = strlen(v59);
        v19 = strlen((const char *)v56);
        hmac_md5(v59, v18, v56, v19, &v48);
        sprintf((char *)v46, "%08X%08X%08X%08X", v48, v49, v50, v51);
        fprintf(stderr, "My private_key: %s\n", (const char *)v46);
        v48 = 0;
        v49 = 0;
        v50 = 0;
        v51 = 0;
        v60 = (const char *)strlen(v59);
        v20 = strlen((const char *)v46);
        hmac_md5(v59, v60, v46, v20, &v48);
        sprintf((char *)v52, "%08X%08X%08X%08X", v48, v49, v50, v51);
        fprintf(stderr, "My login_password: %s\n", (const char *)v52);
        v21 = strcmp(v61, (const char *)v52) == 0;
        fprintf(stderr, "Check authStatus: %d\n", v21);
        v22 = v2;
        if ( v21 )
        {
          v23 = time(0);
          if ( HIBYTE(v58[1509])
            && BYTE4(v58[1513])
            && v23 - LODWORD(v58[1515]) < 301
            && (v24 = &v58[1524], v23 >= SLODWORD(v58[1515])) )
          {
            v25 = 1;
            while ( 1 )
            {
              v26 = *((_DWORD *)v24 + 1);
              if ( !HIBYTE(v58[9 * v25 + 1509]) )
                break;
              if ( !BYTE4(v58[9 * v25 + 1513]) )
                break;
              v27 = v23 - v26 >= 301;
              v28 = v23 < v26;
              if ( v27 )
                break;
              ++v25;
              if ( v28 )
              {
                --v25;
                break;
              }
              v24 += 9;
              if ( v25 == 1000 )
              {
                ixmlAppendNewElement(v2, v3, "LoginResult", "failed");
                v15 = v2;
                goto LABEL_49;
              }
            }
          }
          else
          {
            v25 = 0;
          }
          snprintf((char *)&v58[9 * v25 + 1509], 0x23u, "%s", (const char *)v46);
          snprintf((char *)&v58[9 * v25 + 1513] + 4, 0xBu, "%s", (const char *)v41);
          v29 = &v37[18 * v25];
          *((_QWORD *)v29 + 1566) = v23;
          *((_BYTE *)v29 + 12544) = 0;
          if ( strcmp((const char *)v37, "admin") )
            BYTE1(v36[9 * v25 + 1572]) = 1;
          else
            BYTE1(v36[9 * v25 + 1572]) = 0;
          SIWriteBin(63, v58, 84072);
          ixmlAppendNewElement(v2, v3, "LoginResult", "success");
          v15 = v2;
          goto LABEL_49;
        }
      }
      v30 = v3;
    }
    else
    {
      v30 = v3;
    }
    ixmlAppendNewElement(v22, v30, "LoginResult", "failed");
    v15 = v2;
    goto LABEL_49;
  }
  ixmlAppendNewElement(v2, v3, "LoginResult", "failed");
  v8 = v2;
LABEL_15:
  ixmlAppendNewElement(v8, v3, "LoginResult", "failed");
  v15 = v2;
LABEL_49:
  v34 = ixmlNode_cloneNode(v15, 1);
  ixmlDocument_free(v2);
  return v34;
}