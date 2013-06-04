From: Ivan Bolsunov <bolsunov@telum.ru>
Subject: dsnoop memory leak
Date: Tue, 4 Jun 2013 17:33:36 +0400 (MSK)
Message-ID: <1177532444.4770.1370352816940.JavaMail.root@telum.ru>
References: <370949076.4726.1370352588794.JavaMail.root@telum.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.telum.ru (mail.telum.ru [62.141.76.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 92D89265122
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 15:33:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.telum.ru (Postfix) with ESMTP id E2F6A480183
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 17:33:37 +0400 (MSK)
Received: from mail.telum.ru ([127.0.0.1])
 by localhost (mail.telum.ru [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id TJA-4TWRxCsx for <alsa-devel@alsa-project.org>;
 Tue,  4 Jun 2013 17:33:37 +0400 (MSK)
Received: from mail.telum.ru (mail.telum.ru [127.0.1.1])
 by mail.telum.ru (Postfix) with ESMTP id 084B048002A
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 17:33:37 +0400 (MSK)
In-Reply-To: <370949076.4726.1370352588794.JavaMail.root@telum.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi guys, on may 31 I sent message, can you at least confirm what bug exist?
Thanks.
