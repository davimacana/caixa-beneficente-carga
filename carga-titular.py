# -*- coding: utf-8 -*-

from datetime import datetime
import csv
import psycopg2
from psycopg2 import sql

db_params = {
    'dbname': 'caixa-beneficente',
    'user': 'postgres',
    'password': 'admin',
    'host': 'localhost',
    'port': '5432'
}

def remove_duplicatas_ordenado(input_file, output_file):
    # Crie um conjunto para armazenar as linhas únicas
    linhas_unicas = set()

    # Abra o arquivo de entrada e leia as linhas com a codificação UTF-8
    with open(input_file, 'r', newline='', encoding='utf-8') as arquivo_entrada:
        leitor_csv = csv.reader(arquivo_entrada, delimiter=',')
        
        # Pule o cabeçalho se houver
        cabecalho = next(leitor_csv, None)
        
        # Itere pelas linhas do arquivo de entrada
        for linha in leitor_csv:
            # Converta a linha em uma tupla para que ela possa ser adicionada ao conjunto
            tupla_linha = tuple(linha)
            linhas_unicas.add(tupla_linha)

    # Ordene as linhas únicas com base na primeira coluna
    linhas_ordenadas = sorted(linhas_unicas, key=lambda x: x[0])

    # Abra o arquivo de saída e escreva as linhas ordenadas com a codificação UTF-8
    with open(output_file, 'w', newline='', encoding='utf-8') as arquivo_saida:
        escritor_csv = csv.writer(arquivo_saida)
        
        # Escreva o cabeçalho se houver
        if cabecalho:
            escritor_csv.writerow(cabecalho)
        
        # Escreva as linhas ordenadas no arquivo de saída
        for linha in linhas_ordenadas:
            escritor_csv.writerow(linha)

def remover_quebras_de_linha_csv(input_file, output_file, coluna_para_processar):
    # Abre o arquivo CSV de entrada
    with open(input_file, 'r', newline='', encoding='utf-8') as arquivo_entrada:
        leitor_csv = csv.reader(arquivo_entrada)
        
        # Lê o cabeçalho
        cabecalho = next(leitor_csv)
        
        # Obtém o índice da coluna a ser processada
        indice_coluna = cabecalho.index(coluna_para_processar) if coluna_para_processar in cabecalho else None
        
        # Verifica se a coluna existe no cabeçalho
        if indice_coluna is None:
            raise ValueError(f"A coluna '{coluna_para_processar}' não foi encontrada no cabeçalho.")
        
        # Abre o arquivo CSV de saída
        with open(output_file, 'w', newline='', encoding='utf-8') as arquivo_saida:
            escritor_csv = csv.writer(arquivo_saida)
            
            # Escreve o cabeçalho
            escritor_csv.writerow(cabecalho)
            
            # Itera pelas linhas do arquivo de entrada
            for linha in leitor_csv:
                # Remove as quebras de linha na coluna especificada
                linha[indice_coluna] = linha[indice_coluna].replace('\n', ' ')
                
                # Escreve a linha no arquivo de saída
                escritor_csv.writerow(linha)

def ler_csv_inserir_tabela_associado(input_file):
    try:
        conn = psycopg2.connect(
            database="caixa-beneficente",
            user="postgres",
            password="admin",
            host="localhost",
            port="5432"
        )
        cursor = conn.cursor()

        with open(input_file, 'r', newline='', encoding='utf-8') as arquivo_csv:
            try:

                csv_reader = csv.DictReader(arquivo_csv)
                for linha in csv_reader:
                    insert_query = """INSERT INTO public.titular (id, carencia, cpf, data_adesao, data_cancelamento, data_nascimento, estado_civil, falecido, sexo, nome, 
                    conjuge, obs, orgao_exp, rg, tel_principal, melhor_dia, email, bairro, cep, complemento, cidade, logradouro, 
                    numero, uf, nacionalidade, naturalidade, nm_contato, mae, pai, parentesco, status, tel_contato, id_plano)
                    SELECT %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                    WHERE NOT EXISTS (
                        SELECT 1 FROM public.titular WHERE id = %s
                    )"""

                    dataAdesao = formatar_date('DT_ADESAO', linha['DT_ADESAO'])  # date
                    dataCancelamento = formatar_date_time('DT_CANCELAMENTO', linha['DT_CANCELAMENTO'])  # timestamp
                    dataNascimento = formatar_date('Dt_NASC', linha['Dt_NASC'])  # date
                    sexo = formatar_sexo('SEXO', linha['SEXO'])
                    estado_civil = formatar_estado_civil('ESTADO CIVIL', linha['ESTADO_CIVIL'])

                    cursor.execute(insert_query, (
                        linha['ID_ASSOCIADO'], 'false', linha['CPF'], dataAdesao, dataCancelamento, dataNascimento,
                        estado_civil, "false", sexo, linha['NM_ASSOCIADO'], linha['NM_CONJUGE'],
                        linha['OBS'], linha['ORGAO_EXP'], linha['RG'], linha['TEL_PRINCIPAL'], linha['MELHOR_DIA'], "",
                        linha['BAIRRO'], linha['CEP'], linha['COMPLEMENTO'], linha['CIDADE'], linha['ENDERECO'], linha['NU_RESIDENCIA'],
                        linha['UF'], linha['NACIONALIDADE'], linha['NATURALIDADE'], linha['NM_CONTATO'], linha['MAE'], linha['PAI'], linha['PARENTESCO'],
                        "true", linha['TEL_CONTATO'], linha['ID_PLANO_COMERCIAL'],linha['ID_ASSOCIADO']
                    ))
                    conn.commit()
            except psycopg2.Error as e:
                conn.rollback()  # Desfaz a transação em caso de erro
                print(f"Erro ao inserir dados: {e}")
                
    except (psycopg2.Error, Exception) as error:
        print("Erro ao inserir dados:", error)
    finally:
        if conn:
            cursor.close()
            conn.close()

