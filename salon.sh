#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

echo "Bem-vindo ao Salão!"

# Função para listar serviços
LIST_SERVICES() {
  echo "Escolha um serviço:"
  SERVICES=$($PSQL "SELECT service_id, name FROM services")
  echo "$SERVICES" | while IFS="|" read SERVICE_ID SERVICE_NAME; do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
}

# Loop até que o usuário escolha um serviço válido
while true; do
  LIST_SERVICES
  read SERVICE_ID_SELECTED

  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")

  if [[ -n $SERVICE_NAME ]]; then
    break
  else
    echo "Serviço inválido. Tente novamente."
  fi
done

# Pedir telefone do cliente
echo "Digite seu telefone:"
read CUSTOMER_PHONE

# Verificar se o cliente já existe
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

if [[ -z $CUSTOMER_NAME ]]; then
  echo "Digite seu nome:"
  read CUSTOMER_NAME
  $PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')"
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
fi

# Obter o ID do cliente
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

# Pedir horário do serviço
echo "Digite o horário do serviço:"
read SERVICE_TIME

# Inserir agendamento
$PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')"

# Mensagem de confirmação correta
echo "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."