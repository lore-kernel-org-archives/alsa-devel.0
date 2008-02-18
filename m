From: Brian Austin <brian.austin@cirrus.com>
Subject: Cirrus Logic CS42L52 Low power codec
Date: Mon, 18 Feb 2008 08:17:53 -0600
Message-ID: <1203344273.4063.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound3-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	by alsa0.perex.cz (Postfix) with ESMTP id EC10B1038F1
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 15:22:27 +0100 (CET)
Received: from outbound3-va3.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound3-va3-R.bigfish.com (Postfix) with ESMTP id 49F1D6E8894
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 14:19:24 +0000 (UTC)
Received: from mail114-va3-R.bigfish.com (si1-va3 [10.7.14.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by outbound3-va3.bigfish.com (Postfix) with ESMTP id 484321380064
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 14:19:24 +0000 (UTC)
Received: from mail114-va3 (localhost.localdomain [127.0.0.1])
	by mail114-va3-R.bigfish.com (Postfix) with ESMTP id 31114ED047F
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 14:19:24 +0000 (UTC)
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail114-va3.bigfish.com (Postfix) with ESMTP id 06C707F007E
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 14:19:23 +0000 (UTC)
Received: from CLMSG-01.ad.cirrus.com ([198.61.95.37])
	by mail1.cirrus.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1IEBwvu027602
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 08:11:58 -0600
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I have a codec I would like to submit.  The Cirrus Logic CS42L52 Low
Power codec.  I have the codec code as well as the machine code for the
Cirrus Logic EP9407A, but cannot submit that yet.  Is it OK to just
submit the codec code for now?  This does not use the new API, so a hint
as to which tree to make the diff from would help.

Thanks,

Brian Austin
