From: "Ash Willis" <ashwillis@programmer.net>
Subject: No sound on nVidia MCP61 - snd-hda-intel
Date: Fri, 9 May 2008 17:14:09 -0500
Message-ID: <20080509221409.6CFF8164293@ws1-4.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 35665243A0
	for <alsa-devel@alsa-project.org>;
	Sat, 10 May 2008 00:14:12 +0200 (CEST)
Received: from wfilter.us4.outblaze.com.int (wfilter.us4.outblaze.com.int
	[192.168.9.180])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	8E17F1800129
	for <alsa-devel@alsa-project.org>; Fri,  9 May 2008 22:14:09 +0000 (GMT)
Content-Disposition: inline
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

Hi everyone,
I have a motherboard with an integrated MCP61. The device is detected and I have mixer controls but I get no sound output whatsoever. I'm using alsa-hg and I have a little experience with writing drivers for ALSA but I won't pretend to know anything about the hda driver. If someone could give me a little direction, I'd be happy to help get this problem sorted. I don't mind hacking on the driver. I just figured it was best to ask for advice first, seeing as it might be an easy problem for someone else to diagnose.

alsa-info.sh output can be found here:

http://pastebin.ca/1013173

Thanks,
Ash

-- 
See Exclusive Video: 10th Annual Young Hollywood Awards
http://www.hollywoodlife.net/younghollywoodawards2008/
