-- DROP USER ORIGINAL;

-- CREATE USER ORIGINAL
-- IDENTIFIED BY <password>;

CREATE TABLE "ORIGINAL"."MEC_ANALI_RESP" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MEC_ANALI_RESP_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_AQUISICAO" NUMBER, 
	"NOME" VARCHAR2(50 CHAR), 
	"ANALISTA" VARCHAR2(50 CHAR), 
	"AREA_DEST" VARCHAR2(50 CHAR), 
	"AREA_DESTINO" VARCHAR2(50 CHAR), 
	"ETAPA_PROC_AQUI" VARCHAR2(255 CHAR), 
	"DIAS" NUMBER, 
	"DT_ANALISTA" TIMESTAMP (6), 
	"OBS_STATUS_PROC" VARCHAR2(4000 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MEC_ANLI_RESP_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MEC_ANALI_RESP" ADD CONSTRAINT "MEC_ANALI_RESP_FK_COD_AQUISICAO" FOREIGN KEY ("COD_AQUISICAO")
	  REFERENCES "ORIGINAL"."MEC_AQUISICAO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MEC_ANALI_RESP" 
    after update or delete on mec_anali_resp   
    for each row   
declare   
    t varchar2(128) := 'MEC_ANALI_RESP';   
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);   
begin   
if updating then   
    if(:old.id is null and :new.id is not null) or   
        (:old.id is not null and :new.id is null) or   
        :old.id != :new.id then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);   
    end if;   
   
    if(:old.cod_aquisicao is null and :new.cod_aquisicao is not null) or   
        (:old.cod_aquisicao is not null and :new.cod_aquisicao is null) or   
        :old.cod_aquisicao != :new.cod_aquisicao then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'COD_AQUISICAO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_aquisicao, :new.cod_aquisicao);   
     end if;   
  
    if(:old.nome is null and :new.nome is not null) or   
        (:old.nome is not null and :new.nome is null) or   
        :old.nome != :new.nome then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'NOME', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.nome, :new.nome);   
     end if;   
   
    if(:old.analista is null and :new.analista is not null) or   
        (:old.analista is not null and :new.analista is null) or   
        :old.analista != :new.analista then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'ANALISTA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.analista, :new.analista);   
     end if;   
   
    if(:old.dias is null and :new.dias is not null) or   
        (:old.dias is not null and :new.dias is null) or   
        :old.dias != :new.dias then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'DIAS', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.dias, :new.dias);   
     end if;   
 
    if(:old.obs_status_proc is null and :new.obs_status_proc is not null) or   
        (:old.obs_status_proc is not null and :new.obs_status_proc is null) or   
        :old.obs_status_proc != :new.obs_status_proc then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'OBS_STATUS_PROC', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obs_status_proc, :new.obs_status_proc);   
     end if;   
 
      if(:old.area_destino is null and :new.area_destino is not null) or   
        (:old.area_destino is not null and :new.area_destino is null) or   
        :old.area_dest != :new.area_dest then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'AREA_DESTINO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.area_destino, :new.area_destino);   
     end if;   
   
    if(:old.area_dest is null and :new.area_dest is not null) or   
        (:old.area_dest is not null and :new.area_dest is null) or   
        :old.area_dest != :new.area_dest then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'AREA_DEST', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.area_dest, :new.area_dest);   
     end if;   
   
    if(:old.dt_analista is null and :new.dt_analista is not null) or   
        (:old.dt_analista is not null and :new.dt_analista is null) or   
        :old.dt_analista != :new.dt_analista then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
        ) values (   
          mec_history_seq.nextval, t, 'DT_ANALISTA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_analista, :new.dt_analista);   
    end if;   
   
end if;   
   
if deleting then   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'COD_AQUISICAO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_aquisicao, :new.cod_aquisicao);   
	   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'NOME', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.nome, :new.nome);   
	   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'ANALISTA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.analista, :new.analista);   
	   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'DIAS', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.dias, :new.dias);   
 
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'AREA_DESTINO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.area_destino, :new.area_destino);   
 
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'AREA_DEST', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.area_dest, :new.area_dest);   
    
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
    ) values (   
        mec_history_seq.nextval, t, 'DT_ANALISTA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_analista, :new.dt_analista);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'OBS_STATUS_PROC', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obs_status_proc, :new.obs_status_proc);   
 
end if;   
end aud_mec_anali_resp; 

/
ALTER TRIGGER "ORIGINAL"."AUD_MEC_ANALI_RESP" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MEC_ANALI_RESP_BIU" 
    before insert or update  
    on mec_anali_resp 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mec_anali_resp_biu; 

/
ALTER TRIGGER "ORIGINAL"."MEC_ANALI_RESP_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MEC_ANLI_RESP_ID_PK" ON "ORIGINAL"."MEC_ANALI_RESP" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MEC_AQUISICAO" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MEC_AQUISICAO_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"NUM_PROCESSO_SEI" VARCHAR2(20 CHAR), 
	"DT_ENTRADA_DLOG" TIMESTAMP (6), 
	"DT_INSTAURA_PROC" TIMESTAMP (6), 
	"AREA_DEMANDANTE" VARCHAR2(255 CHAR), 
	"NUM_PORTARIA" VARCHAR2(255 CHAR), 
	"NUM_DFD" VARCHAR2(255 CHAR), 
	"PCA" VARCHAR2(10 CHAR), 
	"NUM_CONTRAT_PCA" VARCHAR2(255 CHAR), 
	"FUND_LEGAL" VARCHAR2(255 CHAR), 
	"MODALIDADE" VARCHAR2(255 CHAR), 
	"PREGAO_ELETRON" VARCHAR2(10 CHAR), 
	"MAPA_RISCO" VARCHAR2(255 CHAR), 
	"ETP" VARCHAR2(255 CHAR), 
	"VL_ESTIMADO" NUMBER, 
	"TR_PROJ_BASICO" VARCHAR2(255 CHAR), 
	"TIPO_CONTRATO" VARCHAR2(255 CHAR), 
	"DT_CONCLUSAO_LICIT" TIMESTAMP (6), 
	"STATUS_LICIT" VARCHAR2(30 CHAR), 
	"OBS" VARCHAR2(4000 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MEC_AQUISICAO_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MEC_AQUISICAO" 
    after update or delete on mec_aquisicao   
    for each row   
declare   
    t varchar2(128) := 'MEC_AQUISICAO';   
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);   
begin   
if updating then   
    if(:old.id is null and :new.id is not null) or   
        (:old.id is not null and :new.id is null) or   
        :old.id != :new.id then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);   
    end if;   
   
    if(:old.num_processo_sei is null and :new.num_processo_sei is not null) or   
        (:old.num_processo_sei is not null and :new.num_processo_sei is null) or   
        :old.num_processo_sei != :new.num_processo_sei then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'NUM_PROCESSO_SEI', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_processo_sei, :new.num_processo_sei);   
    end if;   
  
    if(:old.dt_entrada_dlog is null and :new.dt_entrada_dlog is not null) or   
        (:old.dt_entrada_dlog is not null and :new.dt_entrada_dlog is null) or   
        :old.dt_entrada_dlog != :new.dt_entrada_dlog then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
        ) values (   
          mec_history_seq.nextval, t, 'DT_ENTRADA_DLOG', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_entrada_dlog, :new.dt_entrada_dlog);   
    end if;   
 
    if(:old.dt_instaura_proc is null and :new.dt_instaura_proc is not null) or   
        (:old.dt_instaura_proc is not null and :new.dt_instaura_proc is null) or   
        :old.dt_instaura_proc != :new.dt_instaura_proc then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
        ) values (   
          mec_history_seq.nextval, t, 'DT_INSTAURA_PROC', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_instaura_proc, :new.dt_instaura_proc);   
    end if;   
 
    if(:old.area_demandante is null and :new.area_demandante is not null) or   
        (:old.area_demandante is not null and :new.area_demandante is null) or   
        :old.area_demandante != :new.area_demandante then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'AREA_DEMANDANTE', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.area_demandante, :new.area_demandante);   
    end if;   
   
    if(:old.num_dfd is null and :new.num_dfd is not null) or   
        (:old.num_dfd is not null and :new.num_dfd is null) or   
        :old.num_dfd != :new.num_dfd then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'NUM_DFD', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_dfd, :new.num_dfd);   
    end if;   
  
   
    if(:old.num_portaria is null and :new.num_portaria is not null) or   
        (:old.num_portaria is not null and :new.num_portaria is null) or   
        :old.num_portaria != :new.num_portaria then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'NUM_PORTARIA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_portaria, :new.num_portaria);   
    end if;   
  
    if(:old.fund_legal is null and :new.fund_legal is not null) or   
        (:old.fund_legal is not null and :new.fund_legal is null) or   
        :old.fund_legal != :new.fund_legal then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'FUND_LEGAL', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.fund_legal, :new.fund_legal);   
    end if;   
   
    if(:old.modalidade is null and :new.modalidade is not null) or   
        (:old.modalidade is not null and :new.modalidade is null) or   
        :old.modalidade != :new.modalidade then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'MODALIDADE', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.modalidade, :new.modalidade);   
    end if;   
  
    if(:old.pregao_eletron is null and :new.pregao_eletron is not null) or   
        (:old.pregao_eletron is not null and :new.pregao_eletron is null) or   
        :old.pregao_eletron != :new.pregao_eletron then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'PREGAO_ELETRON', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.pregao_eletron, :new.pregao_eletron);   
    end if;   
   
    if(:old.mapa_risco is null and :new.mapa_risco is not null) or   
        (:old.mapa_risco is not null and :new.mapa_risco is null) or   
        :old.mapa_risco != :new.mapa_risco then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'MAPA_RISCO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.mapa_risco, :new.mapa_risco);   
    end if;   
   
    if(:old.etp is null and :new.etp is not null) or   
        (:old.etp is not null and :new.etp is null) or   
        :old.etp != :new.etp then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'ETP', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.etp, :new.etp);   
    end if;   
   
    if(:old.tr_proj_basico is null and :new.tr_proj_basico is not null) or   
        (:old.tr_proj_basico is not null and :new.tr_proj_basico is null) or   
        :old.tr_proj_basico != :new.tr_proj_basico then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'TR_PROJ_BASICO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.tr_proj_basico, :new.tr_proj_basico);   
    end if;   
  
    if(:old.num_contrat_pca is null and :new.num_contrat_pca is not null) or   
        (:old.num_contrat_pca is not null and :new.num_contrat_pca is null) or   
        :old.num_contrat_pca != :new.num_contrat_pca then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'NUM_CONTRAT_PCA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_contrat_pca, :new.num_contrat_pca);   
    end if;   
   
    if(:old.vl_estimado is null and :new.vl_estimado is not null) or   
        (:old.vl_estimado is not null and :new.vl_estimado is null) or   
        :old.vl_estimado != :new.vl_estimado then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'VL_ESTIMADO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.vl_estimado, :new.vl_estimado);   
    end if;   
  
    if(:old.tipo_contrato is null and :new.tipo_contrato is not null) or   
        (:old.tipo_contrato is not null and :new.tipo_contrato is null) or   
        :old.tipo_contrato != :new.tipo_contrato then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'TIPO_CONTRATO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.tipo_contrato, :new.tipo_contrato);   
    end if;   
   
    if(:old.dt_conclusao_licit is null and :new.dt_conclusao_licit is not null) or    
        (:old.dt_conclusao_licit is not null and :new.dt_conclusao_licit is null) or    
        :old.dt_conclusao_licit != :new.dt_conclusao_licit then    
        insert into mec_history (    
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts    
        ) values (    
          mec_history_seq.nextval, t, 'DT_CONCLUSAO_LICIT', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_conclusao_licit, :new.dt_conclusao_licit);    
    end if;    
 
    if(:old.status_licit is null and :new.status_licit is not null) or    
        (:old.status_licit is not null and :new.status_licit is null) or    
        :old.status_licit != :new.status_licit then    
        insert into mec_history (    
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc    
        ) values (    
          mec_history_seq.nextval, t, 'STATUS_LICIT', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.status_licit, :new.status_licit);    
    end if;   
 
    if(:old.obs is null and :new.obs is not null) or   
        (:old.obs is not null and :new.obs is null) or   
        :old.obs != :new.obs then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'OBS', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obs, :new.obs);   
    end if;   
  
end if;   
   
if deleting then   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'NUM_PROCESSO_SEI', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_processo_sei, :new.num_processo_sei);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
    ) values (   
        mec_history_seq.nextval, t, 'DT_ENTRADA_DLOG', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_entrada_dlog, :new.dt_entrada_dlog);  
 
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
    ) values (   
        mec_history_seq.nextval, t, 'DT_INSTAURA_PROC', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_instaura_proc, :new.dt_instaura_proc);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'AREA_DEMANDANTE', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.area_demandante, :new.area_demandante);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'NUM_DFD', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_dfd, :new.num_dfd);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'NUM_PORTARIA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_portaria, :new.num_portaria);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'FUND_LEGAL', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.fund_legal, :new.fund_legal);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'MODALIDADE', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.modalidade, :new.modalidade);   
    
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'PREGAO_ELETRON', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.pregao_eletron, :new.pregao_eletron);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'MAPA_RISCO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.mapa_risco, :new.mapa_risco);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'ETP', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.etp, :new.etp);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'TR_PROJ_BASICO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.tr_proj_basico, :new.tr_proj_basico);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'NUM_CONTRAT_PCA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_contrat_pca, :new.num_contrat_pca);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'VL_ESTIMADO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_estimado, :new.vl_estimado);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'TIPO_CONTRATO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.tipo_contrato, :new.tipo_contrato);   
 
    insert into mec_history (    
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts    
    ) values (    
        mec_history_seq.nextval, t, 'DT_CONCLUSAO_LICIT', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_conclusao_licit, :new.dt_conclusao_licit);    
 
    insert into mec_history (    
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc    
    ) values (    
        mec_history_seq.nextval, t, 'STATUS_LICIT', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.status_licit, :new.status_licit);    
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'OBS', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obs, :new.obs);   
  
end if;   
end aud_mec_aquisicao; 

/
ALTER TRIGGER "ORIGINAL"."AUD_MEC_AQUISICAO" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MEC_AQUISICAO_BIU" 
    before insert or update  
    on mec_aquisicao 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mec_aquisicao_biu; 

/
ALTER TRIGGER "ORIGINAL"."MEC_AQUISICAO_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MEC_AQUISICAO_ID_PK" ON "ORIGINAL"."MEC_AQUISICAO" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MEC_CONTRATO" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MEC_CONTRATO_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_PROCEXEC" NUMBER, 
	"NUM_CONTRATO" VARCHAR2(20 CHAR), 
	"RAZAO_SOC_EST" VARCHAR2(255 CHAR), 
	"CNPJ" VARCHAR2(18 CHAR), 
	"RAZAO_SOC_NAC" VARCHAR2(255 CHAR), 
	"DT_VIG_INIC_CONTR" TIMESTAMP (6), 
	"DT_VIG_FINAL_CONTR" TIMESTAMP (6), 
	"TIPO_CONTRATO" VARCHAR2(50 CHAR), 
	"VL_CONTRATO" NUMBER, 
	"VL_CONTRATO_EST" NUMBER, 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MEC_CONTRATO_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MEC_CONTRATO" ADD CONSTRAINT "MEC_CONTRATO_FK_MEC_PROCEXEC" FOREIGN KEY ("COD_PROCEXEC")
	  REFERENCES "ORIGINAL"."MEC_PROCEXEC" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MEC_CONTRATO" 
    after update or delete on mec_contrato   
    for each row   
declare   
    t varchar2(128) := 'MEC_CONTRATO';   
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);   
begin   
if updating then   
    if(:old.id is null and :new.id is not null) or   
        (:old.id is not null and :new.id is null) or   
        :old.id != :new.id then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);   
    end if;   
   
    if(:old.cod_procexec is null and :new.cod_procexec is not null) or   
        (:old.cod_procexec is not null and :new.cod_procexec is null) or   
        :old.cod_procexec != :new.cod_procexec then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'COD_PROCEXEC', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_procexec, :new.cod_procexec);   
     end if;   
   
    if(:old.num_contrato is null and :new.num_contrato is not null) or   
        (:old.num_contrato is not null and :new.num_contrato is null) or   
        :old.num_contrato != :new.num_contrato then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'NUM_CONTRATO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_contrato, :new.num_contrato);   
     end if;   
  
    if(:old.razao_soc_est is null and :new.razao_soc_est is not null) or   
        (:old.razao_soc_est is not null and :new.razao_soc_est is null) or   
        :old.razao_soc_est != :new.razao_soc_est then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'RAZAO_SOC_EST', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.razao_soc_est, :new.razao_soc_est);   
     end if;   
   
    if(:old.razao_soc_nac is null and :new.razao_soc_nac is not null) or   
        (:old.razao_soc_nac is not null and :new.razao_soc_nac is null) or   
        :old.razao_soc_nac != :new.razao_soc_nac then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'RAZAO_SOC_NAC', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.razao_soc_nac, :new.razao_soc_nac);   
     end if;   
   
    if(:old.cnpj is null and :new.cnpj is not null) or   
        (:old.cnpj is not null and :new.cnpj is null) or   
        :old.cnpj != :new.cnpj then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'CNPJ', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.cnpj, :new.cnpj);   
     end if;   
  
    if(:old.dt_vig_inic_contr is null and :new.dt_vig_inic_contr is not null) or   
        (:old.dt_vig_inic_contr is not null and :new.dt_vig_inic_contr is null) or   
        :old.dt_vig_inic_contr != :new.dt_vig_inic_contr then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
        ) values (   
          mec_history_seq.nextval, t, 'DT_VIG_INIC_CONTR', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_vig_inic_contr, :new.dt_vig_inic_contr);   
     end if;   
    
    if(:old.dt_vig_final_contr is null and :new.dt_vig_final_contr is not null) or   
        (:old.dt_vig_final_contr is not null and :new.dt_vig_final_contr is null) or   
        :old.dt_vig_final_contr != :new.dt_vig_final_contr then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
        ) values (   
          mec_history_seq.nextval, t, 'DT_VIG_FINAL_CONTR', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_vig_final_contr, :new.dt_vig_final_contr);   
     end if;   
  
    if(:old.tipo_contrato is null and :new.tipo_contrato is not null) or   
        (:old.tipo_contrato is not null and :new.tipo_contrato is null) or   
        :old.tipo_contrato != :new.tipo_contrato then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'TIPO_CONTRATO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.tipo_contrato, :new.tipo_contrato);   
     end if;   
    
	if(:old.vl_contrato is null and :new.vl_contrato is not null) or   
        (:old.vl_contrato is not null and :new.vl_contrato is null) or   
        :old.vl_contrato != :new.vl_contrato then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'VL_CONTRATO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_contrato, :new.vl_contrato);   
    end if;   
  
    if(:old.vl_contrato_est is null and :new.vl_contrato_est is not null) or   
        (:old.vl_contrato_est is not null and :new.vl_contrato_est is null) or   
        :old.vl_contrato_est != :new.vl_contrato_est then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'VL_CONTRATO_EST', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_contrato_est, :new.vl_contrato_est);   
    end if;   
  
