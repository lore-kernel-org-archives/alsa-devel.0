From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: [PATCH 0/2] prescript
Date: Thu, 10 Mar 2011 14:53:37 +0100
Message-ID: <1299765219-31386-1-git-send-email-bug-track@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id E5CFE2413F
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2011 15:00:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Alexey Fisher <bug-track@fisher-privat.net>
List-Id: alsa-devel@alsa-project.org

Hall all,

here is small patchset for usb devices with wrong volume resolution.
First one add warning if too big resolution is found.
Second adds quirk for one more webcam.

For more info see patch a5c7d797dcce3be5e77cd6ea62cc4920ededc32b
> Author: Alexey Fisher <bug-track@fisher-privat.net>
> Date:   Wed Jun 23 14:17:09 2010 +0200
> ALSA: usb-audio - Add volume resolution quirk for some Logitech webcams
....

Regards,
	Alexey
