--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dependente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dependente (
    id bigint NOT NULL,
    cpf character varying(255),
    data_adesao date,
    data_cancelamento timestamp without time zone,
    data_nascimento date,
    estado_civil character varying(255),
    falecido boolean,
    sexo character varying(255),
    nome character varying(255),
    conjuge character varying(255),
    obs character varying(255),
    orgao_exp character varying(255),
    rg character varying(255),
    tel_principal character varying(255),
    status boolean,
    id_titular bigint
);


ALTER TABLE public.dependente OWNER TO postgres;

--
-- Name: dependente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dependente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dependente_id_seq OWNER TO postgres;

--
-- Name: dependente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dependente_id_seq OWNED BY public.dependente.id;


--
-- Name: funcionalidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.funcionalidade (
    id bigint NOT NULL,
    nome character varying(255)
);


ALTER TABLE public.funcionalidade OWNER TO postgres;

--
-- Name: funcionalidade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.funcionalidade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.funcionalidade_id_seq OWNER TO postgres;

--
-- Name: funcionalidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.funcionalidade_id_seq OWNED BY public.funcionalidade.id;


--
-- Name: item_recibo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_recibo (
    id bigint NOT NULL,
    data_nascimento date,
    idade_maxima integer,
    idade_minima integer,
    valor_preco_plano numeric(19,2),
    id_dependente bigint,
    id_preco bigint,
    id_recibo bigint,
    id_titular bigint
);


ALTER TABLE public.item_recibo OWNER TO postgres;

--
-- Name: item_recibo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_recibo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_recibo_id_seq OWNER TO postgres;

--
-- Name: item_recibo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_recibo_id_seq OWNED BY public.item_recibo.id;


--
-- Name: log_evento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log_evento (
    id bigint NOT NULL,
    data_hora_evento timestamp without time zone,
    funcionalidade character varying(255),
    obs character varying(255),
    id_dependente bigint,
    id_perfil bigint,
    id_plano bigint,
    id_preco_plano bigint,
    id_recibo bigint,
    id_registro_ocorrencia bigint,
    id_titular bigint,
    id_usuario bigint
);


ALTER TABLE public.log_evento OWNER TO postgres;

--
-- Name: log_evento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.log_evento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.log_evento_id_seq OWNER TO postgres;

--
-- Name: log_evento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.log_evento_id_seq OWNED BY public.log_evento.id;


--
-- Name: perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfil (
    id bigint NOT NULL,
    nome character varying(255)
);


ALTER TABLE public.perfil OWNER TO postgres;

--
-- Name: perfil_funcionalidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfil_funcionalidade (
    perfil_id bigint NOT NULL,
    funcionalidade_id bigint NOT NULL
);


ALTER TABLE public.perfil_funcionalidade OWNER TO postgres;

--
-- Name: perfil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.perfil_id_seq OWNER TO postgres;

--
-- Name: perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perfil_id_seq OWNED BY public.perfil.id;


--
-- Name: plano; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plano (
    id bigint NOT NULL,
    meses_carencia integer,
    nome character varying(255),
    status boolean
);


ALTER TABLE public.plano OWNER TO postgres;

--
-- Name: plano_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plano_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plano_id_seq OWNER TO postgres;

--
-- Name: plano_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plano_id_seq OWNED BY public.plano.id;


--
-- Name: preco_plano; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preco_plano (
    id bigint NOT NULL,
    data_fim date,
    data_inicio date,
    idade_maxima integer,
    idade_minima integer,
    preco numeric(19,2),
    status boolean,
    id_plano bigint
);


ALTER TABLE public.preco_plano OWNER TO postgres;

--
-- Name: preco_plano_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.preco_plano_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.preco_plano_id_seq OWNER TO postgres;

--
-- Name: preco_plano_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.preco_plano_id_seq OWNED BY public.preco_plano.id;


