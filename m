From: =?ISO-8859-1?Q?J=F6rg?= Krause <joerg.krause@embedded.rocks>
Subject: Toggle GPIO if ALSA playbacks begins or ends
Date: Thu, 25 Aug 2016 20:27:48 +0200
Message-ID: <1472149668.24475.10.camel@embedded.rocks>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 690F526717B
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2016 20:28:01 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 3sKt2d3mfCz105v
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2016 20:27:50 +0200 (CEST)
Received: from mail.embedded.rocks ([127.0.0.1])
 by localhost (mail.embedded.rocks [127.0.0.1]) (amavisd-new, port 10025)
 with ESMTP id fqxZA8LCkFFa for <alsa-devel@alsa-project.org>;
 Thu, 25 Aug 2016 20:27:49 +0200 (CEST)
Received: from nzxt.fritz.box (x2f774f1.dyn.telefonica.de [2.247.116.241])
 (Authenticated sender: joerg.krause@embedded.rocks)
 by mail.embedded.rocks (Postfix) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2016 20:27:49 +0200 (CEST)
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

SGksCgpJIGFtIGxvb2tpbmcgZm9yIGEgd2F5IHRvIHRvZ2dsZSBhIEdQSU8gaWYgQUxTQSBpcyBh
Ym91dCB0byBwbGF5IG9yIGhhcwpzdG9wcGVkIHRvIHR1cm4gYW4gZXh0ZXJuYWwgYW1wbGlmaWVy
IG9uL29mZi4KCkNhbiBpdCBiZSBkb25lIHVzaW5nIGxpYmFzb3VuZCBvciBjYW4gSSB1c2UgYSBw
bHVnaW4gb3Igd3JpdGUgb25lPwoKQmVzdCByZWdhcmRzCkrDtnJnIEtyYXVzZQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
