--ComprasLOG - Vs 2.2
--drop objects
 drop table mec_aquisicao cascade constraints;
 drop sequence mec_aquisicao_seq;
 drop table mec_procexec cascade constraints;
 drop sequence mec_procexec_seq;
 drop table mec_procexec_insumo cascade constraints;
 drop sequence mec_procexec_insumo_seq;
 drop table mec_insumo cascade constraints;
 drop sequence mec_insumo_seq;
 drop table mec_nota_empenho cascade constraints;
 drop sequence mec_nota_empenho_seq;
 drop table mec_contrato cascade constraints;
 drop sequence mec_contrato_seq;
 drop table mec_anali_resp cascade constraints;
 drop sequence mec_anali_resp_seq;
 drop table mec_tarefa cascade constraints; 
 drop sequence mec_tarefa_seq;
 drop table mec_urgencia cascade constraints;
 drop sequence mec_urgencia_seq;
 drop table mec_termo_aditivo cascade constraints;
 drop sequence mec_termo_aditivo_seq;
 drop table mec_history cascade constraints;
 drop sequence mec_history_seq;



-- create tables --
create sequence mec_aquisicao_seq;

create table mec_aquisicao (
    id                             number default on null mec_aquisicao_seq.NEXTVAL 
                                   constraint mec_aquisicao_id_pk primary key,
    
	num_processo_sei            	varchar2(20 char),   
	dt_entrada_dlog				 	timestamp,
    dt_instaura_proc                timestamp,
    area_demandante                 varchar2(255 char),
    num_portaria                    varchar2(255 char),
    num_dfd                         varchar2(255 char),
    pca                             varchar2(10 char),
    num_contrat_pca                 varchar2(255 char),
    fund_legal                      varchar2(255 char),
    modalidade                      varchar2(255 char),
    pregao_eletron                  varchar2(10 char),
    mapa_risco                      varchar2(255 char),
    etp                             varchar2(255 char),
    vl_estimado             		number,
    tr_proj_basico                  varchar2(255 char),
    tipo_contrato                   varchar2(255 char),
	dt_conclusao_licit				timestamp,
	status_licit					varchar2(30 char),
    obs                             varchar2(4000 char),
    created                        	timestamp not null,
    created_by                     	varchar2(255 char) not null,
    updated                        	timestamp not null,
    updated_by                     	varchar2(255 char) not null
 )
;

create sequence mec_procexec_seq;

create table mec_procexec (
    id                             number default on null mec_procexec_seq.NEXTVAL 
                                   constraint mec_procexec_seq_id_pk primary key,
    cod_aquisicao                  number constraint mec_porcexec_seq_fk_mec_aquisicao
                                   references mec_aquisicao on delete cascade,	
	seq                           	varchar2(3 char),
    num_procexec                  	varchar2(20 char),
    num_arp                         varchar2(255 char),
    situacao_exec                  varchar2(255 char),
    sigla                          varchar2(255 char),
	dt_vig_inic_arp     			timestamp,
    dt_vig_final_arp     			timestamp,
    dt_ent_dimec                    timestamp,
    etapa_proc_exec                 varchar2(255 char),
    dt_eta_exec                     timestamp,
    obs1                            varchar2(4000 char),
    created                        	timestamp not null,
    created_by                     	varchar2(255 char) not null,
    updated                        	timestamp not null,
    updated_by                     	varchar2(255 char) not null
 
)
;

create sequence mec_insumo_seq;

create table mec_insumo (
    id                             number default on null mec_insumo_seq.NEXTVAL 
                                   constraint mec_insumo_id_pk primary key,
    cod_aquisicao                  number constraint mec_insumo_seq_fk_mec_aquisicao
                                   references mec_aquisicao on delete cascade,	
    cod_procexec                   number constraint mec_insumo_fk_mec_procexec
                                   references mec_procexec on delete cascade,	
    item                            varchar2(4 char),
	num_catmat                  	varchar2(20 char),
	desc_insumo					   	varchar2(4000 char),
    obs_secretaria                  varchar2(4000 char),
    unid_fornec                     varchar2(255 char),
    cota_reserva                    varchar2(20 char),
	qtde_total    					number,
    vl_unit    						number,
    vl_total   						number,
    risco                           varchar2(255 char),
    tempo                           varchar2(255 char),
    obs                             varchar2(4000 char),
    created                        	timestamp not null,
    created_by                     	varchar2(255 char) not null,
    updated                        	timestamp not null,
    updated_by                     	varchar2(255 char) not null
 
)
;

create sequence mec_procexec_insumo_seq;