--
-- Name: recibo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recibo (
    id bigint NOT NULL,
    adicional numeric(19,2),
    ano_ref_pagamento integer,
    data_cancelamento date,
    data_lancamento timestamp without time zone,
    data_vencimento date,
    desconto numeric(19,2),
    juros numeric(19,2),
    mes_ref_pagamento integer,
    obs character varying(255),
    status boolean,
    tipo_pagamento character varying(255),
    valor_pago numeric(19,2),
    id_titular bigint
);


ALTER TABLE public.recibo OWNER TO postgres;

--
-- Name: recibo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recibo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recibo_id_seq OWNER TO postgres;

--
-- Name: recibo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recibo_id_seq OWNED BY public.recibo.id;


--
-- Name: registro_ocorrencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.registro_ocorrencia (
    id bigint NOT NULL,
    bairro character varying(255),
    cemiterio_escolhido character varying(255),
    cidade character varying(255),
    complemento character varying(255),
    dados_coroa_flores character varying(255),
    dt_ocorrencia date,
    endereco character varying(255),
    estado character varying(255),
    local_ocorrencia character varying(255),
    lote_jazigo character varying(255),
    numero character varying(255),
    numero_jazigo character varying(255),
    observacao character varying(255),
    ponto_referencia character varying(255),
    possui_jazigo boolean,
    quadra_jazigo character varying(255),
    responsavel character varying(255),
    st_ocorrencia boolean,
    tel_contato character varying(255),
    id_dependente bigint,
    id_titular bigint
);


ALTER TABLE public.registro_ocorrencia OWNER TO postgres;

--
-- Name: registro_ocorrencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registro_ocorrencia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.registro_ocorrencia_id_seq OWNER TO postgres;

--
-- Name: registro_ocorrencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registro_ocorrencia_id_seq OWNED BY public.registro_ocorrencia.id;


--
-- Name: titular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.titular (
    id bigint NOT NULL,
    carencia boolean,
    cpf character varying(255),
    data_adesao date,
    data_cancelamento timestamp without time zone,
    data_nascimento date,
    estado_civil character varying(255),
    falecido boolean,
    sexo character varying(255),
    nome character varying(255),
    conjuge character varying(255),
    obs character varying(255),
    orgao_exp character varying(255),
    rg character varying(255),
    tel_principal character varying(255),
    melhor_dia integer,
    email character varying(255),
    bairro character varying(255),
    cep character varying(255),
    complemento character varying(255),
    cidade character varying(255),
    logradouro character varying(255),
    numero character varying(255),
    uf character varying(255),
    nacionalidade character varying(255),
    naturalidade character varying(255),
    nm_contato character varying(255),
    mae character varying(255),
    pai character varying(255),
    parentesco character varying(255),
    status boolean,
    tel_contato character varying(255),
    id_plano bigint
);


ALTER TABLE public.titular OWNER TO postgres;

--
-- Name: titular_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.titular_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.titular_id_seq OWNER TO postgres;

--
-- Name: titular_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.titular_id_seq OWNED BY public.titular.id;


--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id bigint NOT NULL,
    senha character varying(255),
    status boolean DEFAULT true,
    usuario character varying(255)
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_id_seq OWNER TO postgres;

--
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


--
-- Name: usuario_perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_perfil (
    id_usuario bigint NOT NULL,
    id_perfil bigint NOT NULL
);


ALTER TABLE public.usuario_perfil OWNER TO postgres;

--
-- Name: dependente id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dependente ALTER COLUMN id SET DEFAULT nextval('public.dependente_id_seq'::regclass);


--
-- Name: funcionalidade id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcionalidade ALTER COLUMN id SET DEFAULT nextval('public.funcionalidade_id_seq'::regclass);


--
-- Name: item_recibo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_recibo ALTER COLUMN id SET DEFAULT nextval('public.item_recibo_id_seq'::regclass);


--
-- Name: log_evento id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_evento ALTER COLUMN id SET DEFAULT nextval('public.log_evento_id_seq'::regclass);


--
-- Name: perfil id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil ALTER COLUMN id SET DEFAULT nextval('public.perfil_id_seq'::regclass);


--
-- Name: plano id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plano ALTER COLUMN id SET DEFAULT nextval('public.plano_id_seq'::regclass);


