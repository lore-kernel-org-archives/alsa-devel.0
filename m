From: Rene Herman <rene.herman@gmail.com>
Subject: ICE1712/1724 HW mixing?
Date: Wed, 16 May 2007 03:24:58 +0200
Message-ID: <464A5D6A.9020104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CDC8248B7
	for <alsa-devel@alsa-project.org>;
	Wed, 16 May 2007 03:27:39 +0200 (CEST)
Received: from [213.51.130.190] (port=54109 helo=smtp1.groni1.gr.home.nl)
	by smtpq2.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1Ho8Ik-0003b7-SU
	for alsa-devel@alsa-project.org; Wed, 16 May 2007 03:27:38 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:35165
	helo=[192.168.0.3]) by smtp1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1Ho8Ii-0006IG-4r
	for alsa-devel@alsa-project.org; Wed, 16 May 2007 03:27:36 +0200
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

Good day.

I've been updating the TerraTec vendor page in the new wiki matrix:

http://bugtrack.alsa-project.org/main/index.php/Matrix:Vendor-Terratec

The problem with information that looks maintained though is that when 
something's _not_ mentioned, it might be interpreted to mean it's not 
actually working....

I have the older TerraTec cards (both ISA and PCI) but not any of the 
ICE1712/ICE1724 ones. Could someone verify/confirm that the ICE1712 
(Envy24?) does not support 24-bit samples?

And that ICE1724 supports only 32-bit in hardware?

Does either chip/driver support hardware mixing?

Filling out some of the Digital I/O tags for any Aureon card that you know 
would be nice as well.

Rene.