create table mec_procexec_insumo (
    id                             number default on null mec_procexec_insumo_seq.NEXTVAL 
                                   constraint mec_procexec_insumo_seq_id_pk primary key,
    cod_procexec                   number constraint mec_procexec_insumo_fk_mec_procexec
                                   references mec_procexec on delete cascade,
    cod_insumo                     number constraint mec_procexec_insumo_fk_mec_insumo
                                   references mec_insumo on delete cascade,	
	qtde                          	number,
    num_exec                   	    varchar2(20 char),
    qtde_sol                       	number,
    vl_unit                         number,
    vl_unit_est                     number,
	moeda                        	varchar2(255 char),
    moeda_est                       varchar2(255 char),
    vl_total             			number,
    vl_total_est           			number,
    cotacao                         number,
    created                        	timestamp not null,
    created_by                     	varchar2(255 char) not null,
    updated                        	timestamp not null,
    updated_by                     	varchar2(255 char) not null
 
)
;

create sequence mec_nota_empenho_seq;

create table mec_nota_empenho (
    id                             number default on null mec_nota_empenho_seq.NEXTVAL 
                                   constraint mec_nota_empenho_id_pk primary key,
    cod_procexec                   number constraint mec_nota_empenho_fk_mec_procexec
                                   references mec_procexec on delete cascade,	
	num_nota_empenho               	varchar2(20 char),
	dt_nota_empenho					timestamp,
    created                        	timestamp not null,
    created_by                     	varchar2(255 char) not null,
    updated                        	timestamp not null,
    updated_by                     	varchar2(255 char) not null
 
)
;

create sequence mec_contrato_seq;

create table mec_contrato (
    id                             number default on null mec_contrato_seq.NEXTVAL 
                                   constraint mec_contrato_id_pk primary key,
    cod_procexec                   number constraint mec_contrato_fk_mec_procexec
                                   references mec_procexec on delete cascade,	
	num_contrato                  	varchar2(20 char),
    razao_soc_est					varchar2(255 char),
    cnpj							varchar2(18 char),
    razao_soc_nac					varchar2(255 char),
    dt_vig_inic_contr     			timestamp,
    dt_vig_final_contr     			timestamp,
	tipo_contrato				   	varchar2(50 char),
    vl_contrato						number,
    vl_contrato_est					number,
    created                        	timestamp not null,
    created_by                     	varchar2(255 char) not null,
    updated                        	timestamp not null,


    updated_by                     	varchar2(255 char) not null
 
)
;

--CRIAÇÃO DE TABELA TERMO ADITIVO

create sequence mec_termo_aditivo_seq;

create table mec_termo_aditivo (
    id                             number default on null mec_termo_aditivo_seq.NEXTVAL 
                                   constraint mec_termo_aditivo_id_pk primary key,
    cod_procexec                   number constraint mec_termo_aditivo_fk_mec_procexec
                                   references mec_procexec on delete cascade,
    num_contrato_ta              	    varchar2(20 char),	
	num_ta                    	    varchar2(20 char),
    dt_vig_inic_ta     			    timestamp,
    dt_vig_final_ta                 timestamp,
    vl_ta						    number,
    obsta                           varchar2(4000 char),
    created                        	timestamp not null,
    created_by                     	varchar2(255 char) not null,
    updated                        	timestamp not null,
    updated_by                     	varchar2(255 char) not null
 
)
;


create sequence mec_anali_resp_seq;

create table mec_anali_resp (
    id                             number default on null mec_anali_resp_seq.NEXTVAL 
                                   constraint mec_anli_resp_id_pk primary key,
    cod_aquisicao                  number constraint mec_anali_resp_fk_cod_aquisicao
                                   references mec_aquisicao on delete cascade,
	nome    						varchar2(50 char),
    analista    					varchar2(50 char),
    area_dest                       varchar2(50 char),
    area_destino                    varchar2(50 char),
    etapa_proc_aqui                 varchar2(255 char),
    pendencia                       varchar2(255 char),
    tipo_pendencia                  varchar2(255 char),
    dias						    number,
	dt_analista						timestamp,
    OBS_STATUS_PROC                 varchar2(4000 char),
	created                        	timestamp not null,
    created_by                     	varchar2(255 char) not null,
    updated                        	timestamp not null,
    updated_by                     	varchar2(255 char) not null
 
)
;

create sequence mec_tarefa_seq;

