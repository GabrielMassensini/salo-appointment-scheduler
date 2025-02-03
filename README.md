# Salon Database Project

Este projeto é um desafio do site FreeCodeCamp sobre bancos de dados relacionais (Relational Database). Trata-se de um sistema de agendamento para um salão de beleza, utilizando um banco de dados PostgreSQL e um script Bash para interações com os clientes.

## 📌 Requisitos do Banco de Dados

O banco de dados deve conter as seguintes tabelas:

### 1. **Tabela `customers`**
- `customer_id` (SERIAL PRIMARY KEY)
- `name` (VARCHAR, não nulo)
- `phone` (VARCHAR, único, não nulo)

### 2. **Tabela `services`**
- `service_id` (SERIAL PRIMARY KEY)
- `name` (VARCHAR, não nulo)

### 3. **Tabela `appointments`**
- `appointment_id` (SERIAL PRIMARY KEY)
- `customer_id` (INTEGER, FOREIGN KEY referenciando `customers(customer_id)`)
- `service_id` (INTEGER, FOREIGN KEY referenciando `services(service_id)`)
- `time` (VARCHAR, não nulo)

## 📜 Script `salon.sh`
O script Bash `salon.sh` gerencia os agendamentos do salão e segue as regras:

- Exibe a lista de serviços disponíveis.
- Solicita que o cliente escolha um serviço válido.
- Solicita o telefone do cliente.
- Se o telefone não existir, solicita o nome e cria um novo cliente.
- Solicita o horário do agendamento.
- Registra o agendamento no banco de dados.
- Exibe uma mensagem confirmando o agendamento no formato:
  
  ```
  I have put you down for a <service> at <time>, <name>.
  ```

## 🛠️ Como Criar e Popular o Banco de Dados

1. Acesse o PostgreSQL:
   ```sh
   psql --username=freecodecamp --dbname=postgres
   ```
2. Crie o banco de dados:
   ```sql
   CREATE DATABASE salon;
   ```
3. Conecte-se ao banco:
   ```sh
   psql --username=freecodecamp --dbname=salon
   ```
4. Crie as tabelas:
   ```sql
   CREATE TABLE customers (
     customer_id SERIAL PRIMARY KEY,
     name VARCHAR NOT NULL,
     phone VARCHAR UNIQUE NOT NULL
   );

   CREATE TABLE services (
     service_id SERIAL PRIMARY KEY,
     name VARCHAR NOT NULL
   );

   CREATE TABLE appointments (
     appointment_id SERIAL PRIMARY KEY,
     customer_id INT REFERENCES customers(customer_id),
     service_id INT REFERENCES services(service_id),
     time VARCHAR NOT NULL
   );
   ```
5. Adicione serviços iniciais:
   ```sql
   INSERT INTO services (name) VALUES ('Corte'), ('Coloração'), ('Manicure');
   ```

## 💾 Salvando o Progresso
Para salvar o banco de dados, execute:
```sh
pg_dump -cC --inserts -U freecodecamp salon > salon.sql
```
Para restaurar o banco de dados, utilize:
```sh
psql -U postgres < salon.sql
```

## 🚀 Executando o Script
Certifique-se de que `salon.sh` tem permissão de execução:
```sh
chmod +x salon.sh
```
Execute o script:
```sh
./salon.sh
```
