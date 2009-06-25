From: "Didier \"Ptitjes\"" <ptitjes@free.fr>
Subject: Support for MSM7 in ASoC
Date: Thu, 25 Jun 2009 12:23:07 +0200
Message-ID: <4A43500B.5050605@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp21.services.sfr.fr (smtp21.services.sfr.fr [93.17.128.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FA31103837
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 12:23:10 +0200 (CEST)
Received: from filter.sfr.fr (localhost [127.0.0.1])
	by msfrf2118.sfr.fr (SMTP Server) with ESMTP id CA3AE700009C
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 12:23:07 +0200 (CEST)
Received: from [192.168.1.200] (212.73.198-77.rev.gaoland.net [77.198.73.212])
	by msfrf2118.sfr.fr (SMTP Server) with ESMTP id AECA0700008C
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 12:23:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello all,

I'm working together with FreeSmartphone.org and SHR. We would like to
support the MSM7-based phones.

We already have the modem working, but audio is a show-stopper for us,
as actual implementation of the audio subsystem in Android is in binary
form, and does not us Alsa !!!

Can someone look at the specs for the MSM7200A specs and tell whether it
could be difficult to support its audio subsystem ?

Thanks for your help,
Didier.
