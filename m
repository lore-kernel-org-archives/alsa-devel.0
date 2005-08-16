From: John Shillinglaw <ianchas@sc.rr.com>
Subject: Writing alsa driver for Roland Sound Canvas SCP-55 pcmcia card
Date: Tue, 16 Aug 2005 07:43:25 -0400
Message-ID: <1124192606.15433.5.camel@Pippin>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ms-smtp-03-eri0.southeast.rr.com (ms-smtp-03-lbl.southeast.rr.com [24.25.9.102])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 06ECF1FB
	for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2005 13:43:30 +0200 (MEST)
Received: from [192.168.1.25] (cpe-065-188-052-217.sc.res.rr.com [65.188.52.217])
	by ms-smtp-03-eri0.southeast.rr.com (8.12.10/8.12.7) with ESMTP id j7GBhRY4000812
	for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2005 07:43:28 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I am starting to write a driver for Roland's SCP-55 pcmcia sound card
( midi port at 330, 2 channels of audio play/record, and internal GM
synth ).

I have the old drivers from the person who was previously working on a
driver for this card, and have found the driver writing documentation
from alsa-project.org which focuses on pci cards.

Can anyone point me to resources and help for developing an alsa driver
for a pcmcia card?

Thanks,
John Shillinglaw



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
