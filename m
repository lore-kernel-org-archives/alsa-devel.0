From: Timur Tabi <timur@freescale.com>
Subject: Re: Confused about 'default' device
Date: Thu, 25 Oct 2007 10:03:21 -0500
Message-ID: <4720B039.9000909@freescale.com>
References: <471E4E2A.9090105@freescale.com> <s5h4pggevv8.wl%tiwai@suse.de>
	<1193225838.26984.1217558213@webmail.messagingengine.com>
	<471F7479.9000602@freescale.com>
	<1193295747.4869.1217732745@webmail.messagingengine.com>
	<4720A53E.5010801@freescale.com>
	<1193324526.17328.1217803511@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id BFE8424766
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Oct 2007 17:03:25 +0200 (CEST)
In-Reply-To: <1193324526.17328.1217803511@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

> mplayer disables ALSA's sample rate conversion and always uses its own.

I don't think that's true.  If it always uses its own, then how much it works on 
some video files and not others, and how come including a .asoundrc changes the 
behavior of mplayer?
