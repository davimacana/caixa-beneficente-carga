# -*- coding: utf-8 -*-

import psycopg2

con = psycopg2.connect(database="caixa-beneficente", user="postgres", password="admin", host="localhost", port="5432")

if con.isexecuting:
    print("Conectou: ")
    cursor = con.cursor()
    cursor.execute("SELECT * FROM ALUNO")
    result = cursor.fetchall()
    print("Result Set: ", "\n", result)

if con.isexecuting:
    cursor.close()
    con.close()
    print("Finalizando a conexão ao PostgreSQL")
