/**
 * ESSE CODIGO NUNCA FOI TESTADO OU ENVIADO PARA FIREBASE, ELE FOI ATUALIZADO
 */

const { onCall } = require("firebase-functions/v2/https");
const { logger } = require("firebase-functions");
const { initializeApp } = require("firebase-admin/app");
const { defineSecret } = require("firebase-functions/params");


const twilio = require("twilio");
const sgMail = require("@sendgrid/mail");

const axios = require("axios");

initializeApp();


const twilioAccountSid = defineSecret("TWILIO_ACCOUNT_SID");
const twilioAuthToken = defineSecret("TWILIO_AUTH_TOKEN");
const sendGridApiKey = defineSecret("SENDGRID_API_KEY");

const clientIdGov = defineSecret("CLIENT_ID_GOV");
const clientSecretGov = defineSecret("CLIENT_SECRET_GOV");

exports.sendSms = onCall(
    {
        secrets: ["TWILIO_ACCOUNT_SID", "TWILIO_AUTH_TOKEN"],
    },
    async (request) => {


        logger.info("SID EXISTE?", twilioAccountSid.value());
        logger.info("TOKEN EXISTE?", twilioAuthToken.value());

        const listNumber = request.data[0]["numbers"];
        const userName = request.data[0]["userName"];
        const latitude = request.data[0]["latitude"];
        const longitude = request.data[0]["longitude"];

        if (!Array.isArray(listNumber) || listNumber.length === 0) {
            logger.info("============= LISTA É NULL, VAZIA OU NÃO É LISTA =============");
            return { success: false };
        }

        const clientTwilio = twilio(
            twilioAccountSid.value(),
            twilioAuthToken.value(),
        );

        for (const number of listNumber) {
            await clientTwilio.messages.create({
                body: `${userName} precisa da sua ajuda!\n\nLocalização atual: https://www.google.com/maps?q=${latitude},${longitude}\n\n${userName} acionou o botão SOS no app Eva e precisa do seu apoio agora. Entre em contato com ela o mais rápido possível e, se necessário, acione as autoridades.`,
                from: "+18147871916",
                to: number,
            });
        }

        return { success: true };
    },
);

exports.sendEmail = onCall(
    {
        secrets: ["SENDGRID_API_KEY"],
    },
    async (request) => {

        logger.info("SENDGRID_API_KEY?", sendGridApiKey.value());


        const listEmail = request.data[0]["listEmail"];
        const userName = request.data[0]["userName"];
        const linkMapa = request.data[0]["linkMapa"];

        if (!Array.isArray(listEmail) || listEmail.length === 0) {
            logger.info("============= LISTA EMAIL É NULL, VAZIA OU NÃO É LISTA =============");
            return { success: false };
        }

        sgMail.setApiKey(sendGridApiKey.value());

        for (const email of listEmail) {
            try {
                const msg = {
                    to: email,
                    from: "sosativado@evaapp.site",
                    templateId: "d-c5bbe882071345b6be16fd4fabeac988",
                    dynamicTemplateData: {
                        userName,
                        linkMapa,
                    },
                };

                await sgMail.send(msg);
            } catch (error) {
                logger.error("============= ERRO NO E-MAIL =============", {
                    email,
                    error,
                });
            }
        }

        return { success: true };
    },
);

exports.consultApiGov =
    onCall({
        region: "us-central1",
        vpcConnector: "conector-api-gov-criminal",
        vpcConnectorEgressSettings: "ALL_TRAFFIC",
        timeoutSeconds: 60,
        memory: "512MiB",
        secrets: ["CLIENT_ID_GOV", "CLIENT_SECRET_GOV"],
    }, async (req) => {

        try {
            // ETAPA 1: Obter o Token OAuth2
            // Use a URL de homologação (h-apigateway) ou produção conforme o seu caso
            const tokenUrl = "https://apigateway.conectagov.estaleiro.serpro.gov.br/oauth2/jwt-token";

            const authHeader = Buffer.from(`${clientIdGov.value()}:${clientSecretGov.value()}`).toString("base64");

            const tokenResponse = await axios.post(tokenUrl, "grant_type=client_credentials", {
                headers: {
                    "Authorization": `Basic ${authHeader}`,
                    "Content-Type": "application/x-www-form-urlencoded",
                },
            });

            logger.info(`TOKEN GERADO ======================== ${JSON.stringify(tokenResponse.data)}`);

            const accessToken = tokenResponse.data.access_token;

            // ETAPA 2: Consultar a API Criminal
            const response = await axios.post("https://apigateway.conectagov.estaleiro.serpro.gov.br/api-antecedentes-criminais/v1/cac/gerar-cac", {
                cabecalho: {
                    orgaoSolicitante: "MINISTERIO DA JUSTICA",
                    paisSolicitante: "BRA",
                    sistema: "SISMIG",
                    cnpjSolicitante: "18715532000170",
                },
                nome: req.data["name"],
                dtNascimento: req.data["dateOfBirth"],
                cpf: req.data["cpf"],
                nomeMae: req.data["mothersName"],
                nomePai: req.data["fathersName"],
            }, {
                headers: {
                    "Authorization": `Bearer ${accessToken}`,
                    "x-cpf-usuario": req.data["userCpf"], // Obrigatório para auditoria do governo [1]
                    "Content-Type": "application/json",
                },
            });

            logger.info(`NADA CONSTA ======================== ${JSON.stringify(response.data)}`);

            return { "message": response.data["mensagem"], "status": response.status };

        } catch (error) {
            console.error("Erro na integração:", error.response ? error.response.data : error.message);
            return { "status": error.status };
        }
    });
