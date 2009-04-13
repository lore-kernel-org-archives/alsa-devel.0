From: James Gauld <james@thundermonkey.net>
Subject: Help required. Slax OS, no audio, multiple cards, hdmi
Date: Mon, 13 Apr 2009 16:09:20 +0100
Message-ID: <49E355A0.1080106@thundermonkey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out5.blueyonder.co.uk (smtp-out5.blueyonder.co.uk
	[195.188.213.8]) by alsa0.perex.cz (Postfix) with ESMTP id 0EAB82450C
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Apr 2009 17:09:23 +0200 (CEST)
Received: from [172.23.170.138] (helo=anti-virus01-09)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1LtNmk-0008JC-I2
	for alsa-devel@alsa-project.org; Mon, 13 Apr 2009 16:09:22 +0100
Received: from [82.39.153.172] (helo=[192.168.2.3])
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1LtNmi-0000aA-0R
	for alsa-devel@alsa-project.org; Mon, 13 Apr 2009 16:09:20 +0100
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

Hi all,

My first post and of course it's a help request, sorry ...

I've got a fresh install of Slax 6.10 with the latest alsa packages as 
available on slackware. Here's the result of alsa-info.sh:

http://www.alsa-project.org/db/?f=01356b864296bea4beb140b73cf41cbf84158997

My hardware:
Samsung TV with integrated PC (model: LH32MGTLBC)
2 onboard audio devices, one of which is Radeon HD3200/RS780

This machine has windows xp embedded through which I can get audio 
output via the HDMI device.

However, running slax (from usb) I cannot get any sound from either 
device, but I'm only interested in the HDMI card (card #1) which 
delivers output to the integrated speakers (as far as I can tell from 
windows).

I've tried from console and various widgets in KDE with no success.

I've searched all week with no solutions working.

If anyone can help me out with this I'd be incredibly grateful

Thanks
James
