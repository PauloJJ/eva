/**
 * ESSE CODIGO NUNCA FOI TESTADO OU ENVIADO PARA FIREBASE, ELE FOI ATUALIZADO
 */

const { onCall } = require("firebase-functions/v2/https");
const { logger } = require("firebase-functions");
const { initializeApp } = require("firebase-admin/app");

const twilio = require("twilio");
const sgMail = require("@sendgrid/mail");

initializeApp();

// const clientTwilio = twilio(accountSid, authToken);
// sgMail.setApiKey(sendGridApiKey);

exports.sendSms = onCall(
    {
        secrets: ["TWILIO_ACCOUNT_SID", "TWILIO_AUTH_TOKEN"],
    },
    async (request) => {
        const listNumber = request.data[0]["numbers"];
        const userName = request.data[0]["userName"];
        const latitude = request.data[0]["latitude"];
        const longitude = request.data[0]["longitude"];

        if (!Array.isArray(listNumber) || listNumber.length === 0) {
            logger.info("============= LISTA É NULL, VAZIA OU NÃO É LISTA =============");
            return { success: false };
        }

        const clientTwilio = twilio(
            process.env.TWILIO_ACCOUNT_SID,
            process.env.TWILIO_AUTH_TOKEN
        );

        for (const number of listNumber) {
            await clientTwilio.messages.create({
                body: `${userName} precisa da sua ajuda!\n\nLocalização atual: https://www.google.com/maps?q=${latitude},${longitude}\n\n${userName} acionou o botão SOS no app Eva e precisa do seu apoio agora. Entre em contato com ela o mais rápido possível e, se necessário, acione as autoridades.`,
                from: "+18147871916",
                to: number,
            });
        }

        return { success: true };
    }
);

exports.sendEmail = onCall(
    {
        secrets: ["SENDGRID_API_KEY"],
    },
    async (request) => {
        const listEmail = request.data[0]["listEmail"];
        const userName = request.data[0]["userName"];
        const linkMapa = request.data[0]["linkMapa"];

        if (!Array.isArray(listEmail) || listEmail.length === 0) {
            logger.info("============= LISTA EMAIL É NULL, VAZIA OU NÃO É LISTA =============");
            return { success: false };
        }

        sgMail.setApiKey(process.env.SENDGRID_API_KEY);

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
    }
);
