From: Stas Sergeev <stsp@aknet.ru>
Subject: how to mandate the use of PCM plugin?
Date: Sun, 26 Sep 2010 19:17:29 +0400
Message-ID: <4C9F6409.6010400@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 92E692437D
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Sep 2010 17:18:35 +0200 (CEST)
Received: from ppp83-237-126-11.pppoe.mtu-net.ru ([83.237.126.11])
	by mail.aknet.ru with esmtpa (Exim 4.63)
	(envelope-from <stsp@aknet.ru>) id 1Ozszn-0007KC-Q5
	for alsa-devel@alsa-project.org; Sun, 26 Sep 2010 19:18:31 +0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  Hi guys.

Is it possible to somehow mandate the
use of a PCM plugin? For example, the
PC-Speaker.conf defines the use of softvol
plugin for "default" and "front" devices.
It is still possible for the software to bypass
it by the use of "hw", and some software
does exactly that.
Is it possible to somehow make some
plugin a mandatory?
