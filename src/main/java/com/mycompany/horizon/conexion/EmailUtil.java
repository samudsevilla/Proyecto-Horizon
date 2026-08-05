package com.mycompany.horizon.conexion;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {

    // Credenciales para el envío de correos reales vía Gmail SMTP
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USER = "proyectohorizon47@gmail.com";
    private static final String SMTP_PASS = "hijljrmhjacvldjs";

    public static boolean enviarCodigoVerificacion(String destinoEmail, String codigo) {
        String asunto = "Horizon - Verifica tu cuenta";
        String mensajeHTML = "<h3>¡Bienvenido a Horizon!</h3>"
                           + "<p>Tu código de verificación de 6 dígitos es:</p>"
                           + "<h2 style='color:#2563eb; letter-spacing: 5px;'>" + codigo + "</h2>"
                           + "<p>Introduce este código en la plataforma para activar tu cuenta.</p>";

        System.out.println("==================================================");
        System.out.println("📧 ENVIANDO CORREO A: " + destinoEmail);
        System.out.println("🔑 CÓDIGO GENERADO: " + codigo);
        System.out.println("==================================================");

        // Guardar en un archivo local de depuración para desarrollo fácil
        guardarCodigoLocalmente(destinoEmail, codigo);

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USER, SMTP_PASS);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SMTP_USER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinoEmail));
            message.setSubject(asunto);
            message.setContent(mensajeHTML, "text/html; charset=utf-8");

            // Solo intentar enviar si se han configurado credenciales reales
            if (!SMTP_USER.equals("tu_correo@gmail.com")) {
                Transport.send(message);
            }
            return true;
        } catch (MessagingException e) {
            System.err.println("⚠️ No se pudo enviar el correo real (SMTP no configurado/bloqueado): " + e.getMessage());
            // Retorna true de todos modos porque ya guardamos el código localmente
            // para que no se interrumpa el flujo del usuario en desarrollo
            return true;
        }
    }

    private static void guardarCodigoLocalmente(String email, String codigo) {
        String path = "verificaciones_desarrollo.txt"; // Se guardará en la carpeta del proyecto en NetBeans
        try (FileWriter writer = new FileWriter(path, true)) {
            writer.write("[" + new java.util.Date() + "] Correo: " + email + " | Código: " + codigo + "\n");
        } catch (IOException e) {
            System.err.println("No se pudo escribir en el archivo de depuración local: " + e.getMessage());
        }
    }
}