--
-- Name: preco_plano id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preco_plano ALTER COLUMN id SET DEFAULT nextval('public.preco_plano_id_seq'::regclass);


--
-- Name: recibo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recibo ALTER COLUMN id SET DEFAULT nextval('public.recibo_id_seq'::regclass);


--
-- Name: registro_ocorrencia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_ocorrencia ALTER COLUMN id SET DEFAULT nextval('public.registro_ocorrencia_id_seq'::regclass);


--
-- Name: titular id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titular ALTER COLUMN id SET DEFAULT nextval('public.titular_id_seq'::regclass);


--
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- Name: dependente dependente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dependente
    ADD CONSTRAINT dependente_pkey PRIMARY KEY (id);


--
-- Name: funcionalidade funcionalidade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funcionalidade
    ADD CONSTRAINT funcionalidade_pkey PRIMARY KEY (id);


--
-- Name: item_recibo item_recibo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_recibo
    ADD CONSTRAINT item_recibo_pkey PRIMARY KEY (id);


--
-- Name: log_evento log_evento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_evento
    ADD CONSTRAINT log_evento_pkey PRIMARY KEY (id);


--
-- Name: perfil_funcionalidade perfil_funcionalidade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil_funcionalidade
    ADD CONSTRAINT perfil_funcionalidade_pkey PRIMARY KEY (perfil_id, funcionalidade_id);


--
-- Name: perfil perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (id);


--
-- Name: plano plano_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plano
    ADD CONSTRAINT plano_pkey PRIMARY KEY (id);


--
-- Name: preco_plano preco_plano_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preco_plano
    ADD CONSTRAINT preco_plano_pkey PRIMARY KEY (id);


--
-- Name: recibo recibo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recibo
    ADD CONSTRAINT recibo_pkey PRIMARY KEY (id);


--
-- Name: registro_ocorrencia registro_ocorrencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_ocorrencia
    ADD CONSTRAINT registro_ocorrencia_pkey PRIMARY KEY (id);


--
-- Name: titular titular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titular
    ADD CONSTRAINT titular_pkey PRIMARY KEY (id);


--
-- Name: usuario_perfil usuario_perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_perfil
    ADD CONSTRAINT usuario_perfil_pkey PRIMARY KEY (id_usuario, id_perfil);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- Name: usuario_perfil fk2qe6tjawyl6ojl32uhbwllldh; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_perfil
    ADD CONSTRAINT fk2qe6tjawyl6ojl32uhbwllldh FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- Name: usuario_perfil fk3cxlmf5q4y8mllkos025n9px8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_perfil
    ADD CONSTRAINT fk3cxlmf5q4y8mllkos025n9px8 FOREIGN KEY (id_perfil) REFERENCES public.perfil(id);


--
-- Name: preco_plano fk3iyqcwyghl6ix7e5137pa91lo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preco_plano
    ADD CONSTRAINT fk3iyqcwyghl6ix7e5137pa91lo FOREIGN KEY (id_plano) REFERENCES public.plano(id);


--
-- Name: item_recibo fk46k8uaf3j2thtq69avof4tdqn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_recibo
    ADD CONSTRAINT fk46k8uaf3j2thtq69avof4tdqn FOREIGN KEY (id_dependente) REFERENCES public.dependente(id);


--
-- Name: perfil_funcionalidade fk5llhnjbrv288quihtnqgvyqoj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil_funcionalidade
    ADD CONSTRAINT fk5llhnjbrv288quihtnqgvyqoj FOREIGN KEY (funcionalidade_id) REFERENCES public.funcionalidade(id);


--
-- Name: registro_ocorrencia fk60i0ra3nxggs4vmu0r0snf2bw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_ocorrencia
    ADD CONSTRAINT fk60i0ra3nxggs4vmu0r0snf2bw FOREIGN KEY (id_dependente) REFERENCES public.dependente(id);


--
-- Name: log_evento fk6xm7ovx4uxemnemxokajchg34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_evento
    ADD CONSTRAINT fk6xm7ovx4uxemnemxokajchg34 FOREIGN KEY (id_perfil) REFERENCES public.perfil(id);


