From: The Source <thesourcehim@gmail.com>
Subject: X-Fi notebook support
Date: Wed, 30 Dec 2009 10:37:00 +0300
Message-ID: <4B3B031C.5060202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f212.google.com (mail-ew0-f212.google.com
	[209.85.219.212])
	by alsa0.perex.cz (Postfix) with ESMTP id C9BA3245AD
	for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2009 08:37:02 +0100 (CET)
Received: by ewy4 with SMTP id 4so48006409ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2009 23:37:02 -0800 (PST)
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

Hello. I have some info on that card, but not much. I have discovered 
that this card is detected connected via USB rather than PCI-E (the slot 
is ExpressCard). snd_ctxfi uses PCI interfaces right? Can X-Fi support 
be also added to snd_usb_audio? Or can snd_ctxfi support USB?
