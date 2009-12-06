From: Gabriel =?utf-8?b?WsO2bGxlcg==?= <gabriel.donald@web.de>
Subject: Re: About TASCAM US-122 mkII support
Date: Sun, 6 Dec 2009 22:10:44 +0000 (UTC)
Message-ID: <loom.20091206T230842-580@post.gmane.org>
References: <4B16A363.50503@mail.desy.de>
	<200912030059.25060.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id B0F1824499
	for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2009 15:10:08 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NHeHs-000416-Rp
	for alsa-devel@alsa-project.org; Mon, 07 Dec 2009 15:10:04 +0100
Received: from i5882D209.versanet.de ([i5882D209.versanet.de])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 07 Dec 2009 15:10:04 +0100
Received: from gabriel.donald by i5882D209.versanet.de with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 07 Dec 2009 15:10:04 +0100
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

Karsten Wiese <fzu <at> wemgehoertderstaat.de> writes:

> 
> Am Mittwoch 02 Dezember 2009 schrieb Alberto Martinez de la Ossa:
> > Unfortunately, the new model (US-122 mkII), the one I have, is not 
> > supported yet.
> 
> hallo alberto,
> 
> please post the output of
> $ lsusb
> while the new device is plugged.
> 
> maybe it suffices to just add it's id to the us122l driver.
> 
> karsten
> 

Hi,
I also have the US-122 mkII and
# lsusb
says
Bus 001 Device 009: ID 0644:8021 TEAC Corp.

Gabriel
