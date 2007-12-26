From: De Fuuss <fuuss@hotmail.com>
Subject: intel-hd on an intel G33 motherboard
Date: Wed, 26 Dec 2007 18:42:45 +0000
Message-ID: <BAY109-W10EC413FC1F19625739A28A95B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc2-s6.bay0.hotmail.com (bay0-omc2-s6.bay0.hotmail.com
	[65.54.246.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D05A1037F2
	for <alsa-devel@alsa-project.org>; Wed, 26 Dec 2007 19:42:46 +0100 (CET)
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


Hi,

Maybe I'm missing something, but I've failed to get even the slightest noise out of the onboard sound card from a Intel G33 motherboard. I tried the alsa drivers from the alsa-driver-1.0.15 package as well as the the alsa drivers provided by kernel 2.6.23 (built as modules), to no avail.

The sound chip is identified as a Intel HDA / Realtek ALC888 on the Intel G33 ICH9 motherboard.

After reading some of the documentation from the ALSA site and googling through half the internet I haven't found out yet if this specific sound card is supported by ALSA and if some module options must be passed (such as options snd-intel-hda model=.....).

Could somebody be so kind as to point me into the right direction?

Thank you.

Best regards,

Patrick

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