def formatar_date(coluna, data_string):
    try:

        if data_string == "":
            return None

        # Converte a string de data para um objeto datetime usando datetime.strptime
        data_obj = datetime.strptime(data_string, "%d/%m/%Y")

        # Formata o objeto datetime como uma string no formato desejado (sem hora, minuto e segundo)
        data_formatada = data_obj.strftime("%Y-%m-%d")

        return data_formatada
    except ValueError:
        print('O erro ocorreu na coluna ', coluna, ' data ', data_string)
        # Tratamento de erro para o caso de a string de entrada não estar no formato esperado
        return "Formato de data inválido. Use o formato dd/MM/yyyy."
    
def formatar_sexo(coluna, sexo):
    try:

        if sexo == "":
            sexo_formatado = "NI"
        
        if (sexo == "F"):
            sexo_formatado = "FEMININO"

        if (sexo == "M"):
            sexo_formatado = "MASCULINO"
        

        return sexo_formatado
    except ValueError:
        print('O erro ocorreu na coluna ', coluna, ' sexo ', sexo)
        # Tratamento de erro para o caso de a string de entrada não estar no formato esperado
        return "Formato do sexo inválido"

def formatar_estado_civil(coluna, estado_civil):
    try:

        if estado_civil == "":
            estado_civil_formatado = None
        
        if (estado_civil == "CASADO"):
            estado_civil_formatado = "CASADO"

        if (estado_civil == "CASADO(a)"):
            estado_civil_formatado ="CASADO"

        if (estado_civil == "CASADO(a)"):
            estado_civil_formatado ="CASADO"

        if (estado_civil == "CASADO(a)"):
            estado_civil_formatado ="CASADO"

        if (estado_civil == "CASADO(a)"):
            estado_civil_formatado ="CASADO"            

        match estado_civil:
            case "":
                estado_civil_formatado = None

            case "CASADO":
                estado_civil_formatado = "CASADO"

            case "CASADO(a)":
                estado_civil_formatado = "CASADO"
            
            case "DIVORCIADO(a)":
                estado_civil_formatado = "DIVORCIADO"

            case "SOLTEIRO(a)":
                estado_civil_formatado = "SOLTEIRO"

            case "VIÚVO(a)":
                estado_civil_formatado = "VIUVO"
            case _:
                estado_civil_formatado = None

        return estado_civil_formatado
    except ValueError:
        print('O erro ocorreu na coluna ', coluna, ' estado_civil ', estado_civil)
        # Tratamento de erro para o caso de a string de entrada não estar no formato esperado
        return "Formato do estado_civil inválido"

def formatar_date_time(coluna, data_string):
    try:

        if data_string == "":
            return None
        
        # Converte a string de data para um objeto datetime
        data_obj = datetime.strptime(data_string, "%d/%m/%Y")

        # Formata o objeto datetime como uma string no formato desejado
        data_formatada = data_obj.strftime("%Y-%m-%d %H:%M:%S")

        return data_formatada
    except ValueError:
        print('O erro ocorreu na coluna ', coluna, ' data ', data_string)
        # Tratamento de erro para o caso de a string de entrada não estar no formato esperado
        return "Formato de data inválido. Use o formato dd/MM/yyyy."


if __name__ == "__main__":
    input_file = 'associado4_sem_duplicatas.csv'
    ler_csv_inserir_tabela_associado(input_file)
    
    #input_file = 'associado2.csv'  # Substitua pelo nome do seu arquivo de entrada CSV
    #output_file = 'associado3.csv'  # Nome do arquivo de saída CSV
    #coluna_para_processar = 'OBS'  # Substitua pelo nome da coluna que contém as quebras de linha

    #remover_quebras_de_linha_csv(input_file, output_file, coluna_para_processar)

    #input_file = 'associado3.csv'
    #output_file = 'associado4_sem_duplicatas.csv'
    #remove_duplicatas_ordenado(input_file, output_file)

    #formatarDate
    #data = formatar_date("29/05/1998")
    #data = formatar_date_time("29/05/1998")
    #print(data)