create table mec_tarefa (
    id                             number default on null mec_tarefa_seq.NEXTVAL 
                                   constraint mec_tarefa_id_pk primary key,
    cod_aquisicao                  number constraint mec_tarefa_fk_cod_aquisicao
                                   references mec_aquisicao on delete cascade,
	nome_analista 					varchar2(255 char),                   
    desc_tarefa 					varchar2(255 char),
    dt_entrada                      timestamp,
    dt_saida                        timestamp,
    destino                         varchar2(255 char),
  	created                        	timestamp not null,
    created_by                     	varchar2(255 char) not null,
    updated                        	timestamp not null,
    updated_by                     	varchar2(255 char) not null
 
)
;

create sequence mec_urgencia_seq;

create table mec_urgencia (
    id                             number default on null mec_urgencia_seq.NEXTVAL 
                                   constraint mec_urgencia_id_pk primary key,
    cod_aquisicao                  number constraint mec_urgencia_fk_cod_aquisicao
                                   references mec_aquisicao on delete cascade,
	desc_urgenc						varchar2(50 char),
    dt_urgencia                     timestamp,
  	created                        	timestamp not null,
    created_by                     	varchar2(255 char) not null,
    updated                        	timestamp not null,
    updated_by                     	varchar2(255 char) not null
 
)
;


create sequence mec_history_seq;

create table mec_history (
    id                             number default on null mec_history_seq.NEXTVAL 
                                   constraint mec_history_id_pk primary key,
    table_name                     varchar2(128 char),
    column_name                    varchar2(128 char),
    action                         varchar2(1 char),
    action_date                    timestamp,
    action_by                      varchar2(255 char),
    data_type                      varchar2(255 char),
    pk1                            number,
    tab_row_version                number,
    old_vc                         varchar2(4000 char),
    new_vc                         varchar2(4000 char),
    old_number                     number,
    new_number                     number,
    old_date                       timestamp,
    new_date                       timestamp,
    old_ts                         timestamp,
    new_ts                         timestamp,
    old_clob                       clob,
    new_clob                       clob,
    old_blob                       blob,
    new_blob                       blob,
    created                        timestamp not null,
    created_by                     varchar2(255 char) not null,
    updated                        timestamp not null,
    updated_by                     varchar2(255 char) not null
)
;

-- triggers
create or replace TRIGGER aud_mec_aquisicao  
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

create or replace TRIGGER aud_mec_procexec  
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

create or replace TRIGGER aud_mec_insumo  
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

create or replace TRIGGER aud_mec_procexec_insumo  
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

create or replace TRIGGER aud_mec_nota_empenho  
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

create or replace TRIGGER aud_mec_contrato  
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
--CRIAÇÃO DE TRIGERS DE TERMO ADITIVO

create or replace TRIGGER aud_mec_termo_aditivo 
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

---- FIM DE TERMO ADITIVO


create or replace TRIGGER aud_mec_anali_resp  
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

    if(:old.tipo_pendencia is null and :new.tipo_pendencia is not null) or   
        (:old.tipo_pendencia is not null and :new.tipo_pendencia is null) or   
        :old.tipo_pendencia != :new.tipo_pendencia then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'TIPO_PENDENCIA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.tipo_pendencia, :new.tipo_pendencia);   
     end if;   
 
    if(:old.pendencia is null and :new.pendencia is not null) or   
        (:old.pendencia is not null and :new.pendencia is null) or   
        :old.pendencia != :new.pendencia then   
        insert into mec_history (   
            id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
        ) values (   
          mec_history_seq.nextval, t, 'PENDENCIA', :old.id, null, 'U', sysdate, u, 'VARCHAR2', :old.pendencia, :new.pendencia);   
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
     
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'TIPO_PENDENCIA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.tipo_pendencia, :new.tipo_pendencia); 
     
    insert into mec_history (   
        id, table_name, column_name, pk1, tab_row_version, action, action_date, action_by, data_type, old_vc, new_vc   
    ) values (   
        mec_history_seq.nextval, t, 'PENDENCIA', :old.id, null, 'D', sysdate, u, 'VARCHAR2', :old.pendencia, :new.pendencia);  

end if;  
end aud_mec_anali_resp;
/

create or replace TRIGGER aud_mec_tarefa  
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

create or replace TRIGGER aud_mec_urgencia  
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

create or replace trigger mec_aquisicao_biu
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

create or replace trigger mec_procexec_biu
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

create or replace trigger mec_procexec_insumo_biu
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

create or replace trigger mec_insumo_biu
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

create or replace trigger mec_nota_empenho_biu
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

create or replace trigger mec_contrato_biu
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

create or replace trigger mec_termo_aditivo_biu
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

create or replace trigger mec_anali_resp_biu
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

create or replace trigger mec_tarefa_biu
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

create or replace trigger mec_urgencia_biu
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

create or replace trigger mec_history_biu 
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