end if;   
   
if deleting then   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'COD_PROCEXEC', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_procexec, :new.cod_procexec);   
	   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'NUM_CONTRATO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_contrato, :new.num_contrato);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'RAZAO_SOC_EST', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.razao_soc_est, :new.razao_soc_est);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'RAZAO_SOC_NAC', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.razao_soc_nac, :new.razao_soc_nac);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'CNPJ', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.cnpj, :new.cnpj);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
    ) values (   
        mec_history_seq.nextval, t, 'DT_VIG_INIC_CONTR', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_vig_inic_contr, :new.dt_vig_inic_contr);   
    		   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
    ) values (   
        mec_history_seq.nextval, t, 'DT_VIG_FINAL_CONTR', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_vig_final_contr, :new.dt_vig_final_contr);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'TIPO_CONTRATO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.tipo_contrato, :new.tipo_contrato);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'VL_CONTRATO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_contrato, :new.vl_contrato);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'VL_CONTRATO_EST', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_contrato_est, :new.vl_contrato_est);   
	 	   
end if;   
end aud_mec_contrato;   

/
ALTER TRIGGER "ORIGINAL"."AUD_MEC_CONTRATO" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MEC_CONTRATO_BIU" 
    before insert or update  
    on mec_contrato 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mec_contrato_biu; 

/
ALTER TRIGGER "ORIGINAL"."MEC_CONTRATO_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MEC_CONTRATO_ID_PK" ON "ORIGINAL"."MEC_CONTRATO" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MEC_HISTORY" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MEC_HISTORY_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"TABLE_NAME" VARCHAR2(128 CHAR), 
	"COLUMN_NAME" VARCHAR2(128 CHAR), 
	"ACTION" VARCHAR2(1 CHAR), 
	"ACTION_DATE" TIMESTAMP (6), 
	"ACTION_BY" VARCHAR2(255 CHAR), 
	"DATA_TYPE" VARCHAR2(255 CHAR), 
	"PK1" NUMBER, 
	"TAB_ROW_VERSION" NUMBER, 
	"OLD_VC" VARCHAR2(4000 CHAR), 
	"NEW_VC" VARCHAR2(4000 CHAR), 
	"OLD_NUMBER" NUMBER, 
	"NEW_NUMBER" NUMBER, 
	"OLD_DATE" TIMESTAMP (6), 
	"NEW_DATE" TIMESTAMP (6), 
	"OLD_TS" TIMESTAMP (6), 
	"NEW_TS" TIMESTAMP (6), 
	"OLD_CLOB" CLOB, 
	"NEW_CLOB" CLOB, 
	"OLD_BLOB" BLOB, 
	"NEW_BLOB" BLOB, 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MEC_HISTORY_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "APEX_3775593283083513" 
 LOB ("OLD_CLOB") STORE AS SECUREFILE (
  TABLESPACE "APEX_3775593283083513" ENABLE STORAGE IN ROW 4000 CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) 
 LOB ("NEW_CLOB") STORE AS SECUREFILE (
  TABLESPACE "APEX_3775593283083513" ENABLE STORAGE IN ROW 4000 CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) 
 LOB ("OLD_BLOB") STORE AS SECUREFILE (
  TABLESPACE "APEX_3775593283083513" ENABLE STORAGE IN ROW 4000 CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) 
 LOB ("NEW_BLOB") STORE AS SECUREFILE (
  TABLESPACE "APEX_3775593283083513" ENABLE STORAGE IN ROW 4000 CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MEC_HISTORY_BIU" 
    before insert or update   
    on mec_history  
    for each row  
begin  
    if inserting then  
        :new.created := systimestamp;  
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);  
    end if;  
    :new.updated := systimestamp;  
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);  
end mec_history_biu;  

/
ALTER TRIGGER "ORIGINAL"."MEC_HISTORY_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MEC_HISTORY_ID_PK" ON "ORIGINAL"."MEC_HISTORY" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "APEX_3775593283083513" ;
  CREATE UNIQUE INDEX "ORIGINAL"."SYS_IL0000076535C00021$$" ON "ORIGINAL"."MEC_HISTORY" (
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE( INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" 
  PARALLEL (DEGREE 0 INSTANCES 0) ;
  CREATE UNIQUE INDEX "ORIGINAL"."SYS_IL0000076535C00019$$" ON "ORIGINAL"."MEC_HISTORY" (
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE( INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" 
  PARALLEL (DEGREE 0 INSTANCES 0) ;
  CREATE UNIQUE INDEX "ORIGINAL"."SYS_IL0000076535C00020$$" ON "ORIGINAL"."MEC_HISTORY" (
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE( INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" 
  PARALLEL (DEGREE 0 INSTANCES 0) ;
  CREATE UNIQUE INDEX "ORIGINAL"."SYS_IL0000076535C00018$$" ON "ORIGINAL"."MEC_HISTORY" (
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE( INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" 
  PARALLEL (DEGREE 0 INSTANCES 0) ;
;

CREATE TABLE "ORIGINAL"."MEC_INSUMO" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MEC_INSUMO_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_AQUISICAO" NUMBER, 
	"COD_PROCEXEC" NUMBER, 
	"ITEM" VARCHAR2(4 CHAR), 
	"NUM_CATMAT" VARCHAR2(20 CHAR), 
	"DESC_INSUMO" VARCHAR2(4000 CHAR), 
	"OBS_SECRETARIA" VARCHAR2(4000 CHAR), 
	"UNID_FORNEC" VARCHAR2(255 CHAR), 
	"COTA_RESERVA" VARCHAR2(20 CHAR), 
	"QTDE_TOTAL" NUMBER, 
	"VL_UNIT" NUMBER, 
	"VL_TOTAL" NUMBER, 
	"RISCO" VARCHAR2(255 CHAR), 
	"TEMPO" VARCHAR2(255 CHAR), 
	"OBS" VARCHAR2(4000 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MEC_INSUMO_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MEC_INSUMO" ADD CONSTRAINT "MEC_INSUMO_SEQ_FK_MEC_AQUISICAO" FOREIGN KEY ("COD_AQUISICAO")
	  REFERENCES "ORIGINAL"."MEC_AQUISICAO" ("ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "ORIGINAL"."MEC_INSUMO" ADD CONSTRAINT "MEC_INSUMO_FK_MEC_PROCEXEC" FOREIGN KEY ("COD_PROCEXEC")
	  REFERENCES "ORIGINAL"."MEC_PROCEXEC" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MEC_INSUMO" 
    after update or delete on mec_insumo  
    for each row  
declare  
    t varchar2(128) := 'MEC_INSUMO';  
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
begin   
if updating then   
    if(:old.id is null and :new.id is not null) or   
        (:old.id is not null and :new.id is null) or   
        :old.id != :new.id then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);   
    end if;   
   
    if(:old.cod_aquisicao is null and :new.cod_aquisicao is not null) or   
        (:old.cod_aquisicao is not null and :new.cod_aquisicao is null) or   
        :old.cod_aquisicao != :new.cod_aquisicao then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'COD_AQUISICAO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_aquisicao, :new.cod_aquisicao);   
     end if;   
   
    if(:old.cod_procexec is null and :new.cod_procexec is not null) or   
        (:old.cod_procexec is not null and :new.cod_procexec is null) or   
        :old.cod_procexec != :new.cod_procexec then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'COD_PROCEXEC', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_procexec, :new.cod_procexec);   
     end if;   
   
    if(:old.item is null and :new.item is not null) or   
        (:old.item is not null and :new.item is null) or   
        :old.item != :new.item then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'ITEM', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.item, :new.item);   
     end if;   
  
    if(:old.num_catmat is null and :new.num_catmat is not null) or   
        (:old.num_catmat is not null and :new.num_catmat is null) or   
        :old.num_catmat != :new.num_catmat then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'NUM_CATMAT', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_catmat, :new.num_catmat);   
    end if;   
   
    if(:old.desc_insumo is null and :new.desc_insumo is not null) or   
        (:old.desc_insumo is not null and :new.desc_insumo is null) or   
        :old.desc_insumo != :new.desc_insumo then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'DESC_INSUMO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.desc_insumo, :new.desc_insumo);   
    end if;   
   
    if(:old.unid_fornec is null and :new.unid_fornec is not null) or   
        (:old.unid_fornec is not null and :new.unid_fornec is null) or   
        :old.unid_fornec != :new.unid_fornec then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'UNID_FORNEC', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.unid_fornec, :new.unid_fornec);   
    end if;   
  
	if(:old.qtde_total is null and :new.qtde_total is not null) or   
        (:old.qtde_total is not null and :new.qtde_total is null) or   
        :old.qtde_total != :new.qtde_total then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'QTDE_TOTAL', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.qtde_total, :new.qtde_total);   
    end if;   
  
    if(:old.risco is null and :new.risco is not null) or    
        (:old.risco is not null and :new.risco is null) or    
        :old.risco != :new.risco then    
        insert into mec_history (    
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc    
        ) values (    
          mec_history_seq.nextval, t, 'RISCO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.risco, :new.risco);    
    end if;    
  
    if(:old.tempo is null and :new.tempo is not null) or    
        (:old.tempo is not null and :new.tempo is null) or    
        :old.tempo != :new.tempo then    
        insert into mec_history (    
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc    
        ) values (    
          mec_history_seq.nextval, t, 'TEMPO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.tempo, :new.tempo);    
    end if;    
      
	if(:old.obs_secretaria is null and :new.obs_secretaria is not null) or   
        (:old.obs_secretaria is not null and :new.obs_secretaria is null) or   
        :old.obs_secretaria != :new.obs_secretaria then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'OBS_SECRETARIA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obs_secretaria, :new.obs_secretaria);   
    end if;   
 
	if(:old.obs is null and :new.obs is not null) or   
        (:old.obs is not null and :new.obs is null) or   
        :old.obs != :new.obs then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'OBS', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obs, :new.obs);   
    end if;   
  
end if;   
   
if deleting then   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'COD_AQUISICAO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_aquisicao, :new.cod_aquisicao);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'COD_PROCEXEC', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_procexec, :new.cod_procexec);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'ITEM', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.item, :new.item);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'NUM_CATMAT', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_catmat, :new.num_catmat);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'DESC_INSUMO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.desc_insumo, :new.desc_insumo);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'UNID_FORNEC', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.unid_fornec, :new.unid_fornec);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'QTDE_TOTAL', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.qtde_total, :new.qtde_total);   
 
    insert into mec_history (    
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc    
    ) values (    
        mec_history_seq.nextval, t, 'RISCO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.risco, :new.risco);    
  
    insert into mec_history (    
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc    
    ) values (    
        mec_history_seq.nextval, t, 'TEMPO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.tempo, :new.tempo);    
 
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'OBS_SECRETARIA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obs_secretaria, :new.obs_secretaria);   
 
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'OBS', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obs, :new.obs);   
   
end if;   
end aud_mec_insumo; 

/
ALTER TRIGGER "ORIGINAL"."AUD_MEC_INSUMO" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MEC_INSUMO_BIU" 
    before insert or update  
    on mec_insumo 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mec_insumo_biu; 

/
ALTER TRIGGER "ORIGINAL"."MEC_INSUMO_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MEC_INSUMO_ID_PK" ON "ORIGINAL"."MEC_INSUMO" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MEC_NOTA_EMPENHO" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MEC_NOTA_EMPENHO_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_PROCEXEC" NUMBER, 
	"NUM_NOTA_EMPENHO" VARCHAR2(20 CHAR), 
	"DT_NOTA_EMPENHO" TIMESTAMP (6), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MEC_NOTA_EMPENHO_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MEC_NOTA_EMPENHO" ADD CONSTRAINT "MEC_NOTA_EMPENHO_FK_MEC_PROCEXEC" FOREIGN KEY ("COD_PROCEXEC")
	  REFERENCES "ORIGINAL"."MEC_PROCEXEC" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MEC_NOTA_EMPENHO" 
    after update or delete on mec_nota_empenho   
    for each row   
declare   
    t varchar2(128) := 'MEC_NOTA_EMPENHO';   
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);   
begin   
if updating then   
    if(:old.id is null and :new.id is not null) or   
        (:old.id is not null and :new.id is null) or   
        :old.id != :new.id then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);   
    end if;   
   
    if(:old.cod_procexec is null and :new.cod_procexec is not null) or   
        (:old.cod_procexec is not null and :new.cod_procexec is null) or   
        :old.cod_procexec != :new.cod_procexec then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'COD_PROCEXEC', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_procexec, :new.cod_procexec);   
     end if;   
   
    if(:old.num_nota_empenho is null and :new.num_nota_empenho is not null) or   
        (:old.num_nota_empenho is not null and :new.num_nota_empenho is null) or   
        :old.num_nota_empenho != :new.num_nota_empenho then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'NUM_NOTA_EMPENHO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_nota_empenho, :new.num_nota_empenho);   
     end if;   
   
    if(:old.dt_nota_empenho is null and :new.dt_nota_empenho is not null) or   
        (:old.dt_nota_empenho is not null and :new.dt_nota_empenho is null) or   
        :old.dt_nota_empenho != :new.dt_nota_empenho then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
        ) values (   
          mec_history_seq.nextval, t, 'DT_NOTA_EMPENHO', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_nota_empenho, :new.dt_nota_empenho);   
    end if;   
   
end if;   
   
if deleting then   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'COD_PROCEXEC', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_procexec, :new.cod_procexec);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'NUM_NOTA_EMPENHO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_nota_empenho, :new.num_nota_empenho);   
       
	insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
    ) values (   
        mec_history_seq.nextval, t, 'DT_NOTA_EMPENHO', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_nota_empenho, :new.dt_nota_empenho);   
    
end if;   
end aud_mec_nota_empenho;   

/
ALTER TRIGGER "ORIGINAL"."AUD_MEC_NOTA_EMPENHO" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MEC_NOTA_EMPENHO_BIU" 
    before insert or update  
    on mec_nota_empenho 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mec_nota_empenho_biu; 

/
ALTER TRIGGER "ORIGINAL"."MEC_NOTA_EMPENHO_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MEC_NOTA_EMPENHO_ID_PK" ON "ORIGINAL"."MEC_NOTA_EMPENHO" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MEC_PROCEXEC" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MEC_PROCEXEC_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_AQUISICAO" NUMBER, 
	"SEQ" VARCHAR2(3 CHAR), 
	"NUM_PROCEXEC" VARCHAR2(20 CHAR), 
	"NUM_ARP" VARCHAR2(255 CHAR), 
	"SITUACAO_EXEC" VARCHAR2(255 CHAR), 
	"SIGLA" VARCHAR2(255 CHAR), 
	"DT_VIG_INIC_ARP" TIMESTAMP (6), 
	"DT_VIG_FINAL_ARP" TIMESTAMP (6), 
	"DT_ENT_DIMEC" TIMESTAMP (6), 
	"ETAPA_PROC_EXEC" VARCHAR2(255 CHAR), 
	"DT_ETA_EXEC" TIMESTAMP (6), 
	"OBS1" VARCHAR2(4000 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MEC_PROCEXEC_SEQ_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MEC_PROCEXEC" ADD CONSTRAINT "MEC_PORCEXEC_SEQ_FK_MEC_AQUISICAO" FOREIGN KEY ("COD_AQUISICAO")
	  REFERENCES "ORIGINAL"."MEC_AQUISICAO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MEC_PROCEXEC" 
    after update or delete on mec_procexec   
    for each row   
declare   
    t varchar2(128) := 'MEC_PROCEXEC';   
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);   
begin   
if updating then   
    if(:old.id is null and :new.id is not null) or   
        (:old.id is not null and :new.id is null) or   
        :old.id != :new.id then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);   
    end if;   
   
    if(:old.cod_aquisicao is null and :new.cod_aquisicao is not null) or   
        (:old.cod_aquisicao is not null and :new.cod_aquisicao is null) or   
        :old.cod_aquisicao != :new.cod_aquisicao then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'COD_AQUISICAO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_aquisicao, :new.cod_aquisicao);   
     end if;   
  
    if(:old.seq is null and :new.seq is not null) or   
        (:old.seq is not null and :new.seq is null) or   
        :old.seq != :new.seq then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type,  old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'SEQ', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.seq, :new.seq);   
    end if; 	  
  
    if(:old.num_procexec is null and :new.num_procexec is not null) or   
        (:old.num_procexec is not null and :new.num_procexec is null) or   
        :old.num_procexec != :new.num_procexec then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type,  old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'NUM_PROCEXEC', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_procexec, :new.num_procexec);   
    end if;   
		   
    if(:old.num_arp is null and :new.num_arp is not null) or   
        (:old.num_arp is not null and :new.num_arp is null) or   
        :old.num_arp != :new.num_arp then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'NUM_ARP', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_arp, :new.num_arp);   
    end if;   
   
    if(:old.dt_vig_inic_arp is null and :new.dt_vig_inic_arp is not null) or   
        (:old.dt_vig_inic_arp is not null and :new.dt_vig_inic_arp is null) or   
        :old.dt_vig_inic_arp != :new.dt_vig_inic_arp then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
        ) values (   
          mec_history_seq.nextval, t, 'DT_VIG_INIC_ARP', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_vig_inic_arp, :new.dt_vig_inic_arp);   
    end if;   
   
    if(:old.dt_vig_final_arp is null and :new.dt_vig_final_arp is not null) or   
        (:old.dt_vig_final_arp is not null and :new.dt_vig_final_arp is null) or   
        :old.dt_vig_final_arp != :new.dt_vig_final_arp then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
        ) values (   
          mec_history_seq.nextval, t, 'DT_VIG_FINAL_ARP', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_vig_final_arp, :new.dt_vig_final_arp);   
    end if;   
   
    if(:old.dt_ent_dimec is null and :new.dt_ent_dimec is not null) or   
        (:old.dt_ent_dimec is not null and :new.dt_ent_dimec is null) or   
        :old.dt_ent_dimec != :new.dt_ent_dimec then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
        ) values (   
          mec_history_seq.nextval, t, 'DT_ENT_DIMEC', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_ent_dimec, :new.dt_ent_dimec);   
    end if;   
  
    if(:old.obs1 is null and :new.obs1 is not null) or   
        (:old.obs1 is not null and :new.obs1 is null) or   
        :old.obs1 != :new.obs1 then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'OBS1', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obs1, :new.obs1);   
    end if;   
   
  
end if;   
   
if deleting then   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'COD_AQUISICAO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_aquisicao, :new.cod_aquisicao);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'SEQ', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.seq, :new.seq);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'NUM_PROCEXEC', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_procexec, :new.num_procexec);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'NUM_ARP', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_arp, :new.num_arp);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
    ) values (   
        mec_history_seq.nextval, t, 'DT_VIG_INIC_ARP', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_vig_inic_arp, :new.dt_vig_inic_arp);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
    ) values (   
        mec_history_seq.nextval, t, 'DT_VIG_FINAL_ARP', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_vig_final_arp, :new.dt_vig_final_arp);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
    ) values (   
        mec_history_seq.nextval, t, 'DT_ENT_DIMEC', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_ent_dimec, :new.dt_ent_dimec);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'OBS1', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obs1, :new.obs1);   
  
end if;   
end aud_mec_nota_emp;  

/
ALTER TRIGGER "ORIGINAL"."AUD_MEC_PROCEXEC" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MEC_PROCEXEC_BIU" 
    before insert or update  
    on mec_procexec 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mec_procexec_biu; 

/
ALTER TRIGGER "ORIGINAL"."MEC_PROCEXEC_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MEC_PROCEXEC_SEQ_ID_PK" ON "ORIGINAL"."MEC_PROCEXEC" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MEC_PROCEXEC_INSUMO" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MEC_PROCEXEC_INSUMO_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_PROCEXEC" NUMBER, 
	"COD_INSUMO" NUMBER, 
	"QTDE" NUMBER, 
	"NUM_EXEC" VARCHAR2(20 CHAR), 
	"QTDE_SOL" NUMBER, 
	"VL_UNIT" NUMBER, 
	"VL_UNIT_EST" NUMBER, 
	"MOEDA" VARCHAR2(255 CHAR), 
	"MOEDA_EST" VARCHAR2(255 CHAR), 
	"VL_TOTAL" NUMBER, 
	"VL_TOTAL_EST" NUMBER, 
	"COTACAO" NUMBER, 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MEC_PROCEXEC_INSUMO_SEQ_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MEC_PROCEXEC_INSUMO" ADD CONSTRAINT "MEC_PROCEXEC_INSUMO_FK_MEC_PROCEXEC" FOREIGN KEY ("COD_PROCEXEC")
	  REFERENCES "ORIGINAL"."MEC_PROCEXEC" ("ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "ORIGINAL"."MEC_PROCEXEC_INSUMO" ADD CONSTRAINT "MEC_PROCEXEC_INSUMO_FK_MEC_INSUMO" FOREIGN KEY ("COD_INSUMO")
	  REFERENCES "ORIGINAL"."MEC_INSUMO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MEC_PROCEXEC_INSUMO" 
    after update or delete on mec_procexec_insumo  
    for each row   
declare   
    t varchar2(128) := 'MEC_PROCEXEC_INSUMO';   
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);   
begin   
if updating then   
    if(:old.id is null and :new.id is not null) or   
        (:old.id is not null and :new.id is null) or   
        :old.id != :new.id then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);   
    end if;   
   
    if(:old.cod_procexec is null and :new.cod_procexec is not null) or   
        (:old.cod_procexec is not null and :new.cod_procexec is null) or   
        :old.cod_procexec != :new.cod_procexec then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'COD_PROCEXEC', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_procexec, :new.cod_procexec);   
     end if;   
  
    if(:old.cod_insumo is null and :new.cod_insumo is not null) or   
        (:old.cod_insumo is not null and :new.cod_insumo is null) or   
        :old.cod_insumo != :new.cod_insumo then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'COD_INSUMO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_insumo, :new.cod_insumo);   
     end if;  
   
    if(:old.qtde is null and :new.qtde is not null) or   
        (:old.qtde is not null and :new.qtde is null) or   
        :old.qtde != :new.qtde then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type,  old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'QTDE', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.qtde, :new.qtde);   
    end if;   
   
    if(:old.qtde_sol is null and :new.qtde_sol is not null) or   
        (:old.qtde_sol is not null and :new.qtde_sol is null) or   
        :old.qtde_sol != :new.qtde_sol then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type,  old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'QTDE_SOL', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.qtde_sol, :new.qtde_sol);   
    end if;   
  
    if(:old.vl_unit is null and :new.vl_unit is not null) or   
        (:old.vl_unit is not null and :new.vl_unit is null) or   
        :old.vl_unit != :new.vl_unit then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type,  old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'VL_UNIT', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_unit, :new.vl_unit);   
    end if;  
  
    if(:old.vl_unit_est is null and :new.vl_unit_est is not null) or   
        (:old.vl_unit_est is not null and :new.vl_unit_est is null) or   
        :old.vl_unit_est != :new.vl_unit_est then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type,  old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'VL_UNIT_EST', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_unit_est, :new.vl_unit_est);   
    end if;  
		 		   
 
    if(:old.moeda is null and :new.moeda is not null) or   
        (:old.moeda is not null and :new.moeda is null) or   
        :old.moeda != :new.moeda then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'MOEDA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.moeda, :new.moeda);   
    end if;   
		 		   
    if(:old.moeda_est is null and :new.moeda_est is not null) or   
        (:old.moeda_est is not null and :new.moeda_est is null) or   
        :old.moeda_est != :new.moeda_est then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'MOEDA_EST', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.moeda_est, :new.moeda_est);   
    end if;   
  
    if(:old.vl_total_est is null and :new.vl_total_est is not null) or   
        (:old.vl_total_est is not null and :new.vl_total_est is null) or   
        :old.vl_total_est != :new.vl_total_est then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type,  old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'VL_TOTAL_EST', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_total_est, :new.vl_total_est);   
    end if;  
  
    if(:old.vl_total is null and :new.vl_total is not null) or   
        (:old.vl_total is not null and :new.vl_total is null) or   
        :old.vl_total != :new.vl_total then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type,  old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'VL_TOTAL', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_total, :new.vl_total);   
    end if;  
  
    if(:old.cotacao is null and :new.cotacao is not null) or   
        (:old.cotacao is not null and :new.cotacao is null) or   
        :old.cotacao != :new.cotacao then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type,  old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'COTACAO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cotacao, :new.cotacao);   
    end if;  
  
end if;   
   
if deleting then   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
 
    ) values (   
        mec_history_seq.nextval, t, 'COD_PROCEXEC', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_procexec, :new.cod_procexec);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'COD_INSUMO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_insumo, :new.cod_insumo);  
      
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'QTDE', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.qtde, :new.qtde);  
      
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'QTDE_SOL', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.qtde_sol, :new.qtde_sol);  
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'VL_UNIT', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_unit, :new.vl_unit);  
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'VL_UNIT_EST', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_unit_est, :new.vl_unit_est);  
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'MOEDA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.moeda, :new.moeda);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'MOEDA_EST', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.moeda_est, :new.moeda_est);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'VL_TOTAL', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_total, :new.vl_total);  
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'VL_TOTAL_EST', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_total_est, :new.vl_total_est);  
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'COTACAO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cotacao, :new.cotacao);  
  
end if;   
end aud_mec_procexec_insumo;  

/
ALTER TRIGGER "ORIGINAL"."AUD_MEC_PROCEXEC_INSUMO" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MEC_PROCEXEC_INSUMO_BIU" 
    before insert or update  
    on mec_procexec_insumo 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mec_procexec_insumo_biu; 

/
ALTER TRIGGER "ORIGINAL"."MEC_PROCEXEC_INSUMO_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MEC_PROCEXEC_INSUMO_SEQ_ID_PK" ON "ORIGINAL"."MEC_PROCEXEC_INSUMO" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MEC_TAREFA" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MEC_TAREFA_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_AQUISICAO" NUMBER, 
	"NOME_ANALISTA" VARCHAR2(255 CHAR), 
	"DESC_TAREFA" VARCHAR2(255 CHAR), 
	"DT_ENTRADA" TIMESTAMP (6), 
	"DT_SAIDA" TIMESTAMP (6), 
	"DESTINO" VARCHAR2(255 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MEC_TAREFA_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MEC_TAREFA" ADD CONSTRAINT "MEC_TAREFA_FK_COD_AQUISICAO" FOREIGN KEY ("COD_AQUISICAO")
	  REFERENCES "ORIGINAL"."MEC_AQUISICAO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MEC_TAREFA" 
    after update or delete on mec_tarefa   
    for each row   
declare   
    t varchar2(128) := 'MEC_TAREFA';   
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);   
 
begin   
if updating then   
    if(:old.id is null and :new.id is not null) or   
        (:old.id is not null and :new.id is null) or   
        :old.id != :new.id then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);   
    end if;   
   
    if(:old.cod_aquisicao is null and :new.cod_aquisicao is not null) or   
        (:old.cod_aquisicao is not null and :new.cod_aquisicao is null) or   
        :old.cod_aquisicao != :new.cod_aquisicao then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'COD_AQUISICAO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_aquisicao, :new.cod_aquisicao);   
     end if;   
   
    if(:old.desc_tarefa is null and :new.desc_tarefa is not null) or   
        (:old.desc_tarefa is not null and :new.desc_tarefa is null) or   
        :old.desc_tarefa != :new.desc_tarefa then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'DESC_TAREFA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.desc_tarefa, :new.desc_tarefa);   
     end if;   
    
    if(:old.nome_analista is null and :new.nome_analista is not null) or   
        (:old.nome_analista is not null and :new.nome_analista is null) or   
        :old.nome_analista != :new.nome_analista then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'NOME_ANALISTA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.nome_analista, :new.nome_analista);   
     end if;   
   
    if(:old.dt_entrada is null and :new.dt_entrada is not null) or   
        (:old.dt_entrada is not null and :new.dt_entrada is null) or   
        :old.dt_entrada != :new.dt_entrada then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
        ) values (   
          mec_history_seq.nextval, t, 'DT_ENTRADA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_entrada, :new.dt_entrada);   
     end if;   
   
    if(:old.dt_saida is null and :new.dt_saida is not null) or   
        (:old.dt_saida is not null and :new.dt_saida is null) or   
        :old.dt_saida != :new.dt_saida then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
        ) values (   
          mec_history_seq.nextval, t, 'DT_SAIDA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_saida, :new.dt_saida);   
     end if;    
   
    if(:old.destino is null and :new.destino is not null) or   
        (:old.destino is not null and :new.destino is null) or   
        :old.destino != :new.destino then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'DESTINO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.destino, :new.destino);   
     end if;   
   
end if;   
   
if deleting then   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'COD_AQUISICAO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_aquisicao, :new.cod_aquisicao);   
					   
	insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'DESC_TAREFA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.desc_tarefa, :new.desc_tarefa);		  
					   
	insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'NOME_ANALISTA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.nome_analista, :new.nome_analista);		  
      
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
    ) values (   
        mec_history_seq.nextval, t, 'DT_ENTRADA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_entrada, :new.dt_entrada);    
    
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
    ) values (   
        mec_history_seq.nextval, t, 'DT_SAIDA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_saida, :new.dt_saida);    
					   
	insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'DESTINO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.destino, :new.destino);		  
    
end if;   
   
end aud_mec_tarefa;   

/
ALTER TRIGGER "ORIGINAL"."AUD_MEC_TAREFA" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MEC_TAREFA_BIU" 
    before insert or update  
    on mec_tarefa 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mec_tarefa_biu; 

/
ALTER TRIGGER "ORIGINAL"."MEC_TAREFA_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MEC_TAREFA_ID_PK" ON "ORIGINAL"."MEC_TAREFA" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MEC_TERMO_ADITIVO" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MEC_TERMO_ADITIVO_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_PROCEXEC" NUMBER, 
	"NUM_CONTRATO_TA" VARCHAR2(20 CHAR), 
	"NUM_TA" VARCHAR2(20 CHAR), 
	"DT_VIG_INIC_TA" TIMESTAMP (6), 
	"DT_VIG_FINAL_TA" TIMESTAMP (6), 
	"VL_TA" NUMBER, 
	"OBSTA" VARCHAR2(4000 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MEC_TERMO_ADITIVO_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MEC_TERMO_ADITIVO" ADD CONSTRAINT "MEC_TERMO_ADITIVO_FK_MEC_PROCEXEC" FOREIGN KEY ("COD_PROCEXEC")
	  REFERENCES "ORIGINAL"."MEC_PROCEXEC" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MEC_TERMO_ADITIVO" 
    after update or delete on mec_termo_aditivo   
    for each row   
declare   
    t varchar2(128) := 'MEC_TERMO_ADITIVO';   
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);   
begin   
if updating then   
    if(:old.id is null and :new.id is not null) or   
        (:old.id is not null and :new.id is null) or   
        :old.id != :new.id then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);   
    end if;   
   
    if(:old.cod_procexec is null and :new.cod_procexec is not null) or   
        (:old.cod_procexec is not null and :new.cod_procexec is null) or   
        :old.cod_procexec != :new.cod_procexec then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'COD_PROCEXEC', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_procexec, :new.cod_procexec);   
     end if;   
   
    if(:old.num_contrato_ta is null and :new.num_contrato_ta is not null) or   
        (:old.num_contrato_ta is not null and :new.num_contrato_ta is null) or   
        :old.num_contrato_ta != :new.num_contrato_ta then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'NUM_CONTRATO_TA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_contrato_ta, :new.num_contrato_ta);   
     end if;   
  
    if(:old.num_ta is null and :new.num_ta is not null) or   
        (:old.num_ta is not null and :new.num_ta is null) or   
        :old.num_ta != :new.num_ta then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'NUM_TA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_ta, :new.num_ta);   
     end if;   
   
    if(:old.dt_vig_inic_ta is null and :new.dt_vig_inic_ta is not null) or   
        (:old.dt_vig_inic_ta is not null and :new.dt_vig_inic_ta is null) or   
        :old.dt_vig_inic_ta != :new.dt_vig_inic_ta then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
        ) values (   
          mec_history_seq.nextval, t, 'DT_VIG_INIC_TA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_vig_inic_ta, :new.dt_vig_inic_ta);   
     end if;   
    
    if(:old.dt_vig_final_ta is null and :new.dt_vig_final_ta is not null) or   
        (:old.dt_vig_final_ta is not null and :new.dt_vig_final_ta is null) or   
        :old.dt_vig_final_ta != :new.dt_vig_final_ta then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
        ) values (   
          mec_history_seq.nextval, t, 'DT_VIG_FINAL_TA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_vig_final_ta, :new.dt_vig_final_ta);   
     end if;   
  
	if(:old.vl_ta is null and :new.vl_ta is not null) or   
        (:old.vl_ta is not null and :new.vl_ta is null) or   
        :old.vl_ta != :new.vl_ta then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'VL_TA', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_ta, :new.vl_ta);   
    end if;   
       
    if(:old.obsta is null and :new.obsta is not null) or   
        (:old.obsta is not null and :new.obsta is null) or   
        :old.obsta != :new.obsta then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'OBSTA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obsta, :new.obsta);   
     end if;   
  
    
end if;   
   
if deleting then   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'COD_PROCEXEC', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_procexec, :new.cod_procexec);   
	   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'NUM_TA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_ta, :new.num_ta);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'NUM_CONTRATO_TA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_contrato_ta, :new.num_contrato_ta);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
    ) values (   
        mec_history_seq.nextval, t, 'DT_VIG_INIC_TA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_vig_inic_ta, :new.dt_vig_inic_ta);   
    		   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
    ) values (   
        mec_history_seq.nextval, t, 'DT_VIG_FINAL_TA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_vig_final_ta, :new.dt_vig_final_ta);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'VL_TA', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_ta, :new.vl_ta);   
  
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'OBSTA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obsta, :new.obsta);   
  
  
end if;   
end aud_mec_termo_aditivo;   

/
ALTER TRIGGER "ORIGINAL"."AUD_MEC_TERMO_ADITIVO" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MEC_TERMO_ADITIVO_BIU" 
    before insert or update  
    on mec_termo_aditivo 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mec_termo_aditivo_biu; 

/
ALTER TRIGGER "ORIGINAL"."MEC_TERMO_ADITIVO_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MEC_TERMO_ADITIVO_ID_PK" ON "ORIGINAL"."MEC_TERMO_ADITIVO" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MEC_URGENCIA" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MEC_URGENCIA_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_AQUISICAO" NUMBER, 
	"DESC_URGENC" VARCHAR2(50 CHAR), 
	"DT_URGENCIA" TIMESTAMP (6), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MEC_URGENCIA_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MEC_URGENCIA" ADD CONSTRAINT "MEC_URGENCIA_FK_COD_AQUISICAO" FOREIGN KEY ("COD_AQUISICAO")
	  REFERENCES "ORIGINAL"."MEC_AQUISICAO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MEC_URGENCIA" 
    after update or delete on mec_urgencia   
    for each row   
declare   
    t varchar2(128) := 'MEC_URGENCIA';   
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);   
begin   
if updating then   
    if(:old.id is null and :new.id is not null) or   
        (:old.id is not null and :new.id is null) or   
        :old.id != :new.id then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);   
    end if;   
   
    if(:old.cod_aquisicao is null and :new.cod_aquisicao is not null) or   
        (:old.cod_aquisicao is not null and :new.cod_aquisicao is null) or   
        :old.cod_aquisicao != :new.cod_aquisicao then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
        ) values (   
          mec_history_seq.nextval, t, 'COD_AQUISICAO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_aquisicao, :new.cod_aquisicao);   
     end if;   
     
    if(:old.desc_urgenc is null and :new.desc_urgenc is not null) or   
        (:old.desc_urgenc is not null and :new.desc_urgenc is null) or   
        :old.desc_urgenc != :new.desc_urgenc then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'DESC_URGENC', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.desc_urgenc, :new.desc_urgenc);   
     end if;   
        
    if(:old.dt_urgencia is null and :new.dt_urgencia is not null) or   
        (:old.dt_urgencia is not null and :new.dt_urgencia is null) or   
        :old.dt_urgencia != :new.dt_urgencia then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
        ) values (   
          mec_history_seq.nextval, t, 'DT_URGENCIA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_urgencia, :new.dt_urgencia);   
     end if;   
   
      
end if;   
   
if deleting then   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);   
   
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number   
    ) values (   
        mec_history_seq.nextval, t, 'COD_AQUISICAO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_aquisicao, :new.cod_aquisicao);   
   
	insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'DESC_URGENC', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.desc_urgenc, :new.desc_urgenc);  
    
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts   
    ) values (   
        mec_history_seq.nextval, t, 'DT_URGENCIA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_urgencia, :new.dt_urgencia);    
					   
	   
end if;   
end aud_mec_urgencia;  

/
ALTER TRIGGER "ORIGINAL"."AUD_MEC_URGENCIA" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MEC_URGENCIA_BIU" 
    before insert or update  
    on mec_urgencia 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mec_urgencia_biu; 

/
ALTER TRIGGER "ORIGINAL"."MEC_URGENCIA_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MEC_URGENCIA_ID_PK" ON "ORIGINAL"."MEC_URGENCIA" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MOL_ANALISE_REC" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MOL_ANALISE_REC_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_PROCESSO" NUMBER, 
	"DT_INTERPOS" TIMESTAMP (6), 
	"DT_NOT_TEC1" TIMESTAMP (6), 
	"DT_DECISAO1" TIMESTAMP (6), 
	"DEC_POS_ANA" VARCHAR2(255 CHAR), 
	"DT_ENC_GABSE" TIMESTAMP (6), 
	"PENAL_APLIC" VARCHAR2(255 CHAR), 
	"PENAL_APLIC2" VARCHAR2(255 CHAR), 
	"PENAL_APLIC2I" VARCHAR2(255 CHAR), 
	"DT_NOT1" TIMESTAMP (6), 
	"DT_ENVIO_NOT1" TIMESTAMP (6), 
	"DT_ENVIO_NOT1I" TIMESTAMP (6), 
	"DT_ENVIO_PUBLIC1" TIMESTAMP (6), 
	"FORMA_ENVIO1" VARCHAR2(255 CHAR), 
	"FORMA_ENVIO1I" VARCHAR2(255 CHAR), 
	"FORMA_ENVIO1II" VARCHAR2(255 CHAR), 
	"DT_PUBLICACAO1" TIMESTAMP (6), 
	"DT_REC_NOT1" TIMESTAMP (6), 
	"DT_PAG_MULTA1" TIMESTAMP (6), 
	"MOEDAAR" VARCHAR2(30 CHAR), 
	"VL_MULTA_ATUA" NUMBER, 
	"OBS1" VARCHAR2(4000 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MOL_ANALISE_REC_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MOL_ANALISE_REC" ADD CONSTRAINT "MOL_ANALISE_REC_FK_COD_PROCESSO" FOREIGN KEY ("COD_PROCESSO")
	  REFERENCES "ORIGINAL"."MOL_PROCESSO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MOL_ANALISE_REC" 
    after update or delete on mol_analise_rec  
    for each row  
declare  
    t varchar2(128) := 'MOL_ANALISE_REC';  
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
begin  
if updating then  
    if(:old.id is null and :new.id is not null) or  
        (:old.id is not null and :new.id is null) or  
        :old.id != :new.id then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);  
    end if;  
  
    if(:old.cod_processo is null and :new.cod_processo is not null) or  
        (:old.cod_processo is not null and :new.cod_processo is null) or  
        :old.cod_processo != :new.cod_processo then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
     end if;  
  
    if(:old.dt_interpos is null and :new.dt_interpos is not null) or  
        (:old.dt_interpos is not null and :new.dt_interpos is null) or  
        :old.dt_interpos != :new.dt_interpos then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_INTERPOS', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_interpos, :new.dt_interpos);  
    end if;  
  
    if(:old.dt_not_tec1 is null and :new.dt_not_tec1 is not null) or  
        (:old.dt_not_tec1 is not null and :new.dt_not_tec1 is null) or  
        :old.dt_not_tec1 != :new.dt_not_tec1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_NOT_TEC1', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_not_tec1, :new.dt_not_tec1);  
    end if;  
  
    if(:old.dt_decisao1 is null and :new.dt_decisao1 is not null) or  
        (:old.dt_decisao1 is not null and :new.dt_decisao1 is null) or  
        :old.dt_decisao1 != :new.dt_decisao1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_DECISAO1', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_decisao1, :new.dt_decisao1);  
    end if;  
  
    if(:old.dec_pos_ana is null and :new.dec_pos_ana is not null) or  
        (:old.dec_pos_ana is not null and :new.dec_pos_ana is null) or  
        :old.dec_pos_ana != :new.dec_pos_ana then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'DEC_POS_ANA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.dec_pos_ana, :new.dec_pos_ana);  
     end if;  
  
    if(:old.dt_enc_gabse is null and :new.dt_enc_gabse is not null) or  
        (:old.dt_enc_gabse is not null and :new.dt_enc_gabse is null) or  
        :old.dt_enc_gabse != :new.dt_enc_gabse then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ENC_GABBSE', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_enc_gabse, :new.dt_enc_gabse);  
    end if;  
  
    if(:old.penal_aplic is null and :new.penal_aplic is not null) or  
        (:old.penal_aplic is not null and :new.penal_aplic is null) or  
        :old.penal_aplic != :new.penal_aplic then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_APLIC', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_aplic, :new.penal_aplic);  
     end if;  
   
    if(:old.penal_aplic2 is null and :new.penal_aplic2 is not null) or  
        (:old.penal_aplic2 is not null and :new.penal_aplic2 is null) or  
        :old.penal_aplic2 != :new.penal_aplic2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_APLIC2', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_aplic2, :new.penal_aplic2);  
     end if;  
      /* Alteração do dia 11 de Janeiro de 2024 - Herbert*/ 
   
    if(:old.penal_aplic2I is null and :new.penal_aplic2I is not null) or  
        (:old.penal_aplic2I is not null and :new.penal_aplic2I is null) or  
        :old.penal_aplic2I != :new.penal_aplic2I then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_APLIC2I', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_aplic2I, :new.penal_aplic2I);  
     end if;  
 
    if(:old.dt_not1 is null and :new.dt_not1 is not null) or  
        (:old.dt_not1 is not null and :new.dt_not1 is null) or  
        :old.dt_not1 != :new.dt_not1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_NOT1', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_not1, :new.dt_not1);  
    end if;  
  
    if(:old.dt_envio_not1 is null and :new.dt_envio_not1 is not null) or  
        (:old.dt_envio_not1 is not null and :new.dt_envio_not1 is null) or  
        :old.dt_envio_not1 != :new.dt_envio_not1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ENVIO_NOT1', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_envio_not1, :new.dt_envio_not1);  
    end if;  
  
    if(:old.dt_envio_not1I is null and :new.dt_envio_not1I is not null) or  
        (:old.dt_envio_not1I is not null and :new.dt_envio_not1I is null) or  
        :old.dt_envio_not1I != :new.dt_envio_not1I then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ENVIO_NOT1I', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_envio_not1I, :new.dt_envio_not1I);  
    end if;  
 
  
    if(:old.dt_envio_public1 is null and :new.dt_envio_public1 is not null) or  
        (:old.dt_envio_public1 is not null and :new.dt_envio_public1 is null) or  
        :old.dt_envio_public1 != :new.dt_envio_public1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ENVIO_´PUBLIC1', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_envio_public1, :new.dt_envio_public1);  
    end if;  
 
    if(:old.forma_envio1 is null and :new.forma_envio1 is not null) or  
        (:old.forma_envio1 is not null and :new.forma_envio1 is null) or  
        :old.forma_envio1 != :new.forma_envio1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'FORMA_ENVIO1', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_envio1, :new.forma_envio1);  
     end if;  
   
    if(:old.forma_envio1I is null and :new.forma_envio1I is not null) or  
        (:old.forma_envio1I is not null and :new.forma_envio1I is null) or  
        :old.forma_envio1I != :new.forma_envio1I then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'FORMA_ENVIO1I', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_envio1I, :new.forma_envio1I);  
     end if;  
   
    if(:old.forma_envio1II is null and :new.forma_envio1II is not null) or  
        (:old.forma_envio1II is not null and :new.forma_envio1II is null) or  
        :old.forma_envio1II != :new.forma_envio1II then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'FORMA_ENVIO1II', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_envio1II, :new.forma_envio1II);  
     end if;  
 
    if(:old.dt_publicacao1 is null and :new.dt_publicacao1 is not null) or  
        (:old.dt_publicacao1 is not null and :new.dt_publicacao1 is null) or  
        :old.dt_publicacao1 != :new.dt_publicacao1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_PUBLICACAO1', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_publicacao1, :new.dt_publicacao1);  
    end if;  
 
    if(:old.dt_rec_not1 is null and :new.dt_rec_not1 is not null) or  
        (:old.dt_rec_not1 is not null and :new.dt_rec_not1 is null) or  
        :old.dt_rec_not1 != :new.dt_rec_not1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_REC_NOT1', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_rec_not1, :new.dt_rec_not1);  
    end if;  
  
    if(:old.dt_pag_multa1 is null and :new.dt_pag_multa1 is not null) or  
        (:old.dt_pag_multa1 is not null and :new.dt_pag_multa1 is null) or  
        :old.dt_pag_multa1 != :new.dt_pag_multa1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_PAG_MULTA1', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_pag_multa1, :new.dt_pag_multa1);  
    end if;  
     /* Alteração do dia 11 de Janeiro de 2024 - Herbert*/ 
     if(:old.moedaar is null and :new.moedaar is not null) or  
        (:old.moedaar is not null and :new.moedaar is null) or  
        :old.moedaar != :new.moedaar then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'MOEDAAR', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.moedaar, :new.moedaar);  
     end if;  
 
	if(:old.vl_multa_atua is null and :new.vl_multa_atua is not null) or  
        (:old.vl_multa_atua is not null and :new.vl_multa_atua is null) or  
        :old.vl_multa_atua != :new.vl_multa_atua then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'VL_MULTA_ATUA', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_multa_atua, :new.vl_multa_atua);  
    end if;  
  
    if(:old.obs1 is null and :new.obs1 is not null) or  
        (:old.obs1 is not null and :new.obs1 is null) or  
        :old.obs1 != :new.obs1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'OBS1', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obs1, :new.obs1);  
     end if;  
  
end if;  
  
if deleting then  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_NOT_TEC1', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_not_tec1, :new.dt_not_tec1);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_DECISAO1', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_decisao1, :new.dt_decisao1);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'DEC_POS_ANA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.dec_pos_ana, :new.dec_pos_ana);  
      
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_ENC_GABSE', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_enc_gabse, :new.dt_enc_gabse);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENAL_APLIC', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.penal_aplic, :new.penal_aplic);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENAL_APLIC2', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.penal_aplic2, :new.penal_aplic2);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_NOT1', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_not1, :new.dt_not1);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_ENVIO_NOT1', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_envio_not1, :new.dt_envio_not1);  
   
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'FORMA_ENVIO1', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.forma_envio1, :new.forma_envio1);  
   
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'FORMA_ENVIO1I', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.forma_envio1I, :new.forma_envio1I);  
    
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'FORMA_ENVIO1II', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.forma_envio1II, :new.forma_envio1II);  
     
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_PUBLICACAO1', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_publicacao1, :new.dt_publicacao1);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_REC_NOT1', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_rec_not1, :new.dt_rec_not1);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_PAG_MULTA1', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_pag_multa1, :new.dt_pag_multa1);  
 
     /* Alteração do dia 11 de Janeiro de 2024 - Herbert*/ 
   
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'MOEDAAR', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.moedaar, :new.moedaar);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'VL_MULTA_ATUA', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_multa_atua, :new.vl_multa_atua);  
   
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'OBS1', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obs1, :new.obs1);  
  
end if;  
end aud_mol_analise_rec;  

/
ALTER TRIGGER "ORIGINAL"."AUD_MOL_ANALISE_REC" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MOL_ANALISE_REC_BIU" 
    before insert or update  
    on mol_analise_rec 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mol_reconsideracao_biu; 

/
ALTER TRIGGER "ORIGINAL"."MOL_ANALISE_REC_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MOL_ANALISE_REC_ID_PK" ON "ORIGINAL"."MOL_ANALISE_REC" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MOL_ANA_GAB" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MOL_ANA_GAB_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_PROCESSO" NUMBER, 
	"NOT_TEC" VARCHAR2(255 CHAR), 
	"DT_NOT_TEC2" TIMESTAMP (6), 
	"DT_DEC_GAB_DLOG" TIMESTAMP (6), 
	"DT_DESP_GAB" TIMESTAMP (6), 
	"DEC_POS_GABSE" VARCHAR2(255 CHAR), 
	"PENAL_APLIC1" VARCHAR2(255 CHAR), 
	"PENAL_APLIC3" VARCHAR2(255 CHAR), 
	"PENAL_APLIC3I" VARCHAR2(255 CHAR), 
	"DT_ENC_DIMOL" TIMESTAMP (6), 
	"DT_NOT2" TIMESTAMP (6), 
	"DT_ENVIO_NOT2" TIMESTAMP (6), 
	"DT_ENVIO_NOT2I" TIMESTAMP (6), 
	"DT_ENVIO_PUBLIC2" TIMESTAMP (6), 
	"FORMA_ENVIO2" VARCHAR2(255 CHAR), 
	"FORMA_ENVIO2I" VARCHAR2(255 CHAR), 
	"FORMA_ENVIO2II" VARCHAR2(255 CHAR), 
	"DT_PUBLICACAO2" TIMESTAMP (6), 
	"DT_REC_NOT2" TIMESTAMP (6), 
	"DT_PAG_MULTA2" TIMESTAMP (6), 
	"MOEDAGAB" VARCHAR2(30 CHAR), 
	"VL_MULTA_ATUA1" NUMBER, 
	"OBS2" VARCHAR2(4000 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MOL_ANA_GAB_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MOL_ANA_GAB" ADD CONSTRAINT "MOL_ANA_GAB_FK_COD_PROCESSO" FOREIGN KEY ("COD_PROCESSO")
	  REFERENCES "ORIGINAL"."MOL_PROCESSO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MOL_ANA_GAB" 
    after update or delete on mol_ana_gab  
    for each row  
declare  
    t varchar2(128) := 'MOL_ANA_GAB';  
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
begin  
if updating then  
    if(:old.id is null and :new.id is not null) or  
        (:old.id is not null and :new.id is null) or  
        :old.id != :new.id then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);  
    end if;  
  
    if(:old.cod_processo is null and :new.cod_processo is not null) or  
        (:old.cod_processo is not null and :new.cod_processo is null) or  
        :old.cod_processo != :new.cod_processo then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
     end if;  
  
    if(:old.not_tec is null and :new.not_tec is not null) or  
        (:old.not_tec is not null and :new.not_tec is null) or  
        :old.not_tec != :new.not_tec then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'NOT_TEC', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.not_tec, :new.not_tec);  
     end if;  
  
    if(:old.dt_not_tec2 is null and :new.dt_not_tec2 is not null) or  
        (:old.dt_not_tec2 is not null and :new.dt_not_tec2 is null) or  
        :old.dt_not_tec2 != :new.dt_not_tec2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_NOT_TEC2', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_not_tec2, :new.dt_not_tec2);  
    end if;  
  
    if(:old.dt_desp_gab is null and :new.dt_desp_gab is not null) or  
        (:old.dt_desp_gab is not null and :new.dt_desp_gab is null) or  
        :old.dt_desp_gab != :new.dt_desp_gab then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_DESP_GAB', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_desp_gab, :new.dt_desp_gab);  
    end if;  
 
     if(:old.dt_dec_gab_dlog is null and :new.dt_dec_gab_dlog is not null) or  
        (:old.dt_dec_gab_dlog is not null and :new.dt_dec_gab_dlog is null) or  
        :old.dt_dec_gab_dlog != :new.dt_dec_gab_dlog then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_DEC_GAB_DLOG', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_dec_gab_dlog, :new.dt_dec_gab_dlog);  
    end if;  
 
    if(:old.dec_pos_gabse is null and :new.dec_pos_gabse is not null) or  
        (:old.dec_pos_gabse is not null and :new.dec_pos_gabse is null) or  
        :old.dec_pos_gabse != :new.dec_pos_gabse then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'DEC_POS_GABSE', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.dec_pos_gabse, :new.dec_pos_gabse);  
     end if;  
  
    if(:old.penal_aplic1 is null and :new.penal_aplic1 is not null) or  
        (:old.penal_aplic1 is not null and :new.penal_aplic1 is null) or  
        :old.penal_aplic1 != :new.penal_aplic1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_APLIC1', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_aplic1, :new.penal_aplic1);  
     end if;  
  
    if(:old.penal_aplic3 is null and :new.penal_aplic3 is not null) or  
        (:old.penal_aplic3 is not null and :new.penal_aplic3 is null) or  
        :old.penal_aplic3 != :new.penal_aplic3 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_APLIC3', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_aplic3, :new.penal_aplic3);  
     end if;  
     /* Alteração do dia 11 de Janeiro de 2024 - Herbert*/ 
  
    if(:old.penal_aplic3I is null and :new.penal_aplic3I is not null) or  
        (:old.penal_aplic3I is not null and :new.penal_aplic3I is null) or  
        :old.penal_aplic3I != :new.penal_aplic3I then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_APLIC3I', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_aplic3I, :new.penal_aplic3I);  
     end if;  
 
    if(:old.dt_enc_dimol is null and :new.dt_enc_dimol is not null) or  
        (:old.dt_enc_dimol is not null and :new.dt_enc_dimol is null) or  
        :old.dt_enc_dimol != :new.dt_enc_dimol then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ENC_DIMOL', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_enc_dimol, :new.dt_enc_dimol);  
     end if;  
 
    if(:old.dt_not2 is null and :new.dt_not2 is not null) or  
        (:old.dt_not2 is not null and :new.dt_not2 is null) or  
        :old.dt_not2 != :new.dt_not2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_NOT2', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_not2, :new.dt_not2);  
     end if;  
  
    if(:old.dt_envio_not2 is null and :new.dt_envio_not2 is not null) or  
        (:old.dt_envio_not2 is not null and :new.dt_envio_not2 is null) or  
        :old.dt_envio_not2 != :new.dt_envio_not2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ENVIO_NOT2', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_envio_not2, :new.dt_envio_not2);  
     end if;  
   
    if(:old.dt_envio_not2I is null and :new.dt_envio_not2I is not null) or  
        (:old.dt_envio_not2I is not null and :new.dt_envio_not2I is null) or  
        :old.dt_envio_not2I != :new.dt_envio_not2I then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ENVIO_NOT2I', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_envio_not2I, :new.dt_envio_not2I);  
     end if;  
   
    if(:old.dt_envio_public2 is null and :new.dt_envio_public2 is not null) or  
        (:old.dt_envio_public2 is not null and :new.dt_envio_public2 is null) or  
        :old.dt_envio_public2 != :new.dt_envio_public2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ENVIO_PUBLIC2', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_envio_public2, :new.dt_envio_public2);  
     end if;  
  
    if(:old.forma_envio2 is null and :new.forma_envio2 is not null) or  
        (:old.forma_envio2 is not null and :new.forma_envio2 is null) or  
        :old.forma_envio2 != :new.forma_envio2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'FORMA_ENVIO2', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_envio2, :new.forma_envio2);  
     end if;  
   
    if(:old.forma_envio2I is null and :new.forma_envio2I is not null) or  
        (:old.forma_envio2I is not null and :new.forma_envio2I is null) or  
        :old.forma_envio2I != :new.forma_envio2I then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'FORMA_ENVIO2I', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_envio2I, :new.forma_envio2I);  
     end if;  
   
    if(:old.forma_envio2II is null and :new.forma_envio2II is not null) or  
        (:old.forma_envio2II is not null and :new.forma_envio2I is null) or  
        :old.forma_envio2II != :new.forma_envio2II then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'FORMA_ENVIO2II', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_envio2II, :new.forma_envio2II);  
     end if;  
 
    if(:old.dt_publicacao2 is null and :new.dt_publicacao2 is not null) or  
        (:old.dt_publicacao2 is not null and :new.dt_publicacao2 is null) or  
        :old.dt_publicacao2 != :new.dt_publicacao2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_PUBLICACAO2', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_publicacao2, :new.dt_publicacao2);  
    end if;  
 
    if(:old.dt_rec_not2 is null and :new.dt_rec_not2 is not null) or  
        (:old.dt_rec_not2 is not null and :new.dt_rec_not2 is null) or  
        :old.dt_rec_not2 != :new.dt_rec_not2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_REC_NOT2', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_rec_not2, :new.dt_rec_not2);  
    end if;  
  
    if(:old.dt_pag_multa2 is null and :new.dt_pag_multa2 is not null) or  
        (:old.dt_pag_multa2 is not null and :new.dt_pag_multa2 is null) or  
        :old.dt_pag_multa2 != :new.dt_pag_multa2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_PAG_MULTA2', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_pag_multa2, :new.dt_pag_multa2);  
    end if;  
  
	if(:old.vl_multa_atua1 is null and :new.vl_multa_atua1 is not null) or  
        (:old.vl_multa_atua1 is not null and :new.vl_multa_atua1 is null) or  
        :old.vl_multa_atua1 != :new.vl_multa_atua1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'VL_MULTA_ATUA1', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_multa_atua1, :new.vl_multa_atua1);  
    end if;  
   
    if(:old.moedagab is null and :new.moedagab is not null) or  
        (:old.moedagab is not null and :new.moedagab is null) or  
        :old.moedagab != :new.moedagab then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'MOEDAGAB', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.moedagab, :new.moedagab);  
     end if;  
      
    if(:old.obs2 is null and :new.obs2 is not null) or  
        (:old.obs2 is not null and :new.obs2 is null) or  
        :old.obs2 != :new.obs2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'OBS2', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obs2, :new.obs2);  
    end if;  
  
end if;  
  
if deleting then  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
	  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'NOT_TEC', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.not_tec, :new.not_tec);  
    		  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_NOT_TEC2', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_not_tec2, :new.dt_not_tec2);  
    		  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_DESP_GAB', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_desp_gab, :new.dt_desp_gab);  
     		  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_DEC_GAB_DLOG', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_dec_gab_dlog, :new.dt_dec_gab_dlog);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'DEC_POS_GABSE', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.dec_pos_gabse, :new.dec_pos_gabse);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENAL_APLIC1', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.penal_aplic1, :new.penal_aplic1);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENAL_APLIC3', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.penal_aplic3, :new.penal_aplic3);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENAL_APLIC3I', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.penal_aplic3I, :new.penal_aplic3I);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_NOT2', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_not2, :new.dt_not2);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_ENVIO_NOT2', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_envio_not2, :new.dt_envio_not2);  
   
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'FORMA_ENVIO2', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.forma_envio2, :new.forma_envio2);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_REC_NOT2', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_rec_not2, :new.dt_rec_not2);  
   
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'MOEDAGAB', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.moedagab, :new.moedagab);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'VL_MULTA_ATUA1', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_multa_atua1, :new.vl_multa_atua1);  
   
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'OBS2', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obs2, :new.obs2);  
		  
end if;  
end aud_mol_ana_gab;  

/
ALTER TRIGGER "ORIGINAL"."AUD_MOL_ANA_GAB" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MOL_ANA_GAB_BIU" 
    before insert or update  
    on mol_ana_gab 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mol_ocorrencia_biu; 

/
ALTER TRIGGER "ORIGINAL"."MOL_ANA_GAB_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MOL_ANA_GAB_ID_PK" ON "ORIGINAL"."MOL_ANA_GAB" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MOL_APLIC_PENAL" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MOL_APLIC_PENAL_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_PROCESSO" NUMBER, 
	"PENAL_APLIC" VARCHAR2(255 CHAR), 
	"PENAL_APLIC1" VARCHAR2(255 CHAR), 
	"PENAL_APLIC1I" VARCHAR2(255 CHAR), 
	"DT_NOTA_TEC" TIMESTAMP (6), 
	"DT_DECISAO" TIMESTAMP (6), 
	"DT_NOT" TIMESTAMP (6), 
	"DT_ENVIO_NOT" TIMESTAMP (6), 
	"DT_ENVIO_NOTI" TIMESTAMP (6), 
	"DT_ENVIO_PUBLIC" TIMESTAMP (6), 
	"FORMA_ENVIO" VARCHAR2(255 CHAR), 
	"FORMA_ENVIOI" VARCHAR2(255 CHAR), 
	"FORMA_ENVIOII" VARCHAR2(255 CHAR), 
	"DT_REC_NOT" TIMESTAMP (6), 
	"DT_PUBLICACAO" TIMESTAMP (6), 
	"DT_PAG_MULTA" TIMESTAMP (6), 
	"MOEDAAP" VARCHAR2(255 CHAR), 
	"VL_MULTA_APL" NUMBER, 
	"COTACAO" NUMBER, 
	"VL_TOTAL_REAL" NUMBER, 
	"OBS" VARCHAR2(4000 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MOL_APLIC_PENAL_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MOL_APLIC_PENAL" ADD CONSTRAINT "MOL_APLIC_PENAL_FK_COD_PROCESSO" FOREIGN KEY ("COD_PROCESSO")
	  REFERENCES "ORIGINAL"."MOL_PROCESSO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MOL_APLIC_PENAL" 
    after update or delete on mol_aplic_penal  
    for each row  
declare  
    t varchar2(128) := 'MOL_APLIC_PENAL';  
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
begin  
if updating then  
    if(:old.id is null and :new.id is not null) or  
        (:old.id is not null and :new.id is null) or  
        :old.id != :new.id then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);  
    end if;  
  
    if(:old.cod_processo is null and :new.cod_processo is not null) or  
        (:old.cod_processo is not null and :new.cod_processo is null) or  
        :old.cod_processo != :new.cod_processo then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
     end if;  
  
    if(:old.penal_aplic is null and :new.penal_aplic is not null) or  
        (:old.penal_aplic is not null and :new.penal_aplic is null) or  
        :old.penal_aplic != :new.penal_aplic then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_APLIC', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_aplic, :new.penal_aplic);  
     end if;  
   
    if(:old.penal_aplic1 is null and :new.penal_aplic1 is not null) or  
        (:old.penal_aplic1 is not null and :new.penal_aplic1 is null) or  
        :old.penal_aplic1 != :new.penal_aplic1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_APLIC1', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_aplic1, :new.penal_aplic1);  
     end if;  
 
     /*Alterações do dia 11 01 2024 - Herbert */  
    if(:old.penal_aplic1I is null and :new.penal_aplic1I is not null) or  
        (:old.penal_aplic1I is not null and :new.penal_aplic1I is null) or  
        :old.penal_aplic1I != :new.penal_aplic1I then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_APLIC1', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_aplic1I, :new.penal_aplic1I);  
     end if;  
   
 
    if(:old.dt_nota_tec is null and :new.dt_nota_tec is not null) or  
        (:old.dt_nota_tec is not null and :new.dt_nota_tec is null) or  
        :old.dt_nota_tec != :new.dt_nota_tec then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_NOTA_TEC', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_nota_tec, :new.dt_nota_tec);  
    end if;  
  
    if(:old.dt_decisao is null and :new.dt_decisao is not null) or  
        (:old.dt_decisao is not null and :new.dt_decisao is null) or  
        :old.dt_decisao != :new.dt_decisao then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_DECISAO', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_decisao, :new.dt_decisao);  
    end if;  
  
    if(:old.dt_not is null and :new.dt_not is not null) or  
        (:old.dt_not is not null and :new.dt_not is null) or  
        :old.dt_not != :new.dt_not then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_NOT', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_not, :new.dt_not);  
    end if;  
  
    if(:old.dt_envio_not is null and :new.dt_envio_not is not null) or  
        (:old.dt_envio_not is not null and :new.dt_envio_not is null) or  
        :old.dt_envio_not != :new.dt_envio_not then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ENVIO_NOT', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_envio_not, :new.dt_envio_not);  
    end if;  
   
    if(:old.dt_envio_notI is null and :new.dt_envio_notI is not null) or  
        (:old.dt_envio_notI is not null and :new.dt_envio_notI is null) or  
        :old.dt_envio_notI != :new.dt_envio_notI then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ENVIO_NOTI', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_envio_notI, :new.dt_envio_notI);  
    end if;  
  
    if(:old.dt_envio_public is null and :new.dt_envio_public is not null) or  
        (:old.dt_envio_public is not null and :new.dt_envio_public is null) or  
        :old.dt_envio_public != :new.dt_envio_public then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ENVIO_PUBLIC', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_envio_public, :new.dt_envio_public);  
    end if;  
   
    if(:old.forma_envio is null and :new.forma_envio is not null) or  
        (:old.forma_envio is not null and :new.forma_envio is null) or  
        :old.forma_envio != :new.forma_envio then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'FORMA_ENVIO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_envio, :new.forma_envio);  
     end if;  
  
    if(:old.forma_envioI is null and :new.forma_envioI is not null) or  
        (:old.forma_envioI is not null and :new.forma_envioI is null) or  
        :old.forma_envioI != :new.forma_envioI then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'FORMA_ENVIOI', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_envioI, :new.forma_envioI);  
     end if;  
 
    if(:old.forma_envioII is null and :new.forma_envioII is not null) or  
        (:old.forma_envioII is not null and :new.forma_envioII is null) or  
        :old.forma_envioII != :new.forma_envioII then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'FORMA_ENVIOII', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_envioII, :new.forma_envioII);  
     end if;  
 
    if(:old.dt_rec_not is null and :new.dt_rec_not is not null) or  
        (:old.dt_rec_not is not null and :new.dt_rec_not is null) or  
        :old.dt_rec_not != :new.dt_rec_not then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_REC_NOT', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_rec_not, :new.dt_rec_not);  
    end if;  
   
    if(:old.dt_publicacao is null and :new.dt_publicacao is not null) or  
        (:old.dt_publicacao is not null and :new.dt_publicacao is null) or  
        :old.dt_publicacao != :new.dt_publicacao then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_PUBLICACAO', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_publicacao, :new.dt_publicacao);  
    end if;  
 
    if(:old.dt_pag_multa is null and :new.dt_pag_multa is not null) or  
        (:old.dt_pag_multa is not null and :new.dt_pag_multa is null) or  
        :old.dt_pag_multa != :new.dt_pag_multa then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_PAG_MULTA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_pag_multa, :new.dt_pag_multa);  
    end if;  
      /* Alteração do dia 11 de Janeiro de 2024 - Herbert*/ 
  
    if(:old.moedaap is null and :new.moedaap is not null) or  
        (:old.moedaap is not null and :new.moedaap is null) or  
        :old.moedaap != :new.moedaap then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'MOEDAAP', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.moedaap, :new.moedaap);  
     end if;  
  
	if(:old.vl_multa_apl is null and :new.vl_multa_apl is not null) or  
        (:old.vl_multa_apl is not null and :new.vl_multa_apl is null) or  
        :old.vl_multa_apl != :new.vl_multa_apl then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'VL_MULTA_APL', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_multa_apl, :new.vl_multa_apl);  
    end if;  
   
	if(:old.cotacao is null and :new.cotacao is not null) or  
        (:old.cotacao is not null and :new.cotacao is null) or  
        :old.cotacao != :new.cotacao then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'COTACAO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cotacao, :new.cotacao);  
    end if;  
 
 	if(:old.vl_total_real is null and :new.vl_total_real is not null) or  
        (:old.vl_total_real is not null and :new.vl_total_real is null) or  
        :old.vl_total_real != :new.vl_total_real then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'VL_TOTAL_REAL', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_total_real, :new.vl_total_real);  
    end if;  
  
    if(:old.obs is null and :new.obs is not null) or  
        (:old.obs is not null and :new.obs is null) or  
        :old.obs != :new.obs then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'OBS', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obs, :new.obs);  
     end if;  
  
end if;  
  
if deleting then  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
         
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENAL_APLIC', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.penal_aplic, :new.penal_aplic);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENAL_APLIC1', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.penal_aplic1, :new.penal_aplic1);  
     /*Alterações do dia 11 01 2024 - Hrbert */ 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENAL_APLIC1I', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.penal_aplic1I, :new.penal_aplic1I);  
   
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_NOTA_TEC', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_nota_tec, :new.dt_nota_tec);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_DECISAO', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_decisao, :new.dt_decisao);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_NOT', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_not, :new.dt_not);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_ENVIO_NOT', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_envio_not, :new.dt_envio_not);  
   
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_ENVIO_NOTI', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_envio_notI, :new.dt_envio_notI);  
      
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_ENVIO_PUBLIC', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_envio_public, :new.dt_envio_public);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'FORMA_ENVIO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.forma_envio, :new.forma_envio);  
    
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'FORMA_ENVIOI', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.forma_envioI, :new.forma_envioI);  
     
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'FORMA_ENVIOII', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.forma_envioII, :new.forma_envioII);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_REC_NOT', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_rec_not, :new.dt_rec_not);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_PUBLICACAO', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_publicacao, :new.dt_publicacao);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_PAG_MULTA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_pag_multa, :new.dt_pag_multa);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'VL_MULTA_APL', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_multa_apl, :new.vl_multa_apl);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'COTACAO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cotacao, :new.cotacao);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'VL_TOTAL_REAL', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_total_real, :new.vl_total_real);  
 
     /* Alteração do dia 11 de Janeiro de 2024 - Herbert*/ 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'MOEDAAP', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.moedaap, :new.moedaap);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'OBS', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obs, :new.obs);  
  
end if;  
end aud_mol_aplic_penal;  

/
ALTER TRIGGER "ORIGINAL"."AUD_MOL_APLIC_PENAL" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MOL_APLIC_PENAL_BIU" 
    before insert or update  
    on mol_aplic_penal 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mol_divida_ativa_biu; 

/
ALTER TRIGGER "ORIGINAL"."MOL_APLIC_PENAL_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MOL_APLIC_PENAL_ID_PK" ON "ORIGINAL"."MOL_APLIC_PENAL" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MOL_CONTRATO" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MOL_CONTRATO_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_PROCESSO" NUMBER, 
	"NUM_PROC_EXEC1" VARCHAR2(20 CHAR), 
	"NUM_CONTRATO" VARCHAR2(255 CHAR), 
	"DT_ASS_CONTRATO" TIMESTAMP (6), 
	"DT_VIG_CONTRATO" TIMESTAMP (6), 
	"MOEDA1" VARCHAR2(30 CHAR), 
	"VL_CONTRATO" NUMBER, 
	"COTACAO" NUMBER, 
	"VL_TOTAL_CONTRATO" NUMBER, 
	"OBJ_CONTRATO" VARCHAR2(255 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MOL_CONTRATO_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MOL_CONTRATO" ADD CONSTRAINT "MOL_CONTRATO_FK_MOL_PROCESSO" FOREIGN KEY ("COD_PROCESSO")
	  REFERENCES "ORIGINAL"."MOL_PROCESSO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MOL_CONTRATO" 
    after update or delete on mol_contrato  
    for each row  
declare  
    t varchar2(128) := 'MOL_CONTRATO';  
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
begin  
if updating then  
    if(:old.id is null and :new.id is not null) or  
        (:old.id is not null and :new.id is null) or  
        :old.id != :new.id then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);  
    end if;  
  
    if(:old.cod_processo is null and :new.cod_processo is not null) or  
        (:old.cod_processo is not null and :new.cod_processo is null) or  
        :old.cod_processo != :new.cod_processo then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
     end if;  
	   
    if(:old.num_proc_exec1 is null and :new.num_proc_exec1 is not null) or  
        (:old.num_proc_exec1 is not null and :new.num_proc_exec1 is null) or  
        :old.num_proc_exec1 != :new.num_proc_exec1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'NUM_PROC_EXEC1', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_proc_exec1, :new.num_proc_exec1);  
    end if;  
		  
    if(:old.num_contrato is null and :new.num_contrato is not null) or  
        (:old.num_contrato is not null and :new.num_contrato is null) or  
        :old.num_contrato != :new.num_contrato then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'NUM_CONTRATO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_contrato, :new.num_contrato);  
    end if;  
  
    if(:old.dt_ass_contrato is null and :new.dt_ass_contrato is not null) or  
        (:old.dt_ass_contrato is not null and :new.dt_ass_contrato is null) or  
        :old.dt_ass_contrato != :new.dt_ass_contrato then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ASS_CONTRATO', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_ass_contrato, :new.dt_ass_contrato);  
    end if;  
  
    if(:old.dt_vig_contrato is null and :new.dt_vig_contrato is not null) or  
        (:old.dt_vig_contrato is not null and :new.dt_vig_contrato is null) or  
        :old.dt_vig_contrato != :new.dt_vig_contrato then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_VIG_CONTRATO', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_vig_contrato, :new.dt_vig_contrato);  
    end if;  
 
    if(:old.moeda1 is null and :new.moeda1 is not null) or  
        (:old.moeda1 is not null and :new.moeda1 is null) or  
        :old.moeda1 != :new.moeda1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'MOEDA1', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.moeda1, :new.moeda1);  
    end if;  
	  
	if(:old.vl_contrato is null and :new.vl_contrato is not null) or  
        (:old.vl_contrato is not null and :new.vl_contrato is null) or  
        :old.vl_contrato != :new.vl_contrato then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'VL_CONTRATO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_contrato, :new.vl_contrato);  
    end if;  
 
	if(:old.cotacao is null and :new.cotacao is not null) or  
        (:old.cotacao is not null and :new.cotacao is null) or  
        :old.cotacao != :new.cotacao then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'COTACAO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cotacao, :new.cotacao);  
    end if;  
 
	if(:old.vl_total_contrato is null and :new.vl_total_contrato is not null) or  
        (:old.vl_total_contrato is not null and :new.vl_total_contrato is null) or  
        :old.vl_total_contrato != :new.vl_total_contrato then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'VL_TOTAL_CONTRATO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_total_contrato, :new.vl_total_contrato);  
    end if;  
 
	if(:old.obj_contrato is null and :new.obj_contrato is not null) or  
        (:old.obj_contrato is not null and :new.obj_contrato is null) or  
        :old.obj_contrato != :new.obj_contrato then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'OBJ_CONTRATO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obj_contrato, :new.obj_contrato);  
    end if;  
  
end if;  
  
if deleting then  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'NUM_PROC_EXEC1', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_proc_exec1, :new.num_proc_exec1);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'NUM_CONTRATO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_contrato, :new.num_contrato);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_ASS_CONTRATO', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_ass_contrato, :new.dt_ass_contrato);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_VIG_CONTRATO', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_vig_contrato, :new.dt_vig_contrato);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'MOEDA1', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.moeda1, :new.moeda1);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'VL_CONTRATO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_contrato, :new.vl_contrato);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'COTACAO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cotacao, :new.cotacao);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'VL_TOTAL_CONTRATO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_total_contrato, :new.vl_total_contrato);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'OBJ_CONTRATO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obj_contrato, :new.obj_contrato);  
  
end if;  
end aud_mol_contrato; 

/
ALTER TRIGGER "ORIGINAL"."AUD_MOL_CONTRATO" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MOL_CONTRATO_BIU" 
    before insert or update  
    on mol_contrato 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mol_contrato_biu; 

/
ALTER TRIGGER "ORIGINAL"."MOL_CONTRATO_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MOL_CONTRATO_ID_PK" ON "ORIGINAL"."MOL_CONTRATO" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MOL_HISTORY" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MOL_HISTORY_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"TABLE_NAME" VARCHAR2(128 CHAR), 
	"COLUMN_NAME" VARCHAR2(128 CHAR), 
	"ACTION" VARCHAR2(1 CHAR), 
	"ACTION_DATE" TIMESTAMP (6), 
	"ACTION_BY" VARCHAR2(255 CHAR), 
	"DATA_TYPE" VARCHAR2(255 CHAR), 
	"PK1" NUMBER, 
	"TAB_ROW_VERSION" NUMBER, 
	"OLD_VC" VARCHAR2(4000 CHAR), 
	"NEW_VC" VARCHAR2(4000 CHAR), 
	"OLD_NUMBER" NUMBER, 
	"NEW_NUMBER" NUMBER, 
	"OLD_DATE" TIMESTAMP (6), 
	"NEW_DATE" TIMESTAMP (6), 
	"OLD_TS" TIMESTAMP (6), 
	"NEW_TS" TIMESTAMP (6), 
	"OLD_CLOB" CLOB, 
	"NEW_CLOB" CLOB, 
	"OLD_BLOB" BLOB, 
	"NEW_BLOB" BLOB, 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MOL_HISTORY_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "APEX_3775593283083513" 
 LOB ("OLD_CLOB") STORE AS SECUREFILE (
  TABLESPACE "APEX_3775593283083513" ENABLE STORAGE IN ROW 4000 CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) 
 LOB ("NEW_CLOB") STORE AS SECUREFILE (
  TABLESPACE "APEX_3775593283083513" ENABLE STORAGE IN ROW 4000 CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) 
 LOB ("OLD_BLOB") STORE AS SECUREFILE (
  TABLESPACE "APEX_3775593283083513" ENABLE STORAGE IN ROW 4000 CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) 
 LOB ("NEW_BLOB") STORE AS SECUREFILE (
  TABLESPACE "APEX_3775593283083513" ENABLE STORAGE IN ROW 4000 CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MOL_HISTORY_BIU" 
    before insert or update  
    on mol_history 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mol_history_biu; 

/
ALTER TRIGGER "ORIGINAL"."MOL_HISTORY_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."SYS_IL0000076620C00019$$" ON "ORIGINAL"."MOL_HISTORY" (
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE( INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" 
  PARALLEL (DEGREE 0 INSTANCES 0) ;
  CREATE UNIQUE INDEX "ORIGINAL"."SYS_IL0000076620C00018$$" ON "ORIGINAL"."MOL_HISTORY" (
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE( INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" 
  PARALLEL (DEGREE 0 INSTANCES 0) ;
  CREATE UNIQUE INDEX "ORIGINAL"."SYS_IL0000076620C00020$$" ON "ORIGINAL"."MOL_HISTORY" (
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE( INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" 
  PARALLEL (DEGREE 0 INSTANCES 0) ;
  CREATE UNIQUE INDEX "ORIGINAL"."MOL_HISTORY_ID_PK" ON "ORIGINAL"."MOL_HISTORY" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "APEX_3775593283083513" ;
  CREATE UNIQUE INDEX "ORIGINAL"."SYS_IL0000076620C00021$$" ON "ORIGINAL"."MOL_HISTORY" (
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE( INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" 
  PARALLEL (DEGREE 0 INSTANCES 0) ;
;

CREATE TABLE "ORIGINAL"."MOL_INSC_DIV_ATIVA" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MOL_INSC_DIV_ATIVA_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_PROCESSO" NUMBER, 
	"DT_NOT_EMPRE" TIMESTAMP (6), 
	"DT_NOT_ENV_DA" TIMESTAMP (6), 
	"FORMA_ENVIO_PGFN" VARCHAR2(255 CHAR), 
	"FORMA_ENV_DA1" VARCHAR2(255 CHAR), 
	"DT_FORMA_DA1" TIMESTAMP (6), 
	"FORMA_ENV_DA2" VARCHAR2(255 CHAR), 
	"DT_FORMA_DA2" TIMESTAMP (6), 
	"FORMA_ENV_DA3" VARCHAR2(255 CHAR), 
	"DT_FORMA_DA3" TIMESTAMP (6), 
	"DT_REC_DA" TIMESTAMP (6), 
	"DT_PUBLIC_DA" TIMESTAMP (6), 
	"DT_NOT_PGFN" TIMESTAMP (6), 
	"NUM_PED" VARCHAR2(255 CHAR), 
	"STATUS" VARCHAR2(255 CHAR), 
	"DT_INSCR" TIMESTAMP (6), 
	"OBS5" VARCHAR2(255 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MOL_INSC_DIV_ATI_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MOL_INSC_DIV_ATIVA" ADD CONSTRAINT "MOL_INSC_DIV_ATIVA_FK_COD_PROCESSO" FOREIGN KEY ("COD_PROCESSO")
	  REFERENCES "ORIGINAL"."MOL_PROCESSO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MOL_INSC_DIV_ATIVA" 
    after update or delete on mol_insc_div_ativa  
    for each row  
declare  
    t varchar2(128) := 'MOL_INSC_DIV_ATIVA';  
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
begin  
if updating then  
    if(:old.id is null and :new.id is not null) or  
        (:old.id is not null and :new.id is null) or  
        :old.id != :new.id then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);  
    end if;  
  
    if(:old.cod_processo is null and :new.cod_processo is not null) or  
        (:old.cod_processo is not null and :new.cod_processo is null) or  
        :old.cod_processo != :new.cod_processo then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
    end if;  
   
    if(:old.dt_not_empre is null and :new.dt_not_empre is not null) or  
        (:old.dt_not_empre is not null and :new.dt_not_empre is null) or  
        :old.dt_not_empre != :new.dt_not_empre then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_NOT_EMPRE', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_not_empre, :new.dt_not_empre);  
    end if;  
 
    if(:old.dt_not_env_da is null and :new.dt_not_env_da is not null) or  
        (:old.dt_not_env_da is not null and :new.dt_not_env_da is null) or  
        :old.dt_not_env_da != :new.dt_not_env_da then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_NOT_ENV_DA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_not_env_da, :new.dt_not_env_da);  
    end if;  
      
    if(:old.forma_envio_pgfn is null and :new.forma_envio_pgfn is not null) or   
        (:old.forma_envio_pgfn is not null and :new.forma_envio_pgfn is null) or   
        :old.forma_envio_pgfn != :new.forma_envio_pgfn then   
        insert into mol_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mol_history_seq.nextval, t, 'FORMA_ENVIO_PGFN', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_envio_pgfn, :new.forma_envio_pgfn);   
     end if;   
      
    if(:old.forma_env_da1 is null and :new.forma_env_da1 is not null) or   
        (:old.forma_env_da1 is not null and :new.forma_env_da1 is null) or   
        :old.forma_env_da1 != :new.forma_env_da1 then   
        insert into mol_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mol_history_seq.nextval, t, 'FORMA_ENV_DA1', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_env_da1, :new.forma_env_da1);   
     end if;   
 
    if(:old.dt_forma_da1 is null and :new.dt_forma_da1 is not null) or  
        (:old.dt_forma_da1 is not null and :new.dt_forma_da1 is null) or  
        :old.dt_forma_da1 != :new.dt_forma_da1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_FORMA_DA1', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_forma_da1, :new.dt_forma_da1);  
     end if;  
 
    if(:old.forma_env_da2 is null and :new.forma_env_da2 is not null) or   
        (:old.forma_env_da2 is not null and :new.forma_env_da2 is null) or   
        :old.forma_env_da2 != :new.forma_env_da2 then   
        insert into mol_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mol_history_seq.nextval, t, 'FORMA_ENV_DA2', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_env_da2, :new.forma_env_da2);   
     end if;   
 
    if(:old.dt_forma_da2 is null and :new.dt_forma_da2 is not null) or  
        (:old.dt_forma_da2 is not null and :new.dt_forma_da2 is null) or  
        :old.dt_forma_da2 != :new.dt_forma_da2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_FORMA_DA2', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_forma_da2, :new.dt_forma_da2);  
     end if;  
 
    if(:old.forma_env_da3 is null and :new.forma_env_da3 is not null) or   
        (:old.forma_env_da3 is not null and :new.forma_env_da3 is null) or   
        :old.forma_env_da3 != :new.forma_env_da3 then   
        insert into mol_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mol_history_seq.nextval, t, 'FORMA_ENV_DA3', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_env_da3, :new.forma_env_da3);   
     end if;   
 
    if(:old.dt_forma_da3 is null and :new.dt_forma_da3 is not null) or  
        (:old.dt_forma_da3 is not null and :new.dt_forma_da3 is null) or  
        :old.dt_forma_da3 != :new.dt_forma_da3 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_FORMA_DA3', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_forma_da3, :new.dt_forma_da3);  
     end if;  
 
    if(:old.dt_rec_da is null and :new.dt_rec_da is not null) or  
        (:old.dt_rec_da is not null and :new.dt_rec_da is null) or  
        :old.dt_rec_da != :new.dt_rec_da then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_REC_DA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_rec_da, :new.dt_rec_da);  
     end if;  
 
    if(:old.dt_public_da is null and :new.dt_public_da is not null) or  
        (:old.dt_public_da is not null and :new.dt_public_da is null) or  
        :old.dt_public_da != :new.dt_public_da then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_PUBLIC_DA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_public_da, :new.dt_public_da);  
     end if;  
 
    if(:old.dt_not_pgfn is null and :new.dt_not_pgfn is not null) or  
        (:old.dt_not_pgfn is not null and :new.dt_not_pgfn is null) or  
        :old.dt_not_pgfn != :new.dt_not_pgfn then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_NOT_PGFN', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_not_pgfn, :new.dt_not_pgfn);  
     end if;  
    
    if(:old.num_ped is null and :new.num_ped is not null) or  
        (:old.num_ped is not null and :new.num_ped is null) or  
        :old.num_ped != :new.num_ped then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'NUM_PED', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_ped, :new.num_ped);  
     end if;  
    
    if(:old.status is null and :new.status is not null) or  
        (:old.status is not null and :new.status is null) or  
        :old.status != :new.status then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'STATUS', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.status, :new.status);  
     end if;  
 
    if(:old.dt_inscr is null and :new.dt_inscr is not null) or  
        (:old.dt_inscr is not null and :new.dt_inscr is null) or  
        :old.dt_inscr != :new.dt_inscr then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_INSCR', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_inscr, :new.dt_inscr);  
     end if;   
 
    if(:old.obs5 is null and :new.obs5 is not null) or  
        (:old.obs5 is not null and :new.obs5 is null) or  
        :old.obs5 != :new.obs5 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'OBS5', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obs5, :new.obs5);  
     end if;  
  
end if;  
  
if deleting then  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
				  
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_NOT_EMPRE', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_not_empre, :new.dt_not_empre);  
				  
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_NOT_ENV_DA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_not_env_da, :new.dt_not_env_da);  
  
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'FORMA_ENVIO_PGFN', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.forma_envio_pgfn, :new.forma_envio_pgfn);		  
 
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'FORMA_ENV_DA1', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.forma_env_da1, :new.forma_env_da1);	 
 
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_FORMA_DA1', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_forma_da1, :new.dt_forma_da1);  
 
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'FORMA_ENV_DA2', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.forma_env_da2, :new.forma_env_da2);	 
 
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_FORMA_DA2', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_forma_da2, :new.dt_forma_da2);  
 
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'FORMA_ENV_DA3', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.forma_env_da3, :new.forma_env_da3);	 
 
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_FORMA_DA3', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_forma_da3, :new.dt_forma_da3);  
 
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_REC_DA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_rec_da, :new.dt_rec_da);  
 
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_PUBLIC_DA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_public_da, :new.dt_public_da);  
 
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_NOT_PGFN', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_not_pgfn, :new.dt_not_pgfn);  
	  
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'NUM_PED', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_ped, :new.num_ped);		  
	  
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'STATUS', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.status, :new.status);	  
				  
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_INSCR', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_inscr, :new.dt_inscr);  
  
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'OBS5', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obs5, :new.obs5);		  
	  
  
end if;  
end aud_mol_insc_div_ativa;  

/
ALTER TRIGGER "ORIGINAL"."AUD_MOL_INSC_DIV_ATIVA" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MOL_INSC_DIV_ATIVA_BIU" 
    before insert or update  
    on mol_insc_div_ativa 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mol_penalidade_recurso_biu; 

/
ALTER TRIGGER "ORIGINAL"."MOL_INSC_DIV_ATIVA_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MOL_INSC_DIV_ATI_ID_PK" ON "ORIGINAL"."MOL_INSC_DIV_ATIVA" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MOL_NOTA_EMP" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MOL_NOTA_EMP_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_PROCESSO" NUMBER, 
	"NUM_PROC_EXEC" VARCHAR2(20 CHAR), 
	"MOD_CONTRAT" VARCHAR2(255 CHAR), 
	"NUM_NOTA_EMP" VARCHAR2(255 CHAR), 
	"DT_NOTA_EMP" TIMESTAMP (6), 
	"VL_CONTRATO" NUMBER, 
	"OBJ_CONTRATO_NE" VARCHAR2(4000 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MOL_NOTA_EMP_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MOL_NOTA_EMP" ADD CONSTRAINT "MOL_NOTA_EMP_FK_MOL_PROCESSO" FOREIGN KEY ("COD_PROCESSO")
	  REFERENCES "ORIGINAL"."MOL_PROCESSO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MOL_NOTA_EMP" 
    after update or delete on mol_nota_emp  
    for each row  
declare  
    t varchar2(128) := 'MOL_NOTA_EMP';  
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
begin  
if updating then  
    if(:old.id is null and :new.id is not null) or  
        (:old.id is not null and :new.id is null) or  
        :old.id != :new.id then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);  
    end if;  
  
    if(:old.cod_processo is null and :new.cod_processo is not null) or  
        (:old.cod_processo is not null and :new.cod_processo is null) or  
        :old.cod_processo != :new.cod_processo then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
     end if;  
  
    if(:old.num_proc_exec is null and :new.num_proc_exec is not null) or  
        (:old.num_proc_exec is not null and :new.num_proc_exec is null) or  
        :old.num_proc_exec != :new.num_proc_exec then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type,  old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'NUM_PROC_EXEC', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_proc_exec, :new.num_proc_exec);  
    end if;  
		  
    if(:old.num_nota_emp is null and :new.num_nota_emp is not null) or  
        (:old.num_nota_emp is not null and :new.num_nota_emp is null) or  
        :old.num_nota_emp != :new.num_nota_emp then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'NUM_NOTA_EMP', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_nota_emp, :new.num_nota_emp);  
    end if;  
  
    if(:old.dt_nota_emp is null and :new.dt_nota_emp is not null) or  
        (:old.dt_nota_emp is not null and :new.dt_nota_emp is null) or  
        :old.dt_nota_emp != :new.dt_nota_emp then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_NOTA_EMP', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_nota_emp, :new.dt_nota_emp);  
    end if;  
  
 /*Lembrar de Retirar MOEDA quando for rodar em Produção*/ 
 
  --  if(:old.moeda is null and :new.moeda is not null) or  
   --     (:old.moeda is not null and :new.moeda is null) or  
    --    :old.moeda != :new.moeda then  
    --    insert into mol_history (  
    --        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    --    ) values (  
    --      mol_history_seq.nextval, t, 'MOEDA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.moeda, :new.moeda);  
    --end if;  
 /*Lembrar de Retirar MOEDA quando for rodar em Produção*/ 
 
    if(:old.vl_contrato is null and :new.vl_contrato is not null) or  
        (:old.vl_contrato is not null and :new.vl_contrato is null) or  
        :old.vl_contrato != :new.vl_contrato then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'VL_CONTRATO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_contrato, :new.vl_contrato);  
    end if;  
		  
    if(:old.obj_contrato_ne is null and :new.obj_contrato_ne is not null) or  
        (:old.obj_contrato_ne is not null and :new.obj_contrato_ne is null) or  
        :old.obj_contrato_ne != :new.obj_contrato_ne then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'OBJ_CONTRATO_NE', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obj_contrato_ne, :new.obj_contrato_ne);  
    end if;  
 
    if(:old.mod_contrat is null and :new.mod_contrat is not null) or  
        (:old.mod_contrat is not null and :new.mod_contrat is null) or  
        :old.mod_contrat != :new.mod_contrat then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'MOD_CONTRAT', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.mod_contrat, :new.mod_contrat);  
    end if;  
  
end if;  
  
if deleting then  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'NUM_PROC_EXEC', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_proc_exec, :new.num_proc_exec);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'MOD_CONTRAT', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.mod_contrat, :new.mod_contrat);  
	  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'NUM_NOTA_EMP', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_nota_emp, :new.num_nota_emp);	  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_NOTA_EMP', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_nota_emp, :new.dt_nota_emp);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'VL_CONTRATO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_contrato, :new.vl_contrato);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'OBJ_CONTRATO_NE', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obj_contrato_ne, :new.obj_contrato_ne);  
  
end if;  
end aud_mol_nota_emp; 

/
ALTER TRIGGER "ORIGINAL"."AUD_MOL_NOTA_EMP" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MOL_NOTA_EMP_BIU" 
    before insert or update  
    on mol_nota_emp 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mol_contrato_biu; 