--
-- Name: perfil_funcionalidade fk6ywleq9dsgshg4qfo5wt95cwk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil_funcionalidade
    ADD CONSTRAINT fk6ywleq9dsgshg4qfo5wt95cwk FOREIGN KEY (perfil_id) REFERENCES public.perfil(id);


--
-- Name: log_evento fk9k8na77mqk8bgd501oxd7xpd6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_evento
    ADD CONSTRAINT fk9k8na77mqk8bgd501oxd7xpd6 FOREIGN KEY (id_recibo) REFERENCES public.recibo(id);


--
-- Name: log_evento fka33gpac9onmbmrquqe1d0u5lo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_evento
    ADD CONSTRAINT fka33gpac9onmbmrquqe1d0u5lo FOREIGN KEY (id_registro_ocorrencia) REFERENCES public.registro_ocorrencia(id);


--
-- Name: dependente fkdftje6y5cu84nwe423bm7gcuj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dependente
    ADD CONSTRAINT fkdftje6y5cu84nwe423bm7gcuj FOREIGN KEY (id_titular) REFERENCES public.titular(id);


--
-- Name: log_evento fkeb7by9ijj69vuavxhkuxbdvn1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_evento
    ADD CONSTRAINT fkeb7by9ijj69vuavxhkuxbdvn1 FOREIGN KEY (id_plano) REFERENCES public.plano(id);


--
-- Name: registro_ocorrencia fkf5div7dscd70efvele5bbqlys; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_ocorrencia
    ADD CONSTRAINT fkf5div7dscd70efvele5bbqlys FOREIGN KEY (id_titular) REFERENCES public.titular(id);


--
-- Name: log_evento fkfci7aqtnbrj9ravy0as6qdv5x; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_evento
    ADD CONSTRAINT fkfci7aqtnbrj9ravy0as6qdv5x FOREIGN KEY (id_preco_plano) REFERENCES public.preco_plano(id);


--
-- Name: titular fkg5p49x19h0damk922ovgv6hgi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titular
    ADD CONSTRAINT fkg5p49x19h0damk922ovgv6hgi FOREIGN KEY (id_plano) REFERENCES public.plano(id);


--
-- Name: log_evento fkgf53pt1cx8brnnd754ljf08gw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_evento
    ADD CONSTRAINT fkgf53pt1cx8brnnd754ljf08gw FOREIGN KEY (id_dependente) REFERENCES public.dependente(id);


--
-- Name: log_evento fkilx6r5nn4f2hjs7vsk0s4thqj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_evento
    ADD CONSTRAINT fkilx6r5nn4f2hjs7vsk0s4thqj FOREIGN KEY (id_titular) REFERENCES public.titular(id);


--
-- Name: recibo fkn7udpuwfdqfs3aj27rlrpc3ke; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recibo
    ADD CONSTRAINT fkn7udpuwfdqfs3aj27rlrpc3ke FOREIGN KEY (id_titular) REFERENCES public.titular(id);


--
-- Name: item_recibo fkntv5hp6iv78hne4mm5wu7406g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_recibo
    ADD CONSTRAINT fkntv5hp6iv78hne4mm5wu7406g FOREIGN KEY (id_titular) REFERENCES public.titular(id);


--
-- Name: log_evento fkqcn9gdbyh5osrmwalf3egv32j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_evento
    ADD CONSTRAINT fkqcn9gdbyh5osrmwalf3egv32j FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- Name: item_recibo fktacf66mwovscl6pue0lotxoux; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_recibo
    ADD CONSTRAINT fktacf66mwovscl6pue0lotxoux FOREIGN KEY (id_preco) REFERENCES public.preco_plano(id);


--
-- Name: item_recibo fkuj6r43oblb9m2kvv7h9asrm2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_recibo
    ADD CONSTRAINT fkuj6r43oblb9m2kvv7h9asrm2 FOREIGN KEY (id_recibo) REFERENCES public.recibo(id);


--
-- PostgreSQL database dump complete
--

