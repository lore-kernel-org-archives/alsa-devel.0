From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Subject: Master channel is only mono
Date: Wed, 29 Jul 2009 17:11:59 +0200
Message-ID: <4A7066BF.9000603@molgaard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.nfit.au.dk (nfitmail.nfit.au.dk [130.225.31.129])
	by alsa0.perex.cz (Postfix) with ESMTP id 801CE24921
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 17:12:19 +0200 (CEST)
Received: from mfe04.daimi.au.dk (localhost [127.0.0.1])
	by smtp.nfit.au.dk (Postfix) with ESMTP id 93D471D2F5B
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 17:12:18 +0200 (CEST)
Received: from [62.199.96.168] ([62.199.96.168]) (authenticated bits=0)
	by mfe04.daimi.au.dk (8.13.8/8.13.8) with ESMTP id n6TFC02c012969
	for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2009 17:12:14 +0200
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

As per gnubien's advice on #alsa on irc.freenode.net, I have run =

alsa-info.sh - the URL is =

http://www.alsa-project.org/db/?f=3Dfbe93f301ca214007e66c521cd6c41a17a604c7=
9 .

My problem is that the master channel for my card is shown to be mono =

only, which I don't think seems right...

Also, sound in general is rather low.

My system is a very new Dell Studio laptop - I have loaded snd-hda-intel =

with mode=3Ddell-m6 as per the kernel documentation.

Best regards,

Sune M=F8lgaard