/
ALTER TRIGGER "ORIGINAL"."MOL_NOTA_EMP_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MOL_NOTA_EMP_ID_PK" ON "ORIGINAL"."MOL_NOTA_EMP" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MOL_PED_REC" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MOL_PED_REC_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_PROCESSO" NUMBER, 
	"DT_INT_PED" TIMESTAMP (6), 
	"DT_NOT_TEC3" TIMESTAMP (6), 
	"DEC_APOS_ANA" VARCHAR2(255 CHAR), 
	"PENAL_APLIC2" VARCHAR2(255 CHAR), 
	"PENAL_APLIC4" VARCHAR2(255 CHAR), 
	"PENAL_APLIC4I" VARCHAR2(255 CHAR), 
	"DT_NOT3" TIMESTAMP (6), 
	"DT_ENVIO_NOT3" TIMESTAMP (6), 
	"DT_ENVIO_NOT3I" TIMESTAMP (6), 
	"DT_ENVIO_PUBLIC3" TIMESTAMP (6), 
	"FORMA_ENVIO3" VARCHAR2(255 CHAR), 
	"FORMA_ENVIO3I" VARCHAR2(255 CHAR), 
	"FORMA_ENVIO3II" VARCHAR2(255 CHAR), 
	"DT_PUBLICACAO3" TIMESTAMP (6), 
	"DT_DECISAO3" TIMESTAMP (6), 
	"DT_REC_NOT3" TIMESTAMP (6), 
	"DT_PAG_MULTA3" TIMESTAMP (6), 
	"MOEDAPR" VARCHAR2(30 CHAR), 
	"VL_MULTA_ATUA2" NUMBER, 
	"OBS3" VARCHAR2(4000 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MOL_PED_REC_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MOL_PED_REC" ADD CONSTRAINT "MOL_PED_REC_FK_COD_PROCESSO" FOREIGN KEY ("COD_PROCESSO")
	  REFERENCES "ORIGINAL"."MOL_PROCESSO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MOL_PED_REC" 
    after update or delete on mol_ped_rec  
    for each row  
declare  
    t varchar2(128) := 'MOL_PED_REC';  
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
begin  
if updating then  
    if(:old.id is null and :new.id is not null) or  
        (:old.id is not null and :new.id is null) or  
        :old.id != :new.id then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);  
    end if;  
  
    if(:old.cod_processo is null and :new.cod_processo is not null) or  
        (:old.cod_processo is not null and :new.cod_processo is null) or  
        :old.cod_processo != :new.cod_processo then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
     end if;  
   
    if(:old.dt_int_ped is null and :new.dt_int_ped is not null) or  
        (:old.dt_int_ped is not null and :new.dt_int_ped is null) or  
        :old.dt_int_ped != :new.dt_int_ped then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_INT_PED', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_int_ped, :new.dt_int_ped);  
    end if;  
  
    if(:old.dt_not_tec3 is null and :new.dt_not_tec3 is not null) or  
        (:old.dt_not_tec3 is not null and :new.dt_not_tec3 is null) or  
        :old.dt_not_tec3 != :new.dt_not_tec3 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_NOT_TEC3', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_not_tec3, :new.dt_not_tec3);  
    end if;  
  
    if(:old.dec_apos_ana is null and :new.dec_apos_ana is not null) or  
        (:old.dec_apos_ana is not null and :new.dec_apos_ana is null) or  
        :old.dec_apos_ana != :new.dec_apos_ana then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'DEC_APOS_ANA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.dec_apos_ana, :new.dec_apos_ana);  
     end if;  
  
    if(:old.penal_aplic2 is null and :new.penal_aplic2 is not null) or  
        (:old.penal_aplic2 is not null and :new.penal_aplic2 is null) or  
        :old.penal_aplic2 != :new.penal_aplic2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_APLIC2', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_aplic2, :new.penal_aplic2);  
     end if;  
  
    if(:old.penal_aplic4 is null and :new.penal_aplic4 is not null) or  
        (:old.penal_aplic4 is not null and :new.penal_aplic4 is null) or  
        :old.penal_aplic4 != :new.penal_aplic4 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_APLIC4', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_aplic4, :new.penal_aplic4);  
     end if;  
     /* Alteração do dia 11 de Janeiro de 2024 - Herbert*/ 
  
    if(:old.penal_aplic4I is null and :new.penal_aplic4I is not null) or  
        (:old.penal_aplic4I is not null and :new.penal_aplic4I is null) or  
        :old.penal_aplic4I != :new.penal_aplic4I then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_APLIC4I', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_aplic4I, :new.penal_aplic4I);  
     end if;  
 
    if(:old.dt_not3 is null and :new.dt_not3 is not null) or  
        (:old.dt_not3 is not null and :new.dt_not3 is null) or  
        :old.dt_not3 != :new.dt_not3 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_NOT3', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_not3, :new.dt_not3);  
    end if;  
  
    if(:old.dt_envio_not3 is null and :new.dt_envio_not3 is not null) or  
        (:old.dt_envio_not3 is not null and :new.dt_envio_not3 is null) or  
        :old.dt_envio_not3 != :new.dt_envio_not3 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ENVIO_NOT3', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_envio_not3, :new.dt_envio_not3);  
    end if;  
   
    if(:old.dt_envio_not3I is null and :new.dt_envio_not3I is not null) or  
        (:old.dt_envio_not3I is not null and :new.dt_envio_not3I is null) or  
        :old.dt_envio_not3I != :new.dt_envio_not3I then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ENVIO_NOT3I', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_envio_not3I, :new.dt_envio_not3I);  
    end if;  
    
    if(:old.dt_envio_public3 is null and :new.dt_envio_public3 is not null) or  
        (:old.dt_envio_public3 is not null and :new.dt_envio_public3 is null) or  
        :old.dt_envio_public3 != :new.dt_envio_public3 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ENVIO_PUBLIC3', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_envio_public3, :new.dt_envio_public3);  
    end if;  
  
    if(:old.forma_envio3 is null and :new.forma_envio3 is not null) or  
        (:old.forma_envio3 is not null and :new.forma_envio3 is null) or  
        :old.forma_envio3 != :new.forma_envio3 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'FORMA_ENVIO3', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_envio3, :new.forma_envio3);  
     end if;  
   
    if(:old.forma_envio3I is null and :new.forma_envio3I is not null) or  
        (:old.forma_envio3I is not null and :new.forma_envio3I is null) or  
        :old.forma_envio3I != :new.forma_envio3I then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'FORMA_ENVIO3I', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_envio3I, :new.forma_envio3I);  
     end if;  
    
    if(:old.forma_envio3II is null and :new.forma_envio3II is not null) or  
        (:old.forma_envio3II is not null and :new.forma_envio3II is null) or  
        :old.forma_envio3II != :new.forma_envio3II then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'FORMA_ENVIO3II', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.forma_envio3II, :new.forma_envio3II);  
     end if;  
   
    if(:old.dt_publicacao3 is null and :new.dt_publicacao3 is not null) or  
        (:old.dt_publicacao3 is not null and :new.dt_publicacao3 is null) or  
        :old.dt_publicacao3 != :new.dt_publicacao3 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_PUBLICACAO3', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_publicacao3, :new.dt_publicacao3);  
    end if;  
  
    if(:old.dt_decisao3 is null and :new.dt_decisao3 is not null) or  
        (:old.dt_decisao3 is not null and :new.dt_decisao3 is null) or  
        :old.dt_decisao3 != :new.dt_decisao3 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_DECISAO3', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_decisao3, :new.dt_decisao3);  
    end if;  
  
    if(:old.dt_rec_not3 is null and :new.dt_rec_not3 is not null) or  
        (:old.dt_rec_not3 is not null and :new.dt_rec_not3 is null) or  
        :old.dt_rec_not3 != :new.dt_rec_not3 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_REC_NOT3', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_rec_not3, :new.dt_rec_not3);  
    end if;  
  
    if(:old.dt_pag_multa3 is null and :new.dt_pag_multa3 is not null) or  
        (:old.dt_pag_multa3 is not null and :new.dt_pag_multa3 is null) or  
        :old.dt_pag_multa3 != :new.dt_pag_multa3 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_PAG_MULTA3', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_pag_multa3, :new.dt_pag_multa3);  
    end if;  
  
	if(:old.vl_multa_atua2 is null and :new.vl_multa_atua2 is not null) or  
        (:old.vl_multa_atua2 is not null and :new.vl_multa_atua2 is null) or  
        :old.vl_multa_atua2 != :new.vl_multa_atua2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'VL_MULTA_ATUA2', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_multa_atua2, :new.vl_multa_atua2);  
    end if;  
    
    if(:old.moedapr is null and :new.moedapr is not null) or  
        (:old.moedapr is not null and :new.moedapr is null) or  
        :old.moedapr != :new.moedapr then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'MOEDAPR', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.moedapr, :new.moedapr);  
     end if;  
   
    if(:old.obs3 is null and :new.obs3 is not null) or  
        (:old.obs3 is not null and :new.obs3 is null) or  
        :old.obs3 != :new.obs3 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'OBS3', :old.id, null, 'U', sysdate, u, 'VARCHAR3', :old.obs3, :new.obs3);  
     end if;  
  
end if;  
  
if deleting then  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
     /* Alteração do dia 11 de Janeiro de 2024 - Herbert*/ 
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_INT_PED', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_int_ped, :new.dt_int_ped);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_NOT_TEC3', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_not_tec3, :new.dt_not_tec3);  
    		  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'DEC_APOS_ANA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.dec_apos_ana, :new.dec_apos_ana);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENAL_APLIC2', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.penal_aplic2, :new.penal_aplic2);  
   
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENAL_APLIC4', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.penal_aplic4, :new.penal_aplic4);  
      
     /* Alteração do dia 11 de Janeiro de 2024 - Herbert*/ 
      insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENAL_APLIC4I', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.penal_aplic4I, :new.penal_aplic4I);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_NOT3', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_not3, :new.dt_not3);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_ENVIO_NOT3', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_envio_not3, :new.dt_envio_not3);  
   
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'FORMA_ENVIO3', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.forma_envio3, :new.forma_envio3);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_DECISAO3', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_decisao3, :new.dt_decisao3);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_REC_NOT3', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_rec_not3, :new.dt_rec_not3);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_PAG_MULTA3', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_pag_multa3, :new.dt_pag_multa3);  
    
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'MOEDAPR', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.moedapr, :new.moedapr);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'VL_MULTA_ATUA2', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_multa_atua2, :new.vl_multa_atua2);  
   
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'OBS3', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obs3, :new.obs3);  
end if;  
end aud_mol_ped_rec;  

/
ALTER TRIGGER "ORIGINAL"."AUD_MOL_PED_REC" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MOL_PED_REC_BIU" 
    before insert or update  
    on mol_ped_rec 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mol_penalidade_biu; 

/
ALTER TRIGGER "ORIGINAL"."MOL_PED_REC_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MOL_PED_REC_ID_PK" ON "ORIGINAL"."MOL_PED_REC" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MOL_PENAL_MULTA" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MOL_PENAL_MULTA_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_PROCESSO" NUMBER, 
	"DESC_MULTA" VARCHAR2(255 CHAR), 
	"MOEDAPM" VARCHAR2(30 CHAR), 
	"VL_MULTA_PG" NUMBER, 
	"DT_MULTA" TIMESTAMP (6), 
	"OBS4" VARCHAR2(4000 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MOL_PENAL_MULTA_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MOL_PENAL_MULTA" ADD CONSTRAINT "MOL_PENAL_MULTA_FK_COD_PROCESSO" FOREIGN KEY ("COD_PROCESSO")
	  REFERENCES "ORIGINAL"."MOL_PROCESSO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_PENAL_MULTA" 
    after update or delete on mol_penal_multa  
    for each row  
declare  
    t varchar2(128) := 'MOL_PENAL_MULTA';  
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
begin  
if updating then  
    if(:old.id is null and :new.id is not null) or  
        (:old.id is not null and :new.id is null) or  
        :old.id != :new.id then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);  
    end if;  
  
    if(:old.cod_processo is null and :new.cod_processo is not null) or  
        (:old.cod_processo is not null and :new.cod_processo is null) or  
        :old.cod_processo != :new.cod_processo then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
     end if;  
    
    if(:old.desc_multa is null and :new.desc_multa is not null) or  
        (:old.desc_multa is not null and :new.desc_multa is null) or  
        :old.desc_multa != :new.desc_multa then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'DESC_MULTA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obs4, :new.obs4);  
     end if;  
  
       /* Alteração do dia 11 de Janeiro de 2024 - Herbert*/ 
     if(:old.moedapm is null and :new.moedapm is not null) or  
        (:old.moedapm is not null and :new.moedapm is null) or  
        :old.moedapm != :new.moedapm then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'MOEDAPM', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.moedapm, :new.moedapm);  
     end if;  
 
    if(:old.vl_multa_pg is null and :new.vl_multa_pg is not null) or  
        (:old.vl_multa_pg is not null and :new.vl_multa_pg is null) or  
        :old.vl_multa_pg != :new.vl_multa_pg then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'COD_MULTA_PAG', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_multa_pg, :new.vl_multa_pg);  
     end if;  
       
    if(:old.dt_multa is null and :new.dt_multa is not null) or  
        (:old.dt_multa is not null and :new.dt_multa is null) or  
        :old.dt_multa != :new.dt_multa then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_MULTA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_multa, :new.dt_multa);  
    end if;  
   
    if(:old.obs4 is null and :new.obs4 is not null) or  
        (:old.obs4 is not null and :new.obs4 is null) or  
        :old.obs4 != :new.obs4 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'OBS4', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obs4, :new.obs4);  
     end if;  
    
end if;  
  
if deleting then  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
  
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'DESC_MULTA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.desc_multa, :new.desc_multa);	 
 
      /* Alteração do dia 11 de Janeiro de 2024 - Herbert*/ 
 	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'MOEDAPM', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.moedapm, :new.moedapm);	 
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'VL_MULTA_PAG', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_multa_pg, :new.vl_multa_pg);	  
 
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_MULTA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_multa, :new.dt_multa);  
 
		insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'OBS4', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obs4, :new.obs4);		  
	  
end if;  
end aud_mol_penal_multa; 

/
ALTER TRIGGER "ORIGINAL"."AUD_PENAL_MULTA" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MOL_PENAL_MULTA_BIU" 
    before insert or update  
    on mol_penal_multa 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mol_recurso_adm_biu; 

/
ALTER TRIGGER "ORIGINAL"."MOL_PENAL_MULTA_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MOL_PENAL_MULTA_ID_PK" ON "ORIGINAL"."MOL_PENAL_MULTA" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MOL_PROCESSO" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MOL_PROCESSO_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"TIPO_PROCESSO" VARCHAR2(255 CHAR), 
	"NUMERO_PROCESSO" VARCHAR2(20 CHAR) NOT NULL ENABLE, 
	"DT_INSTAURA" TIMESTAMP (6), 
	"DT_ULT_MOV" TIMESTAMP (6), 
	"STATUS_PROCESSO" VARCHAR2(255 CHAR), 
	"TEC_ANALISTA" VARCHAR2(50 CHAR), 
	"RAZAO_SOC_NAC" VARCHAR2(255 CHAR), 
	"CNPJ" VARCHAR2(18 CHAR), 
	"EMPRESA_ESTRAG" VARCHAR2(255 CHAR), 
	"RAZAO_SOC_EST" VARCHAR2(255 CHAR), 
	"MODAL_CONTR" VARCHAR2(255 CHAR), 
	"NUM_PREGAO" VARCHAR2(255 CHAR), 
	"ARP" VARCHAR2(255 CHAR), 
	"NUM_ARP" VARCHAR2(30 CHAR), 
	"OBJ_CONTR" VARCHAR2(4000 CHAR), 
	"INFRACAO" VARCHAR2(255 CHAR), 
	"PENA_SUG_FISC" VARCHAR2(255 CHAR), 
	"PENA_SUG_FISC1" VARCHAR2(255 CHAR), 
	"PENA_SUG_FISC1I" VARCHAR2(255 CHAR), 
	"DT_PAG_MULTA" TIMESTAMP (6), 
	"MOEDAP" VARCHAR2(30 CHAR), 
	"OBSP" VARCHAR2(4000 CHAR), 
	"VL_MULTA" NUMBER, 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MOL_PROCESSO_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MOL_PROCESSO" 
    after update or delete on mol_processo  
    for each row  
declare  
    t varchar2(128) := 'MOL_PROCESSO';  
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
begin  
if updating then  
    if(:old.id is null and :new.id is not null) or  
        (:old.id is not null and :new.id is null) or  
        :old.id != :new.id then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);  
    end if;  
  
    if(:old.tipo_processo is null and :new.tipo_processo is not null) or  
        (:old.tipo_processo is not null and :new.tipo_processo is null) or  
        :old.tipo_processo != :new.tipo_processo then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'TIPO_PROCESSO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.tipo_processo, :new.tipo_processo);  
    end if;  
  
    if(:old.numero_processo is null and :new.numero_processo is not null) or  
        (:old.numero_processo is not null and :new.numero_processo is null) or  
        :old.numero_processo != :new.numero_processo then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'NUMERO_PROCESSO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.numero_processo, :new.numero_processo);  
     end if;  
  
    if(:old.dt_instaura is null and :new.dt_instaura is not null) or  
        (:old.dt_instaura is not null and :new.dt_instaura is null) or  
        :old.dt_instaura != :new.dt_instaura then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_INSTAURA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_instaura, :new.dt_instaura);  
    end if;  
 
   
    if(:old.dt_pag_multa is null and :new.dt_pag_multa is not null) or  
        (:old.dt_pag_multa is not null and :new.dt_pag_multa is null) or  
        :old.dt_pag_multa != :new.dt_pag_multa then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_PAG_MULTA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_pag_multa, :new.dt_pag_multa);  
    end if;  
 
    if(:old.dt_ult_mov is null and :new.dt_ult_mov is not null) or  
        (:old.dt_ult_mov is not null and :new.dt_ult_mov is null) or  
        :old.dt_ult_mov != :new.dt_ult_mov then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ULT_MOV', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_ult_mov, :new.dt_ult_mov);  
    end if;  
 
    if(:old.status_processo is null and :new.status_processo is not null) or  
        (:old.status_processo is not null and :new.status_processo is null) or  
        :old.status_processo != :new.status_processo then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'STATUS_PROCESSO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.status_processo, :new.status_processo);  
    end if;  
  
    if(:old.tec_analista is null and :new.tec_analista is not null) or  
        (:old.tec_analista is not null and :new.tec_analista is null) or  
        :old.tec_analista != :new.tec_analista then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'TEC_ANALISTA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.tec_analista, :new.tec_analista);  
    end if;  
  
    if(:old.razao_soc_nac is null and :new.razao_soc_nac is not null) or  
        (:old.razao_soc_nac is not null and :new.razao_soc_nac is null) or  
        :old.razao_soc_nac != :new.razao_soc_nac then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'RAZAO_SOC_NAC', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.razao_soc_nac, :new.razao_soc_nac);  
    end if;  
  
    if(:old.empresa_estrag is null and :new.empresa_estrag is not null) or  
        (:old.empresa_estrag is not null and :new.empresa_estrag is null) or  
        :old.empresa_estrag != :new.empresa_estrag then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'EMPRESA_ESTRAG', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.empresa_estrag, :new.empresa_estrag);  
    end if;  
 
    if(:old.cnpj is null and :new.cnpj is not null) or  
        (:old.cnpj is not null and :new.cnpj is null) or  
        :old.cnpj != :new.cnpj then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'CNPJ', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cnpj, :new.cnpj);  
    end if;  
  
    if(:old.razao_soc_est is null and :new.razao_soc_est is not null) or  
        (:old.razao_soc_est is not null and :new.razao_soc_est is null) or  
        :old.razao_soc_est != :new.razao_soc_est then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'RAZAO_SOC_EST', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.razao_soc_est, :new.razao_soc_est);  
    end if;  
  
    if(:old.modal_contr is null and :new.modal_contr is not null) or  
        (:old.modal_contr is not null and :new.modal_contr is null) or  
        :old.modal_contr != :new.modal_contr then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'MODAL_CONTR', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.modal_contr, :new.modal_contr);  
    end if;  
  
    if(:old.num_pregao is null and :new.num_pregao is not null) or  
        (:old.num_pregao is not null and :new.num_pregao is null) or  
        :old.num_pregao != :new.num_pregao then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'NUM_PREGAO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_pregao, :new.num_pregao);  
    end if;  
    
    if(:old.arp is null and :new.arp is not null) or  
        (:old.arp is not null and :new.arp is null) or  
        :old.arp != :new.arp then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'ARP', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.arp, :new.arp);  
    end if;  
 
    if(:old.num_arp is null and :new.num_arp is not null) or  
        (:old.num_arp is not null and :new.num_arp is null) or  
        :old.num_arp != :new.num_arp then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'NUM_ARP', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_arp, :new.num_arp);  
    end if;  
 
 
    if(:old.obj_contr is null and :new.obj_contr is not null) or  
        (:old.obj_contr is not null and :new.obj_contr is null) or  
        :old.obj_contr != :new.obj_contr then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'OBJ_CONTR', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obj_contr, :new.obj_contr);  
    end if;  
  
    if(:old.infracao is null and :new.infracao is not null) or  
        (:old.infracao is not null and :new.infracao is null) or  
        :old.infracao != :new.infracao then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'INFRACAO', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.infracao, :new.infracao);  
    end if;  
	  
	if(:old.pena_sug_fisc is null and :new.pena_sug_fisc is not null) or  
        (:old.pena_sug_fisc is not null and :new.pena_sug_fisc is null) or  
        :old.pena_sug_fisc != :new.pena_sug_fisc then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENA_SUG_FISC', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.pena_sug_fisc, :new.pena_sug_fisc);  
    end if;  
 
	  
	if(:old.pena_sug_fisc1 is null and :new.pena_sug_fisc1 is not null) or  
        (:old.pena_sug_fisc1 is not null and :new.pena_sug_fisc1 is null) or  
        :old.pena_sug_fisc1 != :new.pena_sug_fisc1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENA_SUG_FISC1', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.pena_sug_fisc1, :new.pena_sug_fisc1);  
    end if;  
 
	  
	if(:old.pena_sug_fisc1I is null and :new.pena_sug_fisc1I is not null) or  
        (:old.pena_sug_fisc1I is not null and :new.pena_sug_fisc1I is null) or  
        :old.pena_sug_fisc1I != :new.pena_sug_fisc1I then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENA_SUG_FISC1I', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.pena_sug_fisc1I, :new.pena_sug_fisc1I);  
    end if;  
 
	if(:old.moedap is null and :new.moedap is not null) or  
        (:old.moedap is not null and :new.moedap is null) or  
        :old.moedap != :new.moedap then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'MOEDAP', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.moedap, :new.moedap);  
    end if;  
 
    if(:old.vl_multa is null and :new.vl_multa is not null) or  
        (:old.vl_multa is not null and :new.vl_multa is null) or  
        :old.vl_multa != :new.vl_multa then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'VL_MULTA', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_multa, :new.vl_multa);  
    end if; 
 
	if(:old.obsp is null and :new.obsp is not null) or  
        (:old.obsp is not null and :new.obsp is null) or  
        :old.obsp != :new.obsp then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'OBSP', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obsp, :new.obsp);  
    end if;  
		  
