From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: volume scaling of usb audio class headset
Date: Fri, 24 Oct 2008 19:35:28 +0200
Message-ID: <49020760.9080900@powercraft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node03.cambriumhosting.nl (node03.cambriumhosting.nl
	[217.19.16.164]) by alsa0.perex.cz (Postfix) with ESMTP id D6A79245BA
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 19:35:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by node03.cambriumhosting.nl (Postfix) with ESMTP id 7FB32B0002EC
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 19:35:30 +0200 (CEST)
Received: from node03.cambriumhosting.nl ([127.0.0.1])
	by localhost (node03.cambriumhosting.nl [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id j6vMAhtcn1vQ for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 19:35:30 +0200 (CEST)
Received: from ashley.powercraft.nl (84-245-3-195.dsl.cambrium.nl
	[84.245.3.195])
	by node03.cambriumhosting.nl (Postfix) with ESMTP id 00730B0002A7
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 19:35:29 +0200 (CEST)
Received: from [192.168.1.180] (unknown [192.168.1.180])
	by ashley.powercraft.nl (Postfix) with ESMTPSA id CC92123BC65C
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 19:35:29 +0200 (CEST)
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

Hello everybody,

I got a question, I got a few usb headsets that seem to apply to the usb
audio class and the volume scale is way to big with alsa. with the
control on 10 of the 100 you are almost getting deaf. So my question is
how does alsa make an scaling for such devices and how to fix it so that
the full range can be used in a normal volume spectrum.

Thank in advance,

Jelle