end if;  
  
if deleting then  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'TIPO_PROCESSO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.tipo_processo, :new.tipo_processo);  
      
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'NUMERO_PROCESSO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.numero_processo, :new.numero_processo);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_PAG_MULTA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_pag_multa, :new.dt_pag_multa);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_INSTAURA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_instaura, :new.dt_instaura);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_ULT_MOV', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_ult_mov, :new.dt_ult_mov);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'STATUS_PROCESSO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.status_processo, :new.status_processo);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'TEC_ANALISTA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.tec_analista, :new.tec_analista);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'RAZAO_SOC_NAC', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.razao_soc_nac, :new.razao_soc_nac);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'CNPJ', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.cnpj, :new.cnpj);  
   
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'EMPRESA_ESTRAG', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.empresa_estrag, :new.empresa_estrag);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'RAZAO_SOC_EST', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.razao_soc_est, :new.razao_soc_est);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'MODAL_CONTR', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.modal_contr, :new.modal_contr);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'NUM_PREGAO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_pregao, :new.num_pregao);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'ARP', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.arp, :new.arp);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'NUM_ARP', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_arp, :new.num_arp);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'OBJ_CONTR', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obj_contr, :new.obj_contr);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'INFRACAO', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.infracao, :new.infracao);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENA_SUG_FISC', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.pena_sug_fisc, :new.pena_sug_fisc);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENA_SUG_FISC1', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.pena_sug_fisc1, :new.pena_sug_fisc1);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENA_SUG_FISC1I', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.pena_sug_fisc1I, :new.pena_sug_fisc1I);  
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'MOEDAP', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.moedap, :new.moedap);  
 
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'VL_MULTA', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_multa, :new.vl_multa); 
 
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'OBSP', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obsp, :new.obsp);  
 
  
end if;  
end aud_mol_processo;  

/
ALTER TRIGGER "ORIGINAL"."AUD_MOL_PROCESSO" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MOL_PROCESSO_BIU" 
    before insert or update  
    on mol_processo 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mol_processo_biu; 

/
ALTER TRIGGER "ORIGINAL"."MOL_PROCESSO_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MOL_PROCESSO_ID_PK" ON "ORIGINAL"."MOL_PROCESSO" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MOL_REG_SICAF" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MOL_REG_SICAF_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_PROCESSO" NUMBER, 
	"REG_SICAF" VARCHAR2(255 CHAR), 
	"DT_REG_SICAF" TIMESTAMP (6), 
	"PENAL_REG_SICAF" VARCHAR2(255 CHAR), 
	"PENAL_REG_SICAF1" VARCHAR2(255 CHAR), 
	"PENAL_REG_SICAF1I" VARCHAR2(255 CHAR), 
	"OBS6" VARCHAR2(4000 CHAR), 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MOL_REG_SICAF_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MOL_REG_SICAF" ADD CONSTRAINT "MOL_REG_SICAF_FK_COD_PROCESSO" FOREIGN KEY ("COD_PROCESSO")
	  REFERENCES "ORIGINAL"."MOL_PROCESSO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MOL_REG_SICAF" 
    after update or delete on mol_reg_sicaf  
    for each row  
declare  
    t varchar2(128) := 'MOL_REG_SICAF';  
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
begin  
if updating then  
    if(:old.id is null and :new.id is not null) or  
        (:old.id is not null and :new.id is null) or  
        :old.id != :new.id then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);  
    end if;  
  
    if(:old.cod_processo is null and :new.cod_processo is not null) or  
        (:old.cod_processo is not null and :new.cod_processo is null) or  
        :old.cod_processo != :new.cod_processo then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
     end if;  
  
    if(:old.reg_sicaf is null and :new.reg_sicaf is not null) or  
        (:old.reg_sicaf is not null and :new.reg_sicaf is null) or  
        :old.reg_sicaf != :new.reg_sicaf then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'REG_SICAF', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.reg_sicaf, :new.reg_sicaf);  
     end if;  
  
    if(:old.dt_reg_sicaf is null and :new.dt_reg_sicaf is not null) or  
        (:old.dt_reg_sicaf is not null and :new.dt_reg_sicaf is null) or  
        :old.dt_reg_sicaf != :new.dt_reg_sicaf then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_REG_SICAF', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_reg_sicaf, :new.dt_reg_sicaf);  
    end if;  
  
    if(:old.penal_reg_sicaf is null and :new.penal_reg_sicaf is not null) or  
        (:old.penal_reg_sicaf is not null and :new.penal_reg_sicaf is null) or  
        :old.penal_reg_sicaf != :new.penal_reg_sicaf then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_REG_SICAF', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_reg_sicaf, :new.penal_reg_sicaf);  
     end if;  
      
    if(:old.penal_reg_sicaf1 is null and :new.penal_reg_sicaf1 is not null) or  
        (:old.penal_reg_sicaf1 is not null and :new.penal_reg_sicaf1 is null) or  
        :old.penal_reg_sicaf1 != :new.penal_reg_sicaf1 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_REG_SICAF1', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_reg_sicaf1, :new.penal_reg_sicaf1);  
     end if;  
      
     /* Alteração do dia 11 de Janeiro de 2024 - Herbert*/ 
    if(:old.penal_reg_sicaf1I is null and :new.penal_reg_sicaf1I is not null) or  
        (:old.penal_reg_sicaf1I is not null and :new.penal_reg_sicaf1I is null) or  
        :old.penal_reg_sicaf1I != :new.penal_reg_sicaf1I then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PENAL_REG_SICAF1I', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.penal_reg_sicaf1I, :new.penal_reg_sicaf1I);  
     end if;  
               
    if(:old.obs6 is null and :new.obs6 is not null) or  
        (:old.obs6 is not null and :new.obs6 is null) or  
        :old.obs6 != :new.obs6 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'OBS6', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obs6, :new.obs6);  
     end if;  
 
end if;  
  
if deleting then  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'COD_PROCESSO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_processo, :new.cod_processo);  
					  
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'REG_SICAF', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.reg_sicaf, :new.reg_sicaf);		  
				  
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_REG_SICAF', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_reg_sicaf, :new.dt_reg_sicaf);  
 
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENAL_REG_SICAF', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.penal_reg_sicaf, :new.penal_reg_sicaf);	  
               
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENAL_REG_SICAF1', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.penal_reg_sicaf1, :new.penal_reg_sicaf1);	  
 
      /* Alteração do dia 11 de Janeiro de 2024 - Herbert*/ 
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PENAL_REG_SICAF1I', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.penal_reg_sicaf1I, :new.penal_reg_sicaf1I);	  
                           
	insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'OBS6', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obs6, :new.obs6);	 
 
end if;  
  
end aud_mol_reg_sicaf;  

/
ALTER TRIGGER "ORIGINAL"."AUD_MOL_REG_SICAF" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MOL_REG_SICAF_BIU" 
    before insert or update  
    on mol_reg_sicaf 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mol_tipo_penalidade_biu; 

/
ALTER TRIGGER "ORIGINAL"."MOL_REG_SICAF_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MOL_REG_SICAF_ID_PK" ON "ORIGINAL"."MOL_REG_SICAF" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE TABLE "ORIGINAL"."MOL_TERMO_ADITIVO" 
   (	"ID" NUMBER DEFAULT ON NULL "ORIGINAL"."MOL_TERMO_ADITIVO_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"COD_CONTRATO" NUMBER, 
	"NUM_PROC_EXEC2" VARCHAR2(20 CHAR), 
	"NUM_TA" VARCHAR2(4 CHAR), 
	"DT_ASS_TA" TIMESTAMP (6), 
	"DT_FIN_TA" TIMESTAMP (6), 
	"NUM_NOTA_EMP_TA" VARCHAR2(255 CHAR), 
	"OBJ_TA" VARCHAR2(255 CHAR), 
	"PERC_ADIT" VARCHAR2(4 CHAR), 
	"MOEDA2" VARCHAR2(30 CHAR), 
	"VL_TA" NUMBER, 
	"CREATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"UPDATED" TIMESTAMP (6) NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "MOL_TERMO_ADITIVO_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;

ALTER TABLE "ORIGINAL"."MOL_TERMO_ADITIVO" ADD CONSTRAINT "MOL_TERMO_ADITIVO_FK_COD_CONTRATO" FOREIGN KEY ("COD_CONTRATO")
	  REFERENCES "ORIGINAL"."MOL_CONTRATO" ("ID") ON DELETE CASCADE ENABLE;

CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."AUD_MOL_TERMO_ADITIVO" 
    after update or delete on mol_termo_aditivo  
    for each row  
declare  
    t varchar2(128) := 'MOL_TERMO_ADITIVO';  
    u varchar2(128) := nvl(sys_context('APEX$SESSION','APP_USER'),user);  
begin  
if updating then  
    if(:old.id is null and :new.id is not null) or  
        (:old.id is not null and :new.id is null) or  
        :old.id != :new.id then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'ID', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.id, :new.id);  
    end if;  
  
    if(:old.cod_contrato is null and :new.cod_contrato is not null) or  
        (:old.cod_contrato is not null and :new.cod_contrato is null) or  
        :old.cod_contrato != :new.cod_contrato then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
        ) values (  
          mol_history_seq.nextval, t, 'COD_CONTRATO', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.cod_contrato, :new.cod_contrato);  
     end if;  
	   
    if(:old.num_proc_exec2 is null and :new.num_proc_exec2 is not null) or  
        (:old.num_proc_exec2 is not null and :new.num_proc_exec2 is null) or  
        :old.num_proc_exec2 != :new.num_proc_exec2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
 
        ) values (  
          mol_history_seq.nextval, t, 'NUM_PROC_EXEC2', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_proc_exec2, :new.num_proc_exec2);  
     end if;  
  
    if(:old.num_ta is null and :new.num_ta is not null) or  
        (:old.num_ta is not null and :new.num_ta is null) or  
        :old.num_ta != :new.num_ta then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'NUM_TA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_ta, :new.num_ta);  
     end if;  
  
    if(:old.dt_ass_ta is null and :new.dt_ass_ta is not null) or  
        (:old.dt_ass_ta is not null and :new.dt_ass_ta is null) or  
        :old.dt_ass_ta != :new.dt_ass_ta then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_ASS_TA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_ass_ta, :new.dt_ass_ta);  
    end if;  
  
    if(:old.dt_fin_ta is null and :new.dt_fin_ta is not null) or  
        (:old.dt_fin_ta is not null and :new.dt_fin_ta is null) or  
        :old.dt_fin_ta != :new.dt_fin_ta then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
        ) values (  
          mol_history_seq.nextval, t, 'DT_FIN_TA', :old.id, null, 'U', sysdate, u, 'TIMESTAMP', :old.dt_fin_ta, :new.dt_fin_ta);  
    end if;  
  
    if(:old.num_nota_emp_ta is null and :new.num_nota_emp_ta is not null) or  
        (:old.num_nota_emp_ta is not null and :new.num_nota_emp_ta is null) or  
        :old.num_nota_emp_ta != :new.num_nota_emp_ta then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'NUM_NOTA_EMP_TA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.num_nota_emp_ta, :new.num_nota_emp_ta);  
     end if;  
  
    if(:old.obj_ta is null and :new.obj_ta is not null) or  
        (:old.obj_ta is not null and :new.obj_ta is null) or  
        :old.obj_ta != :new.obj_ta then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'OBJ_TA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.obj_ta, :new.obj_ta);  
     end if;  
  
    if(:old.moeda2 is null and :new.moeda2 is not null) or  
        (:old.moeda2 is not null and :new.moeda2 is null) or  
        :old.moeda2 != :new.moeda2 then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'MOEDA2', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.moeda2, :new.moeda2);  
     end if;  
 
/* Alteração 11/01/2024 HCV */ 
    if(:old.perc_adit is null and :new.perc_adit is not null) or  
        (:old.perc_adit is not null and :new.perc_adit is null) or  
        :old.perc_adit != :new.perc_adit then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'PERC_ADIT', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.perc_adit, :new.perc_adit);  
     end if;  
 
    if(:old.vl_ta is null and :new.vl_ta is not null) or  
        (:old.vl_ta is not null and :new.vl_ta is null) or  
        :old.vl_ta != :new.vl_ta then  
        insert into mol_history (  
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
        ) values (  
          mol_history_seq.nextval, t, 'VL_TA', :old.id, null, 'U', sysdate, u, 'NUMBER', :old.vl_ta, :new.vl_ta);  
     end if;  
  
end if;  
  
if deleting then  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'ID', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.id, :new.id);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'COD_CONTRATO', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.cod_contrato, :new.cod_contrato);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'NUM_PROC_EXEC2', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_proc_exec2, :new.num_proc_exec2);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'NUM_TA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_ta, :new.num_ta);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_ASS_TA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_ass_ta, :new.dt_ass_ta);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_ts, new_ts  
    ) values (  
        mol_history_seq.nextval, t, 'DT_FIN_TA', :old.id, null, 'D', sysdate, u, 'TIMESTAMP', :old.dt_fin_ta, :new.dt_fin_ta);  
  
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'NUM_NOTA_EMP_TA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.num_nota_emp_ta, :new.num_nota_emp_ta);  
   
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'OBJ_TA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.obj_ta, :new.obj_ta);  
      
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'MOEDA2', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.moeda2, :new.moeda2);  
      
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc  
    ) values (  
        mol_history_seq.nextval, t, 'PERC_ADIT', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.perc_adit, :new.perc_adit);  
	     	      
    insert into mol_history (  
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_number, new_number  
    ) values (  
        mol_history_seq.nextval, t, 'VL_TA', :old.id, null, 'D', sysdate, u, 'NUMBER', :old.vl_ta, :new.vl_ta);  
		  
end if;  
end aud_mol_termo_aditivo; 

/
ALTER TRIGGER "ORIGINAL"."AUD_MOL_TERMO_ADITIVO" ENABLE;
  CREATE OR REPLACE EDITIONABLE TRIGGER "ORIGINAL"."MOL_TERMO_ADITIVO_BIU" 
    before insert or update  
    on mol_termo_aditivo 
    for each row 
begin 
    if inserting then 
        :new.created := systimestamp; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := systimestamp; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end mol_termo_aditivo_biu; 

/
ALTER TRIGGER "ORIGINAL"."MOL_TERMO_ADITIVO_BIU" ENABLE;

CREATE UNIQUE INDEX "ORIGINAL"."MOL_TERMO_ADITIVO_ID_PK" ON "ORIGINAL"."MOL_TERMO_ADITIVO" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_3775593283083513" ;
;

CREATE SEQUENCE ORIGINAL.MEC_ANALI_RESP_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MEC_AQUISICAO_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MEC_CONTRATO_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MEC_HISTORY_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MEC_INSUMO_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MEC_NOTA_EMPENHO_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MEC_PROCEXEC_INSUMO_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MEC_PROCEXEC_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MEC_TAREFA_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MEC_TERMO_ADITIVO_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MEC_URGENCIA_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MOL_ANA_GAB_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MOL_ANALISE_REC_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MOL_APLIC_PENAL_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MOL_CONTRATO_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MOL_HISTORY_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MOL_INSC_DIV_ATIVA_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MOL_NOTA_EMP_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MOL_PED_REC_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MOL_PENAL_MULTA_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MOL_PROCESSO_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MOL_REG_SICAF_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;

CREATE SEQUENCE ORIGINAL.MOL_TERMO_ADITIVO_SEQ INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 NOCYCLE CACHE 20 NOORDER